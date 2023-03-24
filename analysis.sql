/*

After cleaning the data we do an analysis to answer some simple questions 

*/

-- How many employees do the companies have today?

SELECT COUNT(DISTINCT employee_id) AS employee_count 
FROM df_employee
WHERE pay_month = (SELECT MAX(pay_month) FROM df_employee)

-- Group them by company

SELECT company_name, COUNT(DISTINCT employee_id) AS employee_count
FROM df_employee
WHERE pay_month = (SELECT MAX(pay_month) FROM df_employee)
GROUP BY company_name
ORDER BY employee_count DESC

------------------------------------------------------------------------------------------------------------------------------------------------

-- What is the total number of employees each city? Add a percentage column

SELECT company_city, 
	   COUNT(employee_id) AS employee_count,
	   COUNT(employee_id) * 100 / SUM(COUNT(employee_id)) OVER () AS percentage
FROM df_employee
WHERE pay_month = (SELECT MAX(pay_month) FROM df_employee)
GROUP BY company_city
ORDER BY employee_count DESC

------------------------------------------------------------------------------------------------------------------------------------------------

-- What is the total number of employees each month?

SELECT pay_month, COUNT(DISTINCT employee_id) AS employee_count 
FROM df_employee
GROUP BY pay_month
ORDER BY pay_month ASC

------------------------------------------------------------------------------------------------------------------------------------------------

-- What is the average number of employees each month?

SELECT (COUNT(employee_id) / COUNT(DISTINCT pay_month)) AS avg_employees_per_month
FROM df_employee

------------------------------------------------------------------------------------------------------------------------------------------------

-- What is the minimum and maximum number of employees throughout all the months? In which months were they?

SELECT TOP (1) pay_month, COUNT(employee_id) AS count_employees_per_month
FROM df_employee
GROUP BY pay_month
ORDER BY count_employees_per_month ASC


SELECT TOP (1) pay_month, COUNT(employee_id) AS count_employees_per_month
FROM df_employee
GROUP BY pay_month
ORDER BY count_employees_per_month DESC

------------------------------------------------------------------------------------------------------------------------------------------------

-- What is the monthly average number of employees by function group?

SELECT function_group, (COUNT(employee_id) / COUNT(DISTINCT pay_month)) AS avg_employees_per_month
FROM df_employee
GROUP BY function_group
ORDER BY avg_employees_per_month DESC

------------------------------------------------------------------------------------------------------------------------------------------------

-- What is the annual average salary?

SELECT LEFT(pay_month, 4) AS year, ROUND(AVG(salary),2) AS average_salary
FROM df_employee
GROUP BY LEFT(pay_month, 4)
ORDER BY year

-- What is the monthly average salary?

SELECT pay_month, ROUND(AVG(salary),2) AS average_salary
FROM df_employee
GROUP BY pay_month
ORDER BY pay_month

-- What is the average salary by city?

SELECT company_city, 
	   ROUND(AVG(salary),2) AS average_salary
FROM df_employee
GROUP BY company_city
ORDER BY average_salary DESC

-- What is the average salary by state?

SELECT company_state, ROUND(AVG(salary),2) AS average_salary
FROM df_employee
GROUP BY company_state
ORDER BY average_salary DESC

-- What is the  average salary by function group?

SELECT function_group, ROUND(AVG(salary),2) AS average_salary
FROM df_employee
GROUP BY function_group
ORDER BY average_salary DESC

------------------------------------------------------------------------------------------------------------------------------------------------

-- What are the employees with the top 10 highest salaries in average?

SELECT TOP (10) employee_name, ROUND(AVG(salary),2) AS average_salary
FROM df_employee
WHERE pay_month = (SELECT MAX(pay_month) FROM df_employee)
GROUP BY employee_name
ORDER BY average_salary DESC

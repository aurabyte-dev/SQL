/* ==============

Aggregation

============== */

/* ==============

TASK 6

Now the stakeholders want to create a new table with more employees 
(from data/more_employees.csv) and ask you to analyse the below with the new data:

- how many distinct departments are there?
- analyse summary statistics of salary by department. 
Include minimum, maximum, average, median salary. 
Why are average and median salary different?

============== */

-- create a table and insert values 

CREATE TABLE IF NOT EXISTS staging.more_employees AS (
    SELECT * FROM read_csv_auto('data/more_employees.csv')
);

-- count distinct department - how many distinct/unique values are there

SELECT COUNT(DISTINCT department)
FROM staging.more_employees;

-- analyze salary
SELECT
    department, 
    ROUND(AVG(monthly_salary_sek)) AS average_salary_sek,
    ROUND(MEDIAN(monthly_salary_sek)) AS median_salary_sek,
    ROUND(MIN(monthly_salary_sek)) AS minimum_salary_sek,
    ROUND(MAX(monthly_salary_sek)) AS maximum_salary_sek
FROM staging.more_employees
GROUP BY department; 
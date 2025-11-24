# In-class exercise, week 2
This exercise covers knowledge in chapter 6 & 7. The background is that you are a data engineer responsible for the HR data of a company. Write SQL queries to respond to stakeholders' requirements below:

## Task 1
You are asked to create a database with:
- a schema called *staging*
- a table under the schema, called *employees*
- the table should have columns:
  - employee_id where the first employee employed should have employee_id = 1
  - department
  - employment_year

## Task 2
The stakeholders first emailed you information of three employees and asked you to add these records into the database. The informaiton is as below:

*The first employee is from the Sales department and was employed in 2001. The second employee is from the Logistics department and was employed in 2002. The third employee was employed in 2002 in the IT department.*

After a few days, the stakeholders composed a csv file for information of the next 100 employees and asked you to add these records into the database. You can find the csv file called *employees.csv* under `data/`.

## Task 3
The stakeholders contacted you and said that the 98th and 99th employees were employed in 2023 instead of in 2024. You need to correct the records.

## Task 4
The stakeholders ask you to add the information about the pension plan of each employee. Employees employed before 2016 have plan 1 while others have plan 2 as their pension plans. 

## Task 5
The stakeholders figure out that there was no employee employed in 2001 and ask you to remove these employee records. 

## Task 6
Now the stakeholders want to create a new table with more employees (from `data/more_employees.csv`) and ask you to analyse the below with the new data:
- how many distinct departments are there?
- analyse summary statistics of salary by department. Include minimum, maximum, average, median salary. Why are average and median salary different?
  

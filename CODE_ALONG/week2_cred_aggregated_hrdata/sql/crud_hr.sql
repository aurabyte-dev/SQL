/* ==============
DDL - CREATE
============== */

-- TASK 1 - create a databse and

-- a schema called staging

CREATE SCHEMA IF NOT EXISTS staging;

-- a table under the schema, called employees
-- the table should have columns:
-- employee_id where the first employee employed should have employee_id = 1
-- department
-- employment_year

-- creare sequence to generate values for employee_id column later
CREATE SEQUENCE IF NOT EXISTS id_sequence START 1;


CREATE TABLE IF NOT EXISTS staging.employees (
    employee_id INTEGER DEFAULT nextval('id_sequence'),
    department VARCHAR, 
    employment_year INTEGER
);



/* ==============
CRUD - CREATE
============== */

/* ==============

TASK 2A

The stakeholders first emailed you information of three employees and asked you to add these records into the database. 
The informaiton is as below:

The first employee is from the Sales department and was employed in 2001. 
The second employee is from the Logistics department and was employed in 2002. 
The third employee was employed in 2002 in the IT department.

============== */

-- insert 3 rows manually 

INSERT INTO
    staging.employees (department, employment_year)
VALUES
    ('Sales', 2001),
    ('Logistics', 2002),
    ('IT', 2002);

/* ==============

TASK 2B

After a few days, the stakeholders composed a csv file for information of the next 100 employees and asked you to add these records into the database. 
You can find the csv file called employees.csv under data/.

============== */

-- insert with read.csv() function
-- ref: https://duckdb.org/docs/stable/guides/file_formats/csv_import

INSERT INTO 
    staging.employees (department, employment_year)
    SELECT * FROM read_csv('data/employees.csv');


/* =============
   CRUD - Read 

   CRUD = Create, Read, Update, Delete (the 4 basic database operations)
    Read = this section is about reading/viewing data
   
   ============= */

SELECT * FROM staging.employees; 
--LIMIT 10;
--OFFSET 10; 


/* ==============
   CRUD - Update 
   ============== */

/* ==============

TASK 3

The stakeholders contacted you and said that the 98th and 99th employees were employed in 2023 instead of in 2024. 
You need to correct the records.
============== */

-- modify existing data

UPDATE staging.employees
SET employment_year = 2023
WHERE employee_id IN (98,99);

--WHERE employee_id = 98 OR employee_id = 99; 


/* ==============
DDL - Alter
============== */

/* ==============

TASK 4

The stakeholders ask you to add the information about the pension plan of each employee. 
Employees employed before 2016 have plan 1 while others have plan 2 as their pension plans

============== */

-- 1. start by creating the column

ALTER TABLE staging.employees
ADD COLUMN pension_plan VARCHAR DEFAULT 'plan 1'

/* ==============
DDL - Update
============== */

UPDATE staging.employees
SET pension_plan = 'plan 2'
WHERE employment_year > 2015;

/* ==============
CRUD - Delete
============== */

/* ==============

TASK 5

The stakeholders figure out that there was no employee employed in 2001 
and ask you to remove these employee records.

============== */

-- always check the rows you plan to delete

SELECT * 
FROM staging.employees
WHERE employee_id = 1;

DELETE 
FROM staging.employees
WHERE employee_id =1;


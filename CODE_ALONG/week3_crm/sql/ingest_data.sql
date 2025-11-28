CREATE SCHEMA IF NOT EXISTS staging;

CREATE TABLE IF NOT EXISTS staging.crm_old AS (
    SELECT * FROM read_csv_auto('data/crm_old.csv')
);

CREATE TABLE IF NOT EXISTS staging.crm_new AS (
    SELECT * FROM read_csv_auto('data/crm_new.csv')
);


/* 

TASK 2

Both CRM datasets may contain invalid records. Identify all rows in both datasets that fail to meet the following rules:

The email address must include an @ symbol followed later by a .
The region value must be either EU or US
The status must be either active or inactive

*/

-- email 
-- version 1 - LIKE operator with wildcard

select * from staging.crm_old
where not email like '%@%.%';


-- version 2 -- REGEXP function for the new data
-- because the above query can't 
select * from staging.crm_new
where not regexp_matches (email, '[A-Za-z0-9]+@[A-Za-z0-9]+\.[A-Za-z]');


-- region
select  *
from staging.crm_new
where not regexp_matches (email, '[A-Za-z0-9]+@[A-Za-z0-9]+\.[A-Za-z]')
or region not in ('EU', 'US')


-- status
select *
from staging.crm_old
where not regexp_matches (email, '[A-Za-z0-9]+@[A-Za-z0-9]+\.[A-Za-z]')
or region not in ('EU', 'US')
or status not in ('active', 'inactive');

-- join both tables
select *
from staging.crm_old
where not regexp_matches (email, '[A-Za-z0-9]+@[A-Za-z0-9]+\.[A-Za-z]')
or region not in ('EU', 'US')
or status not in ('active', 'inactive')

UNION ALL

select  *
from staging.crm_new
where not regexp_matches (email, '[A-Za-z0-9]+@[A-Za-z0-9]+\.[A-Za-z]')
or region not in ('EU', 'US')
or status not in ('active', 'inactive');



/* 

TASK 3
=========

Create a new schema called constrained and create two tables under it. 
For each table, create column constraints for the rules specified in task 2 
and insert rows fulfilling these constraints separately from the two tables in the staging schema.

*/

-- create the new schema
create schema if not exists constrained;

-- create the table
-- this table has no constrains
create table if not exists constrained.crm_old(
    -- fill in all the columns from the csv (thats now in the staging schema)
    -- add constrains (ex. unique id, )
    customer_id INTEGER UNIQUE, -- unique id
    name VARCHAR NOT NULL, -- name can't be null
    email VARCHAR CHECK (email like '%@%.%'), -- check constrain works together with the condition
    region VARCHAR CHECK (region IN ('EU', 'US')), -- we use the same condition we used in task 2.
    status VARCHAR CHECK (status IN ('active', 'inactive'))
);

create table if not exists constrained.crm_new(
    -- fill in all the columns from the csv (thats now in the staging schema)
    -- add constrains (ex. unique id, )
    customer_id INTEGER UNIQUE, -- unique id
    name VARCHAR NOT NULL, -- name can't be null
    email VARCHAR CHECK (regexp_matches (email, '[A-Za-z0-9]+@[A-Za-z0-9]+\.[A-Za-z]')),
    region VARCHAR CHECK (region IN ('EU', 'US')), -- we use the same condition we used in task 2.
    status VARCHAR CHECK (status IN ('active', 'inactive'))
);

-- insert the rows with INSERT INTO

INSERT INTO constrained.crm_old
SELECT *
FROM staging.crm_old
WHERE regexp_matches (email, '[A-Za-z0-9]+@[A-Za-z0-9]+\.[A-Za-z]')
AND region IN ('EU', 'US')
AND status IN ('active', 'inactive');

INSERT INTO constrained.crm_new
SELECT *
FROM staging.crm_new
WHERE regexp_matches (email, '[A-Za-z0-9]+@[A-Za-z0-9]+\.[A-Za-z]')
AND region IN ('EU', 'US')
AND status IN ('active', 'inactive');


/*

TASK 4
========

In tasks 4 and 5, use the data in the staging schema that store customer records before column constraints are enforced.

To validate whether the old and new CRM systems keep the same customer records, use the column customer_id as the unique identifier of customers and find out:

customers only recorded in the old CRM system
customers only recorded in the new CRM system
customers recorded in both CRM system

*/


-- we want to see customers that are only in the OLD crm system
SELECT customer_id
FROM staging.crm_old
EXCEPT
SELECT customer_id
FROM staging.crm_new


-- we want to see customers that are only in the NEW crm system
-- switch the order
-- customers that are only in the old crm system
SELECT customer_id
FROM staging.crm_new
EXCEPT
SELECT customer_id
FROM staging.crm_old

-- common customers in both crm systems
-- customers that are only in the old crm system
SELECT customer_id
FROM staging.crm_new
INTERSECT
SELECT customer_id
FROM staging.crm_old


/*

TASK 5
=======

With your findings above, you are going to produce a discrepancy report showing customer records that have issues and need to be further checked with the system migration and customer teams.

Include records that

violate constraints in task 2
are not common as you found in task 4

*/

--subquery 1: customer only in the old crm system 
(SELECT
    *
FROM
    staging.crm_old
EXCEPT
SELECT
    *
FROM
    staging.crm_new)
UNION 
-- subquery 2: customer only in the new crm system
(SELECT
    *
FROM
    staging.crm_new
EXCEPT
SELECT
    *
FROM
    staging.crm_old)

UNION 
--subquery 3: customers violating constraints in old crm system 
(SELECT
    *
FROM
    staging.crm_old
WHERE
    NOT regexp_matches (email, '[A-Za-z0-9]+@[A-Za-z0-9]+.[A-Za-z]')
    OR NOT region IN ('EU', 'US')
    OR NOT status IN ('active', 'inactive'))
UNION 
--subquery 4: customers violating constraints in new crm system
(SELECT
    *
FROM
    staging.crm_new
WHERE
    NOT regexp_matches (email, '[A-Za-z0-9]+@[A-Za-z0-9]+.[A-Za-z]')
    OR NOT region IN ('EU', 'US')
    OR NOT status IN ('active', 'inactive'))
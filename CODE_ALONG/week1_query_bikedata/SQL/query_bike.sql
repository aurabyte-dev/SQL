
/* ============

Query the data

=============== */

-- overview of data
desc;

desc; staging.joined_table;

-- select all or some columns

SELECT * FROM staging.joined_table;

SELECT 
    order_date, 
    customer_first_name,
    customer_last_name, 
    product_name
FROM staging.joined_table;

-- filters rows with WHERE clause

SELECT * FROM staging.joined_table;

SELECT 
    order_date, 
    customer_first_name,
    customer_last_name, 
    product_name
FROM staging.joined_table
WHERE customer_first_name = 'Marvin';

-- create a new table for order status description

CREATE TABLE IF NOT EXISTS staging.status (
    order_status INTEGER,
    order_status_description VARCHAR
);

SELECT * FROM staging.status;

INSERT INTO 
    staging.status
VALUE
    (1, 'Pending'),
    (2, 'Processing'),
    (3, 'Rejected'),
    (4, 'Completed');


-- sort the rows by order_status
SELECT 
  j.order_id,
  j.order_status,
  s.order_status_description
FROM staging.joined_table j
JOIN staging.status s ON j.order_status = s.order_status
ORDER BY j.order_status ASC;

/* ============
Investigate unique 
customers
=============== */

-- DISTINCT
SELECT DISTINCT order_id
FROM staging.joined_table
ORDER BY customer_id ASC;

-- find unique values of customer_id
SELECT DISTINCT customer_id
FROM staging.joined_table
ORDER BY customer_id ASC;

-- find unique values of customer full name
SELECT DISTINCT customer_first_name, customer_last_name
FROM staging.joined_table
ORDER BY customer_first_name, customer_last_name;

/* ===============
    Introduce 
    aggregation
================= */

-- aggregate over rows
-- there are different ways of aggregation (max, min...)

-- what is the total revenue from all orders

SELECT
 ROUND(SUM(quantity*list_price)) AS total_revenue
FROM staging.joined_table;


-- try out other aggregation functions

SELECT 
  ROUND(MIN(quantity*list_price)) AS min_revenue,
  ROUND(MAX(quantity*list_price)) AS max_revenue,
FROM staging.joined_table;

/* ===================
    CASE...WHEN
====================== */

-- similar if...else in other languages
-- we can replace the order_status column to some descriptions
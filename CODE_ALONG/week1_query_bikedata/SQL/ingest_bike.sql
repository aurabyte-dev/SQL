CREATE SCHEMA IF NOT EXISTS staging;

CREATE TABLE IF NOT EXISTS
  staging.orders AS (
    SELECT * FROM read_csv_auto('data/orders.csv')
);

CREATE TABLE IF NOT EXISTS
  staging.customers AS (
    SELECT * FROM read_csv_auto('data/customers.csv')
);

CREATE TABLE IF NOT EXISTS
  staging.brands AS (
    SELECT * FROM read_csv_auto('data/brands.csv')
);

CREATE TABLE IF NOT EXISTS
  staging.categories AS (
    SELECT * FROM read_csv_auto('data/categories.csv')
);

CREATE TABLE IF NOT EXISTS
  staging.order_items AS (
    SELECT * FROM read_csv_auto('data/order_items.csv')
);

CREATE TABLE IF NOT EXISTS
  staging.products AS (
    SELECT * FROM read_csv_auto('data/products.csv')
);

CREATE TABLE IF NOT EXISTS
  staging.staffs AS (
    SELECT * FROM read_csv_auto('data/staffs.csv')
);

CREATE TABLE IF NOT EXISTS
  staging.stocks AS (
    SELECT * FROM read_csv_auto('data/stocks.csv')
);

CREATE TABLE IF NOT EXISTS
  staging.stores AS (
    SELECT * FROM read_csv_auto('data/stores.csv')
);
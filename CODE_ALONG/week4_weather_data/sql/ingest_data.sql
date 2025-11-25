CREATE SCHEMA IF NOT EXISTS staging;

CREATE TABLE IF NOT EXISTS staging.weather AS (
    SELECT * FROM read_csv_auto('data/daily_weather_2020.csv')
);

DESC staging.sweden_holidays;

FROM staging.sweden_holidays;

-- addition and subtraction

SELECT
    date, date + interval 5 day AS plus_5_days, -- 1. date 2. date in column 1 + 5 days
    typeof(plus_5_days) AS plus_5_days_type
FROM staging.sweden_holidays; 


SELECT
    date, 
    date + interval 5 day AS plus_5_days,
    typeof(plus_5_days) AS plus_5_days_type,
    date - interval 5 day AS minus_5_days
FROM 
    staging.sweden_holidays; 

-- DATE functions
SELECT today();

SELECT 
  today() AS today,
  date - today as time_to_holiday,*
FROM
staging.sweden_holidays;


-- pick out weekday


-- latest from two days


-- convert date to string

SELECT 
    date,
    strftime(date, '%d/%m/%y') as date_string,
    typeof(date_string) -- shows the type (varchar)
FROM 
    staging.sweden_holidays;


-- convert from string to date

SELECT 
    date,
    strftime(date, '%d/%m/%y') as date_string,
    strptime(date_string, '%d/%m/%y') as new_date,
    typeof(new_date) -- shows the type (varchar)
FROM 
    staging.sweden_holidays;
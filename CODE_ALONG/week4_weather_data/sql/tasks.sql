/*

TASK 2.a
============

What are the data types of the following columns:

sunriseTime - DOUBLE
sunsetTime - DOUBLE
temperatureHighTime - BIGINT
temperatureLowTime - BIGINT
windGustTime - BIGINT
precipIntensityMaxTime - DOUBLE

BIGINT = data type that stores really, really big whole numbers (integers)
    - Regular INT = A small box that can hold numbers up to about 2 billion
    - BIGINT = A warehouse-sized container that can hold numbers up to about 9 quintillion (that's 9 with 18 zeros!)

DOUBLE = stores decimal numbers with very high precision. 
- FLOAT (single precision) = Can accurately store about 7 decimal digits
- DOUBLE (double precision) = Can accurately store about 15-17 decimal digits

*/

-- to see the type
desc staging.weather; 

-- if we only want to see the required columns

DESC 
SELECT 
  sunriseTime, 
  sunsetTime, 
  temperatureHighTime, 
  temperatureLowTime,
  windGustTime,
  precipIntensityMaxTime
FROM staging.weather;


/*

TASK 2.b
====================

What is UNIX time?

Unix time is a date and time representation widely used in computing. 
It measures time by the number of non-leap seconds that have elapsed since 00:00:00 UTC on 1 January 1970.
Because the numbers are so bi it makes sense that the type for the columns are DOUBLE and BIGINT

*/


/*

TASK 3.a
====================

Show the number of rows for each combination of Country/Region and Province/State. 
How many records are there for each combination?

*/

-- each row in the dataset contains weather data for each combination of Country/Region, Province/State and date(time column)
-- it's important to understand which column can be used to uniquely identify each row
-- we are looking for how many records there are ber country/region
-- use aggregation function together with group by


SELECT 
  "Country/Region" AS Country, 
  "Province/State" AS State,
  COUNT(*) AS Nr_Records,
FROM staging.weather
GROUP BY Country, State -- you can use original name or alias.
ORDER BY Country, State;


/*

TASK 4
====================

In the following tasks, analyze only records in Sweden.

Show the columns below as TIMESTAMP (WITH TIME ZONE) data type and with the timezone in Sweden:

sunriseTime
sunsetTime

*/


SELECT 
  sunsetTime, 
  sunriseTime,
  typeof(sunsetTime) AS SunsetTime_Type, 
  typeof(sunriseTime) AS SunriseTime_Type
FROM staging.weather
WHERE "Country/Region" = 'Sweden'; -- filtering just Sweden

-- the type is courently DOUBLE

-- to transform it to TIMESTAMP use the to_timestamp() function

SELECT 
  to_timestamp(sunriseTime) AS Sunrise_utc, 
  to_timestamp(sunriseTime) AT TIME ZONE 'Europe/Stockholm' AS Sunrise_sweden,
  to_timestamp(sunsetTime) AS Sunset,
  to_timestamp(sunsetTime) AT TIME ZONE 'Europe/Stockholm' AS Sunset_sweden,
FROM staging.weather
WHERE "Country/Region" = 'Sweden';


-- the timezone is shown in the timestamp (2020-01-01 08:33:00+01)




/*

TASK 5
====================

For each year-month, show the largest gap between sunrise and sunset hours. 
In your result, show these columns:

year
month
the time with time zone of sunrise when the gap is largest in that month
the time with time zone of sunset when the gap is largest in that month
the gap in hours

*/

-- the new year and month columns involves subtracting a part of the timestamp.
-- to pick up the date with the largest gap within a month involves the use of aggregation function.
-- the gap can be calculated directly with UNIX time.

SELECT 
  date_part('year', to_timestamp(sunriseTime)) AS year,
  date_part('month', to_timestamp(sunriseTime)) AS month, 
  ROUND(MAX(sunsetTime-sunriseTime)/3600) as gap_hours -- divide by 3600 to show the gap in hours
FROM staging.weather
WHERE "Country/Region" = 'Sweden'
GROUP BY year, month
ORDER BY year, month;



/*

TASK 6
====================

Show a new column which prints a text of warning, 
'It's dangerous to use the crane at kl. ...', where ... is the hour of windGustTime during the day. 
For instance, the result of one row can be: 'It's dangerous to use the crane at kl. 16'

*/

-- concatenate integar and string

SELECT 
  to_timestamp(windGustTime) AS most_windy_timestamp,
  date_part('hour', most_windy_timestamp) AS most_windy_hour,
  CONCAT('It´´s dangerous to use the crane at kl. ', most_windy_hour)
FROM staging.weather
WHERE "Country/Region" = 'Sweden';

-- concatenate string and string

SELECT 
  to_timestamp(windGustTime) AS most_windy_timestamp,
  -- strftime() transform timestamp to string
  -- use the format, like %H, to design the presentation
  -- strptime(), string past time - transform string to timestamp
  strftime(most_windy_timestamp, '%H') AS most_windy_hour,
  CONCAT('It´´s dangerous to use the crane at kl. ', most_windy_hour)
FROM staging.weather
WHERE "Country/Region" = 'Sweden';


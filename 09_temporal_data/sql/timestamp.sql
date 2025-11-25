desc staging.train_schedules; 

FROM staging.train_schedules;

SELECT
    scheduled_arrival, 
    actual_arrival, 
    delay_minutes, 
    age(actual_arrival, schedule_arrival) as delay_interval, 
    typeof(delay_interval)
FROM staging.train_schedules;
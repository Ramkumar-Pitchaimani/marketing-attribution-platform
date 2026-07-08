CREATE OR REPLACE TABLE `pro1-501113.marketing_dw.dim_date`
AS

WITH calendar AS (

SELECT day

FROM UNNEST(

GENERATE_DATE_ARRAY(

DATE('2025-01-01'),

DATE('2026-12-31')

)

) AS day

)

SELECT

day AS calendar_date,

FORMAT_DATE('%Y%m%d', day) AS date_key,

EXTRACT(YEAR FROM day) AS year,

EXTRACT(QUARTER FROM day) AS quarter,

EXTRACT(MONTH FROM day) AS month,

FORMAT_DATE('%B', day) AS month_name,

EXTRACT(WEEK FROM day) AS week,

EXTRACT(DAY FROM day) AS day_of_month,

FORMAT_DATE('%A', day) AS weekday,

CASE

WHEN EXTRACT(DAYOFWEEK FROM day) IN (1,7)

THEN TRUE

ELSE FALSE

END AS is_weekend,

CURRENT_TIMESTAMP() AS record_loaded_timestamp

FROM calendar;
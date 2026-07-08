CREATE OR REPLACE TABLE `pro1-501113.marketing_dw.dim_device`
AS

WITH devices AS (

    SELECT DISTINCT
        TRIM(device) AS device_name
    FROM `pro1-501113.marketing_dw.google_ads_clean`

    UNION DISTINCT

    SELECT DISTINCT
        TRIM(device) AS device_name
    FROM `pro1-501113.marketing_dw.meta_ads_clean`

)

SELECT

    ROW_NUMBER() OVER (
        ORDER BY device_name
    ) AS device_key,

    device_name,

    TRUE AS is_active,

    CURRENT_TIMESTAMP() AS record_loaded_timestamp,

    'v1.0' AS pipeline_version

FROM devices;
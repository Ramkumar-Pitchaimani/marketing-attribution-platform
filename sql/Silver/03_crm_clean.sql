CREATE OR REPLACE TABLE `pro1-501113.marketing_dw.crm_leads_clean`
AS

SELECT DISTINCT

    lead_id,

    lead_date,

    INITCAP(TRIM(customer_name)) AS customer_name,

    LOWER(TRIM(email)) AS email,

    phone,

    INITCAP(TRIM(city)) AS city,

    INITCAP(TRIM(country)) AS country,

    INITCAP(TRIM(lead_source)) AS lead_source,

    gclid,

    fbclid,

    LOWER(TRIM(utm_campaign)) AS utm_campaign,

    INITCAP(TRIM(status)) AS lead_status,

    ROUND(COALESCE(revenue,0),2) AS revenue,

    CURRENT_TIMESTAMP() AS record_loaded_timestamp,

    'CRM' AS record_source,

    'v1.0' AS pipeline_version

FROM `pro1-501113.marketing_dw.crm_leads_raw`;
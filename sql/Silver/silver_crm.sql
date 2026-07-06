CREATE OR REPLACE TABLE `pro1-501113.marketing_dw.crm_leads_clean`
AS

SELECT

    lead_id,

    DATE(lead_date) AS lead_date,

    TRIM(customer_name) AS customer_name,

    LOWER(email) AS email,

    phone,

    INITCAP(city) AS city,

    UPPER(country) AS country,

    LOWER(lead_source) AS lead_source,

    gclid,

    fbclid,

    LOWER(utm_campaign) AS utm_campaign,

    LOWER(status) AS status,

    CAST(revenue AS NUMERIC) AS revenue,

    CURRENT_TIMESTAMP() AS load_timestamp

FROM `pro1-501113.marketing_dw.crm_leads_raw`

WHERE lead_id IS NOT NULL

QUALIFY ROW_NUMBER() OVER (
PARTITION BY lead_id
ORDER BY lead_date DESC
)=1;
CREATE OR REPLACE TABLE `pro1-501113.marketing_dw.fact_leads`
AS

SELECT

    l.lead_id,

    dd.date_key,

    CASE
        WHEN l.gclid IS NOT NULL THEN 1
        WHEN l.fbclid IS NOT NULL THEN 2
        ELSE NULL
    END AS channel_key,

    INITCAP(l.lead_source) AS lead_source,

    INITCAP(l.lead_status) AS lead_status,

    ROUND(l.revenue,2) AS revenue,

    l.gclid,

    l.fbclid,

    l.utm_campaign,

    CURRENT_TIMESTAMP() AS record_loaded_timestamp,

    'v1.0' AS pipeline_version

FROM
`pro1-501113.marketing_dw.crm_leads_clean` l

LEFT JOIN
`pro1-501113.marketing_dw.dim_date` dd
ON l.lead_date = dd.calendar_date;
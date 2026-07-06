CREATE OR REPLACE TABLE `pro1-501113.marketing_dw.fact_leads`
AS

WITH campaign_lookup AS (

SELECT DISTINCT

campaign_key,

campaign_id,

LOWER(campaign_name) AS campaign_name,

marketing_channel

FROM `pro1-501113.marketing_dw.dim_campaign`

)

SELECT

l.lead_id,

l.lead_date,

dc.campaign_key,

CASE

WHEN l.gclid IS NOT NULL THEN 1

WHEN l.fbclid IS NOT NULL THEN 2

ELSE NULL

END AS channel_key,

l.lead_source,

LOWER(l.status) AS status,

l.revenue,

l.gclid,

l.fbclid,

l.utm_campaign,

CURRENT_TIMESTAMP() AS load_timestamp

FROM
`pro1-501113.marketing_dw.crm_leads_clean` l

LEFT JOIN campaign_lookup dc

ON LOWER(l.utm_campaign)=dc.campaign_name;
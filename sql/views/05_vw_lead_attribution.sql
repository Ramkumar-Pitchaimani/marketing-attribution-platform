CREATE OR REPLACE VIEW marketing_dw.vw_lead_attribution AS

SELECT

lead_id,
lead_date,
customer_name,
city,
country,
status,
revenue,

CASE
    WHEN gclid IS NOT NULL THEN 'Google Ads'
    WHEN fbclid IS NOT NULL THEN 'Meta Ads'
    ELSE 'Organic'
END AS marketing_channel,

utm_campaign

FROM marketing_dw.crm_leads;
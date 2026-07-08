-- ==========================================
-- NULL Validation
-- ==========================================

SELECT
'google_ads_clean' AS table_name,
COUNTIF(campaign_id IS NULL) AS null_campaign_id,
COUNTIF(campaign_name IS NULL) AS null_campaign_name,
COUNTIF(campaign_date IS NULL) AS null_campaign_date
FROM `pro1-501113.marketing_dw.google_ads_clean`

UNION ALL

SELECT
'meta_ads_clean',
COUNTIF(campaign_id IS NULL),
COUNTIF(campaign_name IS NULL),
COUNTIF(campaign_date IS NULL)
FROM `pro1-501113.marketing_dw.meta_ads_clean`

UNION ALL

SELECT
'crm_leads_clean',
COUNTIF(lead_id IS NULL),
COUNTIF(lead_source IS NULL),
COUNTIF(lead_date IS NULL)
FROM `pro1-501113.marketing_dw.crm_leads_clean`;
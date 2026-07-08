-- ==========================================
-- Duplicate Validation
-- ==========================================

SELECT
'Google Ads' AS table_name,
COUNT(*) - COUNT(DISTINCT gclid) AS duplicate_gclid
FROM `pro1-501113.marketing_dw.google_ads_clean`

UNION ALL

SELECT
'Meta Ads',
COUNT(*) - COUNT(DISTINCT fbclid)
FROM `pro1-501113.marketing_dw.meta_ads_clean`

UNION ALL

SELECT
'CRM Leads',
COUNT(*) - COUNT(DISTINCT lead_id)
FROM `pro1-501113.marketing_dw.crm_leads_clean`;
-- ==========================================
-- Raw vs Clean Row Count Validation
-- ==========================================

SELECT
'google_ads' AS table_name,
(SELECT COUNT(*) FROM `pro1-501113.marketing_dw.google_ads_raw`) AS raw_count,
(SELECT COUNT(*) FROM `pro1-501113.marketing_dw.google_ads_clean`) AS clean_count

UNION ALL

SELECT
'meta_ads',
(SELECT COUNT(*) FROM `pro1-501113.marketing_dw.meta_ads_raw`),
(SELECT COUNT(*) FROM `pro1-501113.marketing_dw.meta_ads_clean`)

UNION ALL

SELECT
'crm_leads',
(SELECT COUNT(*) FROM `pro1-501113.marketing_dw.crm_leads_raw`),
(SELECT COUNT(*) FROM `pro1-501113.marketing_dw.crm_leads_clean`);
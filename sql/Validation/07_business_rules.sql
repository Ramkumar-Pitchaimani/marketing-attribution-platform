-- ==========================================
-- Business Rule Validation
-- ==========================================

SELECT
COUNTIF(spend < 0) AS negative_spend,
COUNTIF(clicks < 0) AS negative_clicks,
COUNTIF(impressions < 0) AS negative_impressions,
COUNTIF(conversions < 0) AS negative_conversions
FROM `pro1-501113.marketing_dw.fact_marketing`;
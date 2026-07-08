-- ==========================================
-- Dashboard Validation
-- ==========================================

SELECT
SUM(impressions) total_impressions,
SUM(clicks) total_clicks,
SUM(spend) total_spend,
SUM(conversions) total_conversions,
SUM(conversion_value) total_revenue
FROM `pro1-501113.marketing_dw.fact_marketing`;
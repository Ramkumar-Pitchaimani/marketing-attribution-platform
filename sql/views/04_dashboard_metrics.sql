CREATE OR REPLACE VIEW
`pro1-501113.marketing_dw.vw_dashboard_metrics`
AS

SELECT

SUM(impressions) AS total_impressions,

SUM(clicks) AS total_clicks,

SUM(spend) AS total_spend,

SUM(conversions) AS total_conversions,

SUM(conversion_value) AS total_conversion_value,

SAFE_DIVIDE(SUM(clicks),SUM(impressions)) AS ctr,

SAFE_DIVIDE(SUM(spend),SUM(clicks)) AS avg_cpc,

SAFE_DIVIDE(SUM(spend),SUM(conversions)) AS cost_per_conversion,

SAFE_DIVIDE(SUM(conversion_value),SUM(spend)) AS roas

FROM
`pro1-501113.marketing_dw.fact_marketing`;
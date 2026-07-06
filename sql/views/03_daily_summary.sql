CREATE OR REPLACE VIEW
`pro1-501113.marketing_dw.vw_daily_summary`
AS

SELECT

campaign_date,

SUM(impressions) impressions,

SUM(clicks) clicks,

SUM(spend) spend,

SUM(conversions) conversions,

SUM(conversion_value) conversion_value

FROM
`pro1-501113.marketing_dw.fact_marketing`

GROUP BY campaign_date

ORDER BY campaign_date;
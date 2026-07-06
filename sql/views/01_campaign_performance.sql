CREATE OR REPLACE VIEW
`pro1-501113.marketing_dw.vw_campaign_performance`
AS

SELECT

dc.campaign_name,

dc.marketing_channel,

SUM(fm.impressions) AS impressions,

SUM(fm.clicks) AS clicks,

SUM(fm.spend) AS spend,

SUM(fm.conversions) AS conversions,

SAFE_DIVIDE(
SUM(fm.clicks),
SUM(fm.impressions)
) AS ctr,

SAFE_DIVIDE(
SUM(fm.spend),
SUM(fm.clicks)
) AS avg_cpc,

SAFE_DIVIDE(
SUM(fm.spend),
SUM(fm.conversions)
) AS cost_per_conversion

FROM
`pro1-501113.marketing_dw.fact_marketing` fm

JOIN
`pro1-501113.marketing_dw.dim_campaign` dc

ON fm.campaign_key=dc.campaign_key

GROUP BY

dc.campaign_name,

dc.marketing_channel;
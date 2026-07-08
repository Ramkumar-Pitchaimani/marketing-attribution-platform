CREATE OR REPLACE VIEW
`pro1-501113.marketing_dw.vw_campaign_performance`
AS

SELECT

    dc.campaign_name,

    dc.marketing_channel,

    SUM(fm.impressions) AS total_impressions,

    SUM(fm.clicks) AS total_clicks,

    ROUND(SUM(fm.spend),2) AS total_spend,

    SUM(fm.conversions) AS total_conversions,

    ROUND(SUM(fm.conversion_value),2) AS total_revenue,

    ROUND(
        SAFE_DIVIDE(
            SUM(fm.clicks),
            SUM(fm.impressions)
        ) * 100,
        2
    ) AS ctr,

    ROUND(
        SAFE_DIVIDE(
            SUM(fm.spend),
            SUM(fm.clicks)
        ),
        2
    ) AS avg_cpc,

    ROUND(
        SAFE_DIVIDE(
            SUM(fm.spend),
            SUM(fm.conversions)
        ),
        2
    ) AS cost_per_conversion,

    ROUND(
        SAFE_DIVIDE(
            SUM(fm.conversion_value),
            SUM(fm.spend)
        ),
        2
    ) AS roas

FROM
`pro1-501113.marketing_dw.fact_marketing` fm

JOIN
`pro1-501113.marketing_dw.dim_campaign` dc

ON fm.campaign_key = dc.campaign_key

GROUP BY

dc.campaign_name,
dc.marketing_channel;
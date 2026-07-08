CREATE OR REPLACE VIEW
`pro1-501113.marketing_dw.vw_channel_performance`
AS

SELECT

    d.channel_name,

    SUM(f.impressions) AS total_impressions,

    SUM(f.clicks) AS total_clicks,

    ROUND(SUM(f.spend),2) AS total_spend,

    SUM(f.conversions) AS total_conversions,

    ROUND(SUM(f.conversion_value),2) AS total_revenue,

    ROUND(
        SAFE_DIVIDE(
            SUM(f.clicks),
            SUM(f.impressions)
        ) * 100,
        2
    ) AS ctr,

    ROUND(
        SAFE_DIVIDE(
            SUM(f.spend),
            SUM(f.clicks)
        ),
        2
    ) AS avg_cpc,

    ROUND(
        SAFE_DIVIDE(
            SUM(f.spend),
            SUM(f.conversions)
        ),
        2
    ) AS cost_per_conversion,

    ROUND(
        SAFE_DIVIDE(
            SUM(f.conversion_value),
            SUM(f.spend)
        ),
        2
    ) AS roas

FROM
`pro1-501113.marketing_dw.fact_marketing` f

JOIN
`pro1-501113.marketing_dw.dim_channel` d

ON f.channel_key = d.channel_key

GROUP BY

d.channel_name;
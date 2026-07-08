CREATE OR REPLACE VIEW
`pro1-501113.marketing_dw.vw_daily_summary`
AS

SELECT

    d.calendar_date,

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
            SUM(f.conversion_value),
            SUM(f.spend)
        ),
        2
    ) AS roas

FROM
`pro1-501113.marketing_dw.fact_marketing` f

JOIN
`pro1-501113.marketing_dw.dim_date` d

ON
f.date_key = d.date_key

GROUP BY

d.calendar_date

ORDER BY

d.calendar_date;
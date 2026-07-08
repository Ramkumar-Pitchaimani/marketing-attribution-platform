CREATE OR REPLACE VIEW
`pro1-501113.marketing_dw.vw_dashboard_metrics`
AS

SELECT

    fm.total_impressions,

    fm.total_clicks,

    fm.total_spend,

    fm.total_conversions,

    fm.total_revenue,

    fl.total_leads,

    ROUND(
        SAFE_DIVIDE(
            fm.total_clicks,
            fm.total_impressions
        ) * 100,
        2
    ) AS ctr,

    ROUND(
        SAFE_DIVIDE(
            fm.total_spend,
            fm.total_clicks
        ),
        2
    ) AS avg_cpc,

    ROUND(
        SAFE_DIVIDE(
            fm.total_spend,
            fm.total_conversions
        ),
        2
    ) AS cost_per_conversion,

    ROUND(
        SAFE_DIVIDE(
            fm.total_spend,
            fl.total_leads
        ),
        2
    ) AS cost_per_lead,

    ROUND(
        SAFE_DIVIDE(
            fm.total_revenue,
            fm.total_spend
        ),
        2
    ) AS roas

FROM

(
    SELECT

        SUM(impressions) AS total_impressions,

        SUM(clicks) AS total_clicks,

        ROUND(SUM(spend),2) AS total_spend,

        SUM(conversions) AS total_conversions,

        ROUND(SUM(conversion_value),2) AS total_revenue

    FROM
    `pro1-501113.marketing_dw.fact_marketing`

) fm

CROSS JOIN

(
    SELECT

        COUNT(*) AS total_leads

    FROM
    `pro1-501113.marketing_dw.fact_leads`

) fl;
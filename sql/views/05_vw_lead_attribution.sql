CREATE OR REPLACE VIEW
`pro1-501113.marketing_dw.vw_lead_attribution`
AS

SELECT

    fl.lead_id,

    dd.calendar_date AS lead_date,

    fl.lead_source,

    fl.lead_status,

    fl.revenue,

    CASE

        WHEN fl.channel_key = 1 THEN 'Google Ads'

        WHEN fl.channel_key = 2 THEN 'Meta Ads'

        ELSE 'Organic'

    END AS marketing_channel,

    fl.utm_campaign,

    fl.gclid,

    fl.fbclid

FROM
`pro1-501113.marketing_dw.fact_leads` fl

LEFT JOIN
`pro1-501113.marketing_dw.dim_date` dd

ON fl.date_key = dd.date_key;
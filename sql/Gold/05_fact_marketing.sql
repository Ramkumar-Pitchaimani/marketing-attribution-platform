CREATE OR REPLACE TABLE `pro1-501113.marketing_dw.fact_marketing`
AS

----------------------------------------------------------
-- Google Ads
----------------------------------------------------------

SELECT

    dc.campaign_key,

    1 AS channel_key,

    dd.date_key,

    dv.device_key,

    g.impressions,

    g.clicks,

    g.spend,

    g.conversions,

    g.conversion_value,

    CURRENT_TIMESTAMP() AS record_loaded_timestamp,

    'v1.0' AS pipeline_version

FROM
`pro1-501113.marketing_dw.google_ads_clean` g

JOIN
`pro1-501113.marketing_dw.dim_campaign` dc
ON
g.campaign_id = dc.campaign_id
AND dc.marketing_channel = 'Google Ads'

JOIN
`pro1-501113.marketing_dw.dim_device` dv
ON
g.device = dv.device_name

JOIN
`pro1-501113.marketing_dw.dim_date` dd
ON
g.campaign_date = dd.calendar_date


UNION ALL

----------------------------------------------------------
-- Meta Ads
----------------------------------------------------------

SELECT

    dc.campaign_key,

    2 AS channel_key,

    dd.date_key,

    dv.device_key,

    m.impressions,

    m.clicks,

    m.spend,

    m.conversions,

    m.conversion_value,

    CURRENT_TIMESTAMP() AS record_loaded_timestamp,

    'v1.0' AS pipeline_version

FROM
`pro1-501113.marketing_dw.meta_ads_clean` m

JOIN
`pro1-501113.marketing_dw.dim_campaign` dc
ON
m.campaign_id = dc.campaign_id
AND dc.marketing_channel = 'Meta Ads'

JOIN
`pro1-501113.marketing_dw.dim_device` dv
ON
m.device = dv.device_name

JOIN
`pro1-501113.marketing_dw.dim_date` dd
ON
m.campaign_date = dd.calendar_date;
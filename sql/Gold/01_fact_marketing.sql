CREATE OR REPLACE TABLE `pro1-501113.marketing_dw.fact_marketing`
AS

-----------------------------------------
-- Google Ads
-----------------------------------------

SELECT

dc.campaign_key,

1 AS channel_key,

g.campaign_date,

g.impressions,

g.clicks,

g.cost AS spend,

g.conversions,

g.conversion_value,

CURRENT_TIMESTAMP() AS load_timestamp

FROM
`pro1-501113.marketing_dw.google_ads_clean` g

JOIN
`pro1-501113.marketing_dw.dim_campaign` dc

ON

g.campaign_id=dc.campaign_id

AND dc.marketing_channel='Google Ads'

UNION ALL

-----------------------------------------
-- Meta Ads
-----------------------------------------

SELECT

dc.campaign_key,

2 AS channel_key,

m.campaign_date,

m.impressions,

m.clicks,

m.spend,

m.conversions,

m.conversion_value,

CURRENT_TIMESTAMP()

FROM
`pro1-501113.marketing_dw.meta_ads_clean` m

JOIN
`pro1-501113.marketing_dw.dim_campaign` dc

ON

m.campaign_id=dc.campaign_id

AND dc.marketing_channel='Meta Ads';
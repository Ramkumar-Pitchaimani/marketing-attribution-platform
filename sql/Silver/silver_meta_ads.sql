CREATE OR REPLACE TABLE `pro1-501113.marketing_dw.meta_ads_clean`
AS

SELECT

    DATE(date) AS campaign_date,

    account_id,
    TRIM(account_name) AS account_name,

    campaign_id,
    TRIM(campaign_name) AS campaign_name,
    LOWER(campaign_type) AS campaign_type,

    ad_set_id,
    TRIM(ad_set_name) AS ad_set_name,

    LOWER(placement) AS placement,
    LOWER(device) AS device,
    UPPER(country) AS country,

    CAST(impressions AS INT64) AS impressions,
    CAST(clicks AS INT64) AS clicks,
    CAST(ctr AS FLOAT64) AS ctr,
    CAST(cpc AS FLOAT64) AS cpc,
    CAST(spend AS NUMERIC) AS spend,

    CAST(conversions AS INT64) AS conversions,
    CAST(conversion_value AS NUMERIC) AS conversion_value,

    fbclid,

    LOWER(utm_source) AS utm_source,
    LOWER(utm_medium) AS utm_medium,
    LOWER(utm_campaign) AS utm_campaign,

    LOWER(age_group) AS age_group,
    LOWER(gender) AS gender,

    CURRENT_TIMESTAMP() AS load_timestamp

FROM `pro1-501113.marketing_dw.meta_ads_raw`

WHERE campaign_name IS NOT NULL

QUALIFY ROW_NUMBER() OVER (
PARTITION BY
date,
campaign_id,
ad_set_id,
fbclid
ORDER BY date DESC
)=1;
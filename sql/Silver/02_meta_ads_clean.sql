CREATE OR REPLACE TABLE `pro1-501113.marketing_dw.meta_ads_clean`
AS

SELECT DISTINCT

    date AS campaign_date,

    account_id,
    campaign_id,
    ad_set_id,

    UPPER(TRIM(account_name)) AS account_name,

    INITCAP(TRIM(campaign_name)) AS campaign_name,

    INITCAP(TRIM(campaign_type)) AS campaign_type,

    INITCAP(TRIM(ad_set_name)) AS ad_set_name,

    INITCAP(TRIM(placement)) AS placement,

    INITCAP(TRIM(device)) AS device,

    INITCAP(TRIM(country)) AS country,

    COALESCE(impressions,0) AS impressions,

    COALESCE(clicks,0) AS clicks,

    ROUND(COALESCE(ctr,0),2) AS ctr,

    ROUND(COALESCE(cpc,0),2) AS avg_cpc,

    ROUND(COALESCE(spend,0),2) AS spend,

    COALESCE(conversions,0) AS conversions,

    ROUND(COALESCE(conversion_value,0),2) AS conversion_value,

    fbclid,

    LOWER(utm_source) AS utm_source,

    LOWER(utm_medium) AS utm_medium,

    LOWER(utm_campaign) AS utm_campaign,

    age_group,

    gender,

    SAFE_DIVIDE(spend,clicks) AS actual_cpc,

    SAFE_DIVIDE(conversions,clicks)*100 AS conversion_rate,

    SAFE_DIVIDE(conversion_value,spend) AS roas,

    CURRENT_TIMESTAMP() AS record_loaded_timestamp,

    'META ADS' AS record_source,

    'v1.0' AS pipeline_version

FROM `pro1-501113.marketing_dw.meta_ads_raw`;
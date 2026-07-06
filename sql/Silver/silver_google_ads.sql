CREATE OR REPLACE TABLE `pro1-501113.marketing_dw.google_ads_clean`
AS

SELECT

    DATE(date) AS campaign_date,

    account_id,
    TRIM(account_name) AS account_name,

    campaign_id,
    TRIM(campaign_name) AS campaign_name,
    LOWER(campaign_type) AS campaign_type,

    ad_group_id,
    TRIM(ad_group_name) AS ad_group_name,

    TRIM(keyword) AS keyword,
    LOWER(match_type) AS match_type,
    LOWER(device) AS device,
    UPPER(country) AS country,

    CAST(impressions AS INT64) AS impressions,
    CAST(clicks AS INT64) AS clicks,
    CAST(ctr AS FLOAT64) AS ctr,
    CAST(avg_cpc AS FLOAT64) AS avg_cpc,
    CAST(cost AS NUMERIC) AS cost,

    CAST(conversions AS INT64) AS conversions,
    CAST(conversion_value AS NUMERIC) AS conversion_value,

    gclid,

    LOWER(utm_source) AS utm_source,
    LOWER(utm_medium) AS utm_medium,
    LOWER(utm_campaign) AS utm_campaign,
    LOWER(utm_content) AS utm_content,
    LOWER(utm_term) AS utm_term,

    quality_score,

    CURRENT_TIMESTAMP() AS load_timestamp

FROM `pro1-501113.marketing_dw.google_ads_raw`

WHERE campaign_name IS NOT NULL

QUALIFY ROW_NUMBER() OVER (
    PARTITION BY
        date,
        campaign_id,
        ad_group_id,
        keyword,
        gclid
    ORDER BY date DESC
) = 1;
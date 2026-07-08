CREATE OR REPLACE TABLE `pro1-501113.marketing_dw.google_ads_clean`
AS

SELECT DISTINCT

    -- Date Standardization
    date AS campaign_date,

    -- IDs
    CAST(account_id AS INT64) AS account_id,
    CAST(campaign_id AS INT64) AS campaign_id,
    CAST(ad_group_id AS INT64) AS ad_group_id,

    -- Text Standardization
    UPPER(TRIM(account_name)) AS account_name,
    INITCAP(TRIM(campaign_name)) AS campaign_name,
    INITCAP(TRIM(campaign_type)) AS campaign_type,
    INITCAP(TRIM(ad_group_name)) AS ad_group_name,
    LOWER(TRIM(keyword)) AS keyword,
    INITCAP(TRIM(match_type)) AS match_type,
    INITCAP(TRIM(device)) AS device,
    INITCAP(TRIM(country)) AS country,

    -- Metrics
    COALESCE(impressions,0) AS impressions,
    COALESCE(clicks,0) AS clicks,
    ROUND(COALESCE(ctr,0),2) AS ctr,
    ROUND(COALESCE(avg_cpc,0),2) AS avg_cpc,
    ROUND(COALESCE(cost,0),2) AS spend,
    COALESCE(conversions,0) AS conversions,
    ROUND(COALESCE(conversion_value,0),2) AS conversion_value,

    -- Attribution
    gclid,
    LOWER(utm_source) AS utm_source,
    LOWER(utm_medium) AS utm_medium,
    LOWER(utm_campaign) AS utm_campaign,
    LOWER(utm_content) AS utm_content,
    LOWER(utm_term) AS utm_term,

    -- Quality
    COALESCE(quality_score,0) AS quality_score,

    -- Derived Metrics
    SAFE_DIVIDE(cost, clicks) AS actual_cpc,

    SAFE_DIVIDE(conversions, clicks) * 100
        AS conversion_rate,

    SAFE_DIVIDE(conversion_value, cost)
        AS roas,

    CURRENT_TIMESTAMP() AS record_loaded_timestamp

FROM `pro1-501113.marketing_dw.google_ads_raw`;
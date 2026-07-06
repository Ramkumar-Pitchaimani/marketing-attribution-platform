CREATE OR REPLACE TABLE `pro1-501113.marketing_dw.dim_campaign`
AS

WITH campaigns AS (

SELECT DISTINCT

    campaign_id,

    campaign_name,

    campaign_type,

    'Google Ads' AS marketing_channel,

    MIN(campaign_date) OVER(PARTITION BY campaign_id) AS first_seen,

    MAX(campaign_date) OVER(PARTITION BY campaign_id) AS last_seen

FROM `pro1-501113.marketing_dw.google_ads_clean`

UNION DISTINCT

SELECT DISTINCT

    campaign_id,

    campaign_name,

    campaign_type,

    'Meta Ads',

    MIN(campaign_date) OVER(PARTITION BY campaign_id),

    MAX(campaign_date) OVER(PARTITION BY campaign_id)

FROM `pro1-501113.marketing_dw.meta_ads_clean`

)

SELECT

ROW_NUMBER() OVER(
ORDER BY marketing_channel,
campaign_name
) AS campaign_key,

campaign_id,

campaign_name,

campaign_type,

marketing_channel,

first_seen,

last_seen,

TRUE AS is_active,

CURRENT_TIMESTAMP() AS created_at

FROM campaigns;
-- Create Dataset
CREATE SCHEMA IF NOT EXISTS `pro1-501113.marketing_dw`;

---------------------------------------------------------
-- Google Ads Raw
---------------------------------------------------------

CREATE OR REPLACE TABLE `pro1-501113.marketing_dw.google_ads_raw`
(
    date DATE,
    account_id INT64,
    account_name STRING,
    campaign_id INT64,
    campaign_name STRING,
    campaign_type STRING,
    ad_group_id INT64,
    ad_group_name STRING,
    keyword STRING,
    match_type STRING,
    device STRING,
    country STRING,
    impressions INT64,
    clicks INT64,
    ctr FLOAT64,
    avg_cpc FLOAT64,
    cost FLOAT64,
    conversions INT64,
    conversion_value FLOAT64,
    gclid STRING,
    utm_source STRING,
    utm_medium STRING,
    utm_campaign STRING,
    utm_content STRING,
    utm_term STRING,
    quality_score INT64
);

---------------------------------------------------------
-- Meta Ads Raw
---------------------------------------------------------

CREATE OR REPLACE TABLE `pro1-501113.marketing_dw.meta_ads_raw`
(
    date DATE,
    account_id INT64,
    account_name STRING,
    campaign_id INT64,
    campaign_name STRING,
    campaign_type STRING,
    ad_set_id INT64,
    ad_set_name STRING,
    placement STRING,
    device STRING,
    country STRING,
    impressions INT64,
    clicks INT64,
    ctr FLOAT64,
    cpc FLOAT64,
    spend FLOAT64,
    conversions INT64,
    conversion_value FLOAT64,
    fbclid STRING,
    utm_source STRING,
    utm_medium STRING,
    utm_campaign STRING,
    age_group STRING,
    gender STRING
);

---------------------------------------------------------
-- CRM Leads
---------------------------------------------------------

CREATE OR REPLACE TABLE `pro1-501113.marketing_dw.crm_leads_raw`
(
    lead_id INT64,
    lead_date DATE,
    customer_name STRING,
    email STRING,
    phone STRING,
    city STRING,
    country STRING,
    lead_source STRING,
    gclid STRING,
    fbclid STRING,
    utm_campaign STRING,
    status STRING,
    revenue FLOAT64
);
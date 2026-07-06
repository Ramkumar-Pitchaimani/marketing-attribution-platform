/******************************************************************
PROJECT : Marketing Attribution Platform
SPRINT 5 & 6 VALIDATION SCRIPT
PROJECT ID : pro1-501113
DATASET : marketing_dw
******************************************************************/

---------------------------------------------------------------
SECTION 1 : SILVER TABLES
---------------------------------------------------------------

-- Google Ads Clean

SELECT COUNT(*) AS google_ads_clean
FROM `pro1-501113.marketing_dw.google_ads_clean`;

---------------------------------------------------------------

SELECT *
FROM `pro1-501113.marketing_dw.google_ads_clean`
LIMIT 10;

---------------------------------------------------------------

-- Meta Ads Clean

SELECT COUNT(*) AS meta_ads_clean
FROM `pro1-501113.marketing_dw.meta_ads_clean`;

---------------------------------------------------------------

SELECT *
FROM `pro1-501113.marketing_dw.meta_ads_clean`
LIMIT 10;

---------------------------------------------------------------

-- CRM Clean

SELECT COUNT(*) AS crm_leads_clean
FROM `pro1-501113.marketing_dw.crm_leads_clean`;

---------------------------------------------------------------

SELECT *
FROM `pro1-501113.marketing_dw.crm_leads_clean`
LIMIT 10;





/******************************************************************
SECTION 2 : DIMENSION TABLES
******************************************************************/

---------------------------------------------------------------
-- Campaign Dimension
---------------------------------------------------------------

SELECT COUNT(*) AS dim_campaign
FROM `pro1-501113.marketing_dw.dim_campaign`;

---------------------------------------------------------------

SELECT *
FROM `pro1-501113.marketing_dw.dim_campaign`
LIMIT 20;

---------------------------------------------------------------
-- Duplicate Campaign Check
---------------------------------------------------------------

SELECT

campaign_name,

marketing_channel,

COUNT(*) duplicates

FROM `pro1-501113.marketing_dw.dim_campaign`

GROUP BY

campaign_name,

marketing_channel

HAVING COUNT(*) > 1

ORDER BY duplicates DESC;





---------------------------------------------------------------
-- Channel Dimension
---------------------------------------------------------------

SELECT *
FROM `pro1-501113.marketing_dw.dim_channel`;

---------------------------------------------------------------
-- Date Dimension
---------------------------------------------------------------

SELECT COUNT(*) AS dim_date
FROM `pro1-501113.marketing_dw.dim_date`;

---------------------------------------------------------------

SELECT *
FROM `pro1-501113.marketing_dw.dim_date`
LIMIT 20;





/******************************************************************
SECTION 3 : FACT TABLES
******************************************************************/

---------------------------------------------------------------
-- Fact Marketing
---------------------------------------------------------------

SELECT COUNT(*) AS fact_marketing
FROM `pro1-501113.marketing_dw.fact_marketing`;

---------------------------------------------------------------

SELECT *
FROM `pro1-501113.marketing_dw.fact_marketing`
LIMIT 20;

---------------------------------------------------------------
-- Marketing Totals
---------------------------------------------------------------

SELECT

SUM(spend) total_spend,

SUM(clicks) total_clicks,

SUM(impressions) total_impressions,

SUM(conversions) total_conversions,

SUM(conversion_value) total_conversion_value

FROM `pro1-501113.marketing_dw.fact_marketing`;

---------------------------------------------------------------
-- Marketing by Channel
---------------------------------------------------------------

SELECT

d.channel_name,

COUNT(*) records,

SUM(f.spend) spend,

SUM(f.clicks) clicks,

SUM(f.conversions) conversions

FROM `pro1-501113.marketing_dw.fact_marketing` f

JOIN `pro1-501113.marketing_dw.dim_channel` d

ON f.channel_key=d.channel_key

GROUP BY d.channel_name;





---------------------------------------------------------------
-- Fact Leads
---------------------------------------------------------------

SELECT COUNT(*) AS fact_leads
FROM `pro1-501113.marketing_dw.fact_leads`;

---------------------------------------------------------------

SELECT *
FROM `pro1-501113.marketing_dw.fact_leads`
LIMIT 20;

---------------------------------------------------------------
-- Revenue Summary
---------------------------------------------------------------

SELECT

COUNT(*) total_rows,

SUM(revenue) total_revenue,

AVG(revenue) average_revenue

FROM `pro1-501113.marketing_dw.fact_leads`;

---------------------------------------------------------------
-- Campaign Matching
---------------------------------------------------------------

SELECT

COUNT(*) total_rows,

COUNT(campaign_key) matched_campaigns,

COUNT(*)-COUNT(campaign_key) unmatched_campaigns

FROM `pro1-501113.marketing_dw.fact_leads`;





/******************************************************************
SECTION 4 : REPORTING VIEWS
******************************************************************/

---------------------------------------------------------------
-- Campaign Performance
---------------------------------------------------------------

SELECT *
FROM `pro1-501113.marketing_dw.vw_campaign_performance`
LIMIT 20;

---------------------------------------------------------------
-- Channel Performance
---------------------------------------------------------------

SELECT *
FROM `pro1-501113.marketing_dw.vw_channel_performance`;

---------------------------------------------------------------
-- Daily Summary
---------------------------------------------------------------

SELECT *
FROM `pro1-501113.marketing_dw.vw_daily_summary`
LIMIT 20;

---------------------------------------------------------------
-- Dashboard Metrics
---------------------------------------------------------------

SELECT *
FROM `pro1-501113.marketing_dw.vw_dashboard_metrics`;





/******************************************************************
SECTION 5 : DATA QUALITY CHECKS
******************************************************************/

---------------------------------------------------------------
-- NULL Campaign Keys
---------------------------------------------------------------

SELECT

COUNT(*) missing_campaign_key

FROM `pro1-501113.marketing_dw.fact_marketing`

WHERE campaign_key IS NULL;

---------------------------------------------------------------
-- NULL Channel Keys
---------------------------------------------------------------

SELECT

COUNT(*) missing_channel_key

FROM `pro1-501113.marketing_dw.fact_marketing`

WHERE channel_key IS NULL;

---------------------------------------------------------------
-- Negative Spend
---------------------------------------------------------------

SELECT *

FROM `pro1-501113.marketing_dw.fact_marketing`

WHERE spend < 0;

---------------------------------------------------------------
-- Negative Revenue
---------------------------------------------------------------

SELECT *

FROM `pro1-501113.marketing_dw.fact_leads`

WHERE revenue < 0;

---------------------------------------------------------------
-- Duplicate Lead IDs
---------------------------------------------------------------

SELECT

lead_id,

COUNT(*)

FROM `pro1-501113.marketing_dw.fact_leads`

GROUP BY lead_id

HAVING COUNT(*) > 1;

---------------------------------------------------------------
-- Duplicate Campaign Keys
---------------------------------------------------------------

SELECT

campaign_key,

COUNT(*)

FROM `pro1-501113.marketing_dw.dim_campaign`

GROUP BY campaign_key

HAVING COUNT(*) > 1;





/******************************************************************
SECTION 6 : FINAL PROJECT SUMMARY
******************************************************************/

SELECT

(SELECT COUNT(*) FROM `pro1-501113.marketing_dw.google_ads_clean`) AS google_ads,

(SELECT COUNT(*) FROM `pro1-501113.marketing_dw.meta_ads_clean`) AS meta_ads,

(SELECT COUNT(*) FROM `pro1-501113.marketing_dw.crm_leads_clean`) AS crm_leads,

(SELECT COUNT(*) FROM `pro1-501113.marketing_dw.dim_campaign`) AS dim_campaign,

(SELECT COUNT(*) FROM `pro1-501113.marketing_dw.dim_channel`) AS dim_channel,

(SELECT COUNT(*) FROM `pro1-501113.marketing_dw.dim_date`) AS dim_date,

(SELECT COUNT(*) FROM `pro1-501113.marketing_dw.fact_marketing`) AS fact_marketing,

(SELECT COUNT(*) FROM `pro1-501113.marketing_dw.fact_leads`) AS fact_leads;

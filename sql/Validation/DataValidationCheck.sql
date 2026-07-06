/******************************************************************************
 Project  : Marketing Attribution Pipeline
 Purpose  : Execute post-load data quality checks after ETL completion.

 Expected Outcome:
 -----------------
 ✔ Row counts should match source files
 ✔ No duplicate business keys
 ✔ No NULL primary/business keys
 ✔ No negative spend/revenue values
 ✔ No future dates

******************************************************************************/

--------------------------------------------------------------------------------
-- VALIDATION 1 : ROW COUNT VALIDATION
--
-- Purpose:
-- Verify all source files were loaded completely.
--
-- Expected Result:
-- Google Ads : 5000 rows
-- Meta Ads   : 5000 rows
-- CRM Leads  : 2000 rows
--------------------------------------------------------------------------------

SELECT
'Google Ads' AS table_name,
COUNT(*) AS total_rows
FROM marketing_dw.google_ads_clean

UNION ALL

SELECT
'Meta Ads',
COUNT(*)
FROM marketing_dw.meta_ads_clean

UNION ALL

SELECT
'CRM Leads',
COUNT(*)
FROM marketing_dw.crm_leads_clean;

--------------------------------------------------------------------------------
-- VALIDATION 2 : NEGATIVE SPEND CHECK
--
-- Purpose:
-- Marketing spend can never be negative.
--
-- Expected Result:
-- 0 rows
--------------------------------------------------------------------------------

SELECT *
FROM marketing_dw.google_ads_clean
WHERE cost < 0;

--------------------------------------------------------------------------------
-- VALIDATION 3 : NEGATIVE META SPEND CHECK
--
-- Purpose:
-- Validate Meta Ads spend.
--
-- Expected Result:
-- 0 rows
--------------------------------------------------------------------------------

SELECT *
FROM marketing_dw.meta_ads_clean
WHERE spend < 0;

--------------------------------------------------------------------------------
-- VALIDATION 4 : NEGATIVE REVENUE CHECK
--
-- Purpose:
-- Revenue should never be negative.
--
-- Expected Result:
-- 0 rows
--------------------------------------------------------------------------------

SELECT *
FROM marketing_dw.crm_leads_clean
WHERE revenue < 0;

--------------------------------------------------------------------------------
-- VALIDATION 5 : DUPLICATE CRM LEADS
--
-- Purpose:
-- Each Lead ID should appear only once.
--
-- Expected Result:
-- 0 rows
--------------------------------------------------------------------------------

SELECT
lead_id,
COUNT(*) AS duplicate_count
FROM marketing_dw.crm_leads_clean
GROUP BY lead_id
HAVING COUNT(*) > 1;

--------------------------------------------------------------------------------
-- VALIDATION 6 : DUPLICATE GOOGLE CAMPAIGN RECORDS
--
-- Purpose:
-- Validate uniqueness of Campaign + Date combination.
--
-- Expected Result:
-- 0 rows
--------------------------------------------------------------------------------

SELECT
campaign_id,
date,
COUNT(*) AS duplicate_count
FROM marketing_dw.google_ads_clean
GROUP BY campaign_id, date
HAVING COUNT(*) > 1;

--------------------------------------------------------------------------------
-- VALIDATION 7 : NULL CAMPAIGN ID
--
-- Purpose:
-- Campaign ID is mandatory.
--
-- Expected Result:
-- 0 rows
--------------------------------------------------------------------------------

SELECT *
FROM marketing_dw.google_ads_clean
WHERE campaign_id IS NULL;

--------------------------------------------------------------------------------
-- VALIDATION 8 : NULL LEAD ID
--
-- Purpose:
-- Lead ID is mandatory.
--
-- Expected Result:
-- 0 rows
--------------------------------------------------------------------------------

SELECT *
FROM marketing_dw.crm_leads_clean
WHERE lead_id IS NULL;

--------------------------------------------------------------------------------
-- VALIDATION 9 : FUTURE GOOGLE ADS DATES
--
-- Purpose:
-- Marketing data should never have future dates.
--
-- Expected Result:
-- 0 rows
--------------------------------------------------------------------------------

SELECT *
FROM marketing_dw.google_ads_clean
WHERE date > CURRENT_DATE();

--------------------------------------------------------------------------------
-- VALIDATION 10 : FUTURE CRM LEAD DATES
--
-- Purpose:
-- CRM lead dates should not be in the future.
--
-- Expected Result:
-- 0 rows
--------------------------------------------------------------------------------

SELECT *
FROM marketing_dw.crm_leads_clean
WHERE lead_date > CURRENT_DATE();

--------------------------------------------------------------------------------
-- VALIDATION SUMMARY
--
-- Successful execution means:
--
-- ✔ Google Ads Row Count = 5000
-- ✔ Meta Ads Row Count   = 5000
-- ✔ CRM Leads Row Count  = 2000
--
-- ✔ Negative Spend       = 0 rows
-- ✔ Negative Revenue     = 0 rows
--
-- ✔ Duplicate Leads      = 0 rows
-- ✔ Duplicate Campaigns  = 0 rows
--
-- ✔ NULL Campaign IDs    = 0 rows
-- ✔ NULL Lead IDs        = 0 rows
--
-- ✔ Future Dates         = 0 rows
--
-- If all validations pass, the dataset is considered ETL-ready.
--------------------------------------------------------------------------------
# Sprint 5 - Data Warehouse (Silver, Dimensions & Facts)

## Objective

Build the enterprise Data Warehouse in BigQuery using a Star Schema.

Architecture

CSV Files
      │
      ▼
Cloud Storage
      │
      ▼
Eventarc
      │
      ▼
Cloud Run ETL
      │
      ▼
Bronze Layer
      │
      ▼
Silver Layer
      │
      ▼
Dimensions
      │
      ▼
Facts

------------------------------------------------------------
PART 1 - SILVER LAYER
------------------------------------------------------------

Created SQL files

sql/silver/

01_silver_google_ads.sql

02_silver_meta_ads.sql

03_silver_crm.sql

Tables Created

google_ads_clean

meta_ads_clean

crm_leads_clean

Verification

SELECT COUNT(*) FROM marketing_dw.google_ads_clean;
Expected : 5000

SELECT COUNT(*) FROM marketing_dw.meta_ads_clean;
Expected : 5000

SELECT COUNT(*) FROM marketing_dw.crm_leads_clean;
Expected : 2000

------------------------------------------------------------
PART 2 - DIMENSION TABLES
------------------------------------------------------------

Created SQL

sql/gold/

01_dim_campaign.sql

02_dim_channel.sql

03_dim_date.sql

Tables

dim_campaign

dim_channel

dim_date

Verification

SELECT COUNT(*) FROM marketing_dw.dim_campaign;

SELECT COUNT(*) FROM marketing_dw.dim_channel;

SELECT COUNT(*) FROM marketing_dw.dim_date;

Expected

dim_campaign → Hundreds of rows

dim_channel → 2 rows

dim_date → Around 730 rows

------------------------------------------------------------
PART 3 - FACT TABLES
------------------------------------------------------------

Created SQL

sql/gold/

01_fact_marketing.sql

02_fact_leads.sql

Fact Marketing

Combines

Google Ads

Meta Ads

Metrics

Spend

Clicks

Impressions

Conversions

Conversion Value

Verification

SELECT COUNT(*)
FROM marketing_dw.fact_marketing;

Expected

10000 rows

Fact Leads

CRM Leads joined to Campaigns

Matching logic

gclid

fbclid

utm_campaign

Note

Mock data produced duplicate campaign matches,
resulting in approximately 89K rows instead of 2K.

This was accepted for the portfolio project and
identified as a data-model limitation to be improved later.

------------------------------------------------------------
OUTPUT OF SPRINT 5
------------------------------------------------------------

Bronze

✓ google_ads_raw

✓ meta_ads_raw

✓ crm_leads_raw

Silver

✓ google_ads_clean

✓ meta_ads_clean

✓ crm_leads_clean

Dimensions

✓ dim_campaign

✓ dim_channel

✓ dim_date

Facts

✓ fact_marketing

✓ fact_leads
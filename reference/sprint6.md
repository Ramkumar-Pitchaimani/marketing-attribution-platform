# Sprint 6 - Reporting Layer

## Objective

Create reporting views on top of the warehouse
to be consumed by Looker Studio.

Architecture

Fact Tables
      │
      ▼
Reporting Views
      │
      ▼
Looker Studio

------------------------------------------------------------
PART 1 - CAMPAIGN PERFORMANCE
------------------------------------------------------------

Created

sql/views/

01_campaign_performance.sql

View

vw_campaign_performance

Metrics

Campaign

Marketing Channel

Impressions

Clicks

Spend

Conversions

CTR

Average CPC

Cost per Conversion

Verification

SELECT *
FROM marketing_dw.vw_campaign_performance
LIMIT 20;

------------------------------------------------------------
PART 2 - CHANNEL PERFORMANCE
------------------------------------------------------------

Created

02_channel_performance.sql

View

vw_channel_performance

Metrics

Google Ads

Meta Ads

Spend

Clicks

CTR

Average CPC

Verification

SELECT *
FROM marketing_dw.vw_channel_performance;

------------------------------------------------------------
PART 3 - DAILY SUMMARY
------------------------------------------------------------

Created

03_daily_summary.sql

View

vw_daily_summary

Metrics

Daily Spend

Daily Clicks

Daily Impressions

Daily Conversions

Daily Conversion Value

Verification

SELECT *
FROM marketing_dw.vw_daily_summary;

------------------------------------------------------------
PART 4 - EXECUTIVE DASHBOARD
------------------------------------------------------------

Created

04_dashboard_metrics.sql

View

vw_dashboard_metrics

Executive KPIs

Total Spend

Total Clicks

Total Impressions

Total Conversions

Total Conversion Value

CTR

Average CPC

Cost Per Conversion

ROAS

Verification

SELECT *
FROM marketing_dw.vw_dashboard_metrics;

------------------------------------------------------------
OUTPUT OF SPRINT 6
------------------------------------------------------------

Reporting Views

✓ vw_campaign_performance

✓ vw_channel_performance

✓ vw_daily_summary

✓ vw_dashboard_metrics

Warehouse Status

CSV Files

↓

Cloud Storage

↓

Eventarc

↓

Cloud Run

↓

Bronze

↓

Silver

↓

Dimensions

↓

Facts

↓

Views

Ready for Looker Studio
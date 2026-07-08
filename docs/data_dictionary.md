# Data Dictionary

## Marketing Attribution Platform on Google Cloud Platform (GCP)

---

# Overview

This document describes the datasets, tables, views, and their business purpose used in the Marketing Attribution Platform.

The platform follows the **Medallion Architecture**:

```
Bronze
   ↓
Silver
   ↓
Gold (Dimensions + Facts)
   ↓
Reporting Views
```

---

# Dataset

Dataset Name

```
marketing_dw
```

---

# Bronze Layer

The Bronze layer stores raw data exactly as received from the source systems.

| Table | Description | Source |
|--------|-------------|--------|
| google_ads_raw | Raw Google Ads marketing data | Google Ads CSV |
| meta_ads_raw | Raw Meta Ads marketing data | Meta Ads CSV |
| crm_leads_raw | Raw CRM lead information | CRM CSV |

---

## google_ads_raw

Purpose

Stores Google Ads campaign performance without transformations.

Primary Fields

| Column | Description |
|---------|-------------|
| campaign_date | Campaign reporting date |
| campaign_id | Campaign identifier |
| campaign_name | Campaign name |
| impressions | Number of impressions |
| clicks | Number of clicks |
| cost | Advertising spend |
| conversions | Total conversions |
| conversion_value | Revenue generated |
| gclid | Google Click Identifier |

---

## meta_ads_raw

Purpose

Stores Meta Ads campaign performance.

Primary Fields

| Column | Description |
|---------|-------------|
| campaign_date | Campaign reporting date |
| campaign_id | Campaign identifier |
| campaign_name | Campaign name |
| impressions | Number of impressions |
| clicks | Number of clicks |
| spend | Advertising spend |
| conversions | Total conversions |
| conversion_value | Revenue generated |
| fbclid | Facebook Click Identifier |

---

## crm_leads_raw

Purpose

Stores incoming CRM leads.

Primary Fields

| Column | Description |
|---------|-------------|
| lead_id | Lead Identifier |
| lead_date | Lead creation date |
| customer_name | Customer Name |
| lead_source | Lead source |
| gclid | Google Click ID |
| fbclid | Facebook Click ID |
| utm_campaign | Marketing campaign |
| status | Lead status |
| revenue | Revenue generated |

---

# Silver Layer

The Silver layer contains standardized, cleansed, and validated datasets.

| Table | Description |
|--------|-------------|
| google_ads_clean | Clean Google Ads data |
| meta_ads_clean | Clean Meta Ads data |
| crm_leads_clean | Clean CRM Leads |

Transformations applied

- Standardized column names
- Data type conversion
- NULL handling
- Business rule validation
- Data quality checks

---

# Gold Layer

## Dimension Tables

---

### dim_campaign

Purpose

Master list of marketing campaigns.

Primary Key

```
campaign_key
```

Important Columns

| Column | Description |
|---------|-------------|
| campaign_key | Surrogate key |
| campaign_id | Source campaign ID |
| campaign_name | Campaign Name |
| campaign_type | Campaign Type |
| marketing_channel | Google Ads / Meta Ads |
| first_seen | First campaign date |
| last_seen | Last campaign date |

---

### dim_channel

Purpose

Marketing channel reference.

| Column | Description |
|---------|-------------|
| channel_key | Surrogate key |
| channel_name | Marketing Channel |
| channel_type | Paid Search / Paid Social |
| vendor | Google / Meta |

---

### dim_device

Purpose

Stores device types used in advertising.

Example Values

- Desktop
- Mobile
- Tablet

---

### dim_date

Purpose

Calendar dimension.

Contains

- Year
- Quarter
- Month
- Week
- Day
- Month Name
- Weekday
- Weekend Flag

---

# Fact Tables

---

## fact_marketing

Purpose

Stores campaign performance metrics.

Grain

One record per

```
Campaign
+
Date
+
Marketing Channel
```

Measures

| Column | Description |
|---------|-------------|
| impressions | Ad impressions |
| clicks | Ad clicks |
| spend | Advertising spend |
| conversions | Total conversions |
| conversion_value | Revenue generated |

Foreign Keys

- campaign_key
- channel_key

---

## fact_leads

Purpose

Stores CRM lead attribution.

Grain

One row per Lead.

Measures

| Column | Description |
|---------|-------------|
| revenue | Revenue |
| status | Lead Status |

Foreign Keys

- campaign_key
- channel_key

---

# Reporting Views

---

## vw_dashboard_metrics

Purpose

Executive KPI dashboard.

Metrics

- Total Spend
- Total Clicks
- Total Impressions
- Total Conversions
- Total Revenue
- CTR
- Average CPC
- ROAS

---

## vw_campaign_performance

Purpose

Campaign level reporting.

Metrics

- Spend
- Clicks
- Impressions
- Conversions
- CTR
- CPC

---

## vw_channel_performance

Purpose

Marketing channel comparison.

Metrics

- Spend
- Clicks
- Conversions
- CTR
- Average CPC

---

## vw_daily_summary

Purpose

Daily trend reporting.

Metrics

- Daily Spend
- Daily Clicks
- Daily Revenue
- Daily Conversions

---

## vw_lead_attribution

Purpose

Lead attribution dashboard.

Metrics

- Lead Count
- Converted Leads
- Qualified Leads
- Revenue

Dimensions

- Marketing Channel
- Campaign
- Lead Status

---

# Data Quality Rules

The following validations are executed.

- Raw vs Clean Row Count
- Clean vs Fact Row Count
- NULL Validation
- Duplicate Validation
- Referential Integrity
- Business Rule Validation
- Dashboard Validation

---

# Data Refresh

Pipeline Trigger

```
Google Cloud Storage Upload
        ↓
Eventarc
        ↓
Cloud Run
        ↓
BigQuery Bronze
        ↓
SQL Transformations
        ↓
Silver
        ↓
Dimensions
        ↓
Facts
        ↓
Views
        ↓
Looker Studio
```

---

# Business KPIs

The platform calculates the following KPIs.

- Total Spend
- Total Clicks
- Total Impressions
- Total Conversions
- Conversion Rate (CTR)
- Average CPC
- Cost Per Lead (CPL)
- Cost Per Acquisition (CPA)
- Return On Ad Spend (ROAS)
- Revenue by Campaign
- Revenue by Channel

---

# Technology Stack

- Google Cloud Storage
- Eventarc
- Cloud Run
- BigQuery
- SQL
- Python
- Flask
- Docker
- Cloud Build
- GitHub
- Looker Studio

---

# Author

Marketing Attribution Platform

Google Cloud Platform Data Engineering Portfolio Project

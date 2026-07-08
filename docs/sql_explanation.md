# SQL Transformation Guide

## Marketing Attribution Platform on Google Cloud Platform (GCP)

---

# Overview

This document explains the purpose of each SQL script used in the Marketing Attribution Platform.

The project follows the **Medallion Architecture**:

```
Raw (Bronze)
        ↓
Clean (Silver)
        ↓
Dimensions
        ↓
Facts
        ↓
Reporting Views
        ↓
Looker Studio
```

---

# SQL Folder Structure

```
sql/

├── bronze/
├── silver/
├── gold/
│   ├── dimensions/
│   ├── facts/
│   └── views/
└── validation/
```

---

# Bronze Layer

## Purpose

The Bronze layer stores source data exactly as received from Cloud Storage.

No transformations are performed.

### Tables

- google_ads_raw
- meta_ads_raw
- crm_leads_raw

---

# Silver Layer

## Purpose

The Silver layer standardizes raw data into clean analytical datasets.

Transformations include:

- Data type conversion
- Date formatting
- NULL handling
- Standardized column names
- Data quality improvements
- Business rule enforcement

### SQL Scripts

```
google_ads_clean.sql
meta_ads_clean.sql
crm_leads_clean.sql
```

### Output Tables

- google_ads_clean
- meta_ads_clean
- crm_leads_clean

---

# Gold Layer

The Gold layer contains the business warehouse.

It consists of

- Dimension Tables
- Fact Tables
- Reporting Views

---

# Dimension SQL

---

## dim_date.sql

Purpose

Creates a reusable calendar dimension.

Contains

- Date
- Year
- Quarter
- Month
- Week
- Weekday
- Weekend Flag

Business Benefit

Used for trend analysis and time intelligence.

---

## dim_campaign.sql

Purpose

Creates a master campaign dimension by combining campaigns from Google Ads and Meta Ads.

Contains

- Campaign ID
- Campaign Name
- Campaign Type
- Marketing Channel
- First Seen
- Last Seen

Business Benefit

Provides a single campaign reference across all marketing platforms.

---

## dim_channel.sql

Purpose

Creates the marketing channel dimension.

Contains

- Google Ads
- Meta Ads

Business Benefit

Supports channel-level reporting.

---

## dim_device.sql

Purpose

Stores advertising device types.

Contains

- Desktop
- Mobile
- Tablet

Business Benefit

Enables device-level performance analysis.

---

# Fact SQL

---

## fact_marketing.sql

Purpose

Creates the central marketing fact table.

Source

- google_ads_clean
- meta_ads_clean

Measures

- Impressions
- Clicks
- Spend
- Conversions
- Conversion Value

Foreign Keys

- campaign_key
- channel_key

Business Benefit

Provides campaign performance metrics for dashboards.

---

## fact_leads.sql

Purpose

Creates the lead attribution fact table.

Source

- crm_leads_clean

Measures

- Revenue

Dimensions

- Campaign
- Marketing Channel
- Lead Status

Business Benefit

Connects CRM leads with marketing campaigns.

---

# Reporting Views

---

## vw_dashboard_metrics.sql

Purpose

Creates executive KPIs.

Metrics

- Total Spend
- Total Clicks
- Total Impressions
- Total Conversions
- Total Revenue
- CTR
- Average CPC
- Cost Per Conversion
- ROAS

Used By

Executive Dashboard

---

## vw_campaign_performance.sql

Purpose

Campaign-level reporting.

Metrics

- Spend
- Clicks
- Impressions
- Conversions
- CTR
- Average CPC

Used By

Campaign Dashboard

---

## vw_channel_performance.sql

Purpose

Aggregates performance by marketing channel.

Metrics

- Spend
- Clicks
- Conversions
- CTR
- Average CPC

Used By

Channel Dashboard

---

## vw_daily_summary.sql

Purpose

Provides daily aggregated metrics.

Metrics

- Daily Spend
- Daily Clicks
- Daily Impressions
- Daily Conversions
- Daily Revenue

Used By

Executive Dashboard Trend Charts

---

## vw_lead_attribution.sql

Purpose

Provides lead attribution reporting.

Dimensions

- Marketing Channel
- Campaign
- Lead Status

Measures

- Revenue
- Lead Count

Used By

Lead Attribution Dashboard

---

# Validation SQL

The validation folder verifies data quality after every load.

---

## 01_raw_vs_clean_counts.sql

Purpose

Verifies that every raw record is loaded into the Silver layer.

Validation

```
Raw Count = Clean Count
```

---

## 02_clean_vs_fact_counts.sql

Purpose

Ensures all clean records are loaded into fact tables.

Validation

```
Clean Count = Fact Count
```

---

## 03_dimension_validation.sql

Purpose

Verifies dimension tables contain data.

Checks

- dim_date
- dim_campaign
- dim_channel
- dim_device

---

## 04_null_checks.sql

Purpose

Detects NULL values in mandatory columns.

Checks

- Campaign ID
- Campaign Name
- Dates
- Lead ID

---

## 05_duplicate_checks.sql

Purpose

Detects duplicate business keys.

Checks

- GCLID
- FBCLID
- Lead ID

---

## 06_referential_integrity.sql

Purpose

Verifies foreign key relationships.

Checks

```
Fact → Dimension
```

Relationships

- campaign_key
- channel_key

---

## 07_business_rules.sql

Purpose

Validates business rules.

Checks

- Negative Spend
- Negative Clicks
- Negative Impressions
- Negative Conversions

---

## 08_dashboard_validation.sql

Purpose

Ensures dashboard totals match warehouse totals.

Checks

- Total Spend
- Total Clicks
- Total Revenue
- Total Conversions

---

# SQL Execution Order

Execute SQL in the following order.

```
1. Bronze Tables
        ↓
2. Silver Tables
        ↓
3. Dimension Tables
        ↓
4. Fact Tables
        ↓
5. Reporting Views
        ↓
6. Validation Scripts
        ↓
7. Looker Studio
```

---

# SQL Design Principles

The project follows the following engineering principles.

- Layered Architecture
- Separation of Raw and Clean Data
- Star Schema Modeling
- Surrogate Keys
- Idempotent SQL
- Reusable Reporting Views
- Validation-First Approach

---

# Business Benefits

The SQL transformations provide:

- Clean analytical datasets
- Standardized marketing metrics
- Unified campaign reporting
- Lead attribution analysis
- Executive KPI reporting
- Historical trend analysis
- Production-ready validation framework

---

# Technologies Used

- BigQuery Standard SQL
- Google Cloud Storage
- Cloud Run
- Eventarc
- Looker Studio

---

# Summary

The SQL layer transforms raw marketing data into a production-ready analytical warehouse using a Medallion Architecture.

This approach separates ingestion, cleansing, dimensional modeling, reporting, and validation, making the solution scalable, maintainable, and suitable for enterprise analytics.
# Marketing Attribution Platform on Google Cloud Platform (GCP)

## Overview

This project demonstrates an end-to-end **Marketing Attribution Platform** built entirely on **Google Cloud Platform (GCP)** using an event-driven architecture.

The platform automatically ingests marketing data from Google Ads, Meta Ads, and CRM systems into BigQuery, transforms the data into a dimensional warehouse, and provides reporting-ready datasets for Looker Studio dashboards.

This project simulates a real-world marketing analytics pipeline similar to those used by digital marketing and analytics teams.

---

# Business Problem

Marketing teams typically receive data from multiple advertising platforms:

- Google Ads
- Meta (Facebook) Ads
- CRM / Lead Management System

Since these systems are independent, it becomes difficult to answer questions like:

- Which campaign generated the most revenue?
- Which marketing channel has the highest ROI?
- What is the Cost Per Lead (CPL)?
- What is the Return On Ad Spend (ROAS)?
- Which campaigns are underperforming?

This project solves those challenges by building a centralized analytics platform.

---

# Solution Architecture

```

Google Ads CSV
Meta Ads CSV
CRM Leads CSV

↓

Google Cloud Storage (GCS)

↓

Eventarc Trigger

↓

Cloud Run (Python ETL)

↓

BigQuery Bronze Layer

↓

BigQuery Silver Layer

↓

Dimension Tables

↓

Fact Tables

↓

Reporting Views

↓

Looker Studio Dashboard

```

---

# Architecture Components

| Component | Purpose |
|------------|----------|
| Google Cloud Storage | Landing zone for marketing files |
| Eventarc | Detects file uploads |
| Cloud Run | Executes ETL automatically |
| Python | Data loading and processing |
| BigQuery | Data Warehouse |
| SQL | Data transformations |
| Looker Studio | Reporting Dashboard |

---

# Technology Stack

- Google Cloud Platform (GCP)
- Cloud Storage
- Eventarc
- Cloud Run
- BigQuery
- Python 3.12
- Flask
- Google Cloud SDK
- Docker
- SQL
- Git
- GitHub
- Looker Studio

---

# Dataset

Three sample datasets were created.

| Dataset | Records |
|----------|---------|
| Google Ads | 5,000 |
| Meta Ads | 5,000 |
| CRM Leads | 2,000 |

---

# Project Structure

```

marketing-attribution-platform/

app.py

loader.py

config.py

logger.py

utils.py

Dockerfile

requirements.txt

sample_data/

google_ads_mock_5000.csv

meta_ads_mock_5000.csv

crm_leads_mock_2000.csv

sql/

silver/

gold/

views/

validation/

docs/

sprint1.md

sprint2.md

sprint3.md

sprint4.md

sprint5.md

sprint6.md

README.md

```

---

# Data Warehouse Architecture

## Bronze Layer

Raw landing tables.

- google_ads_raw
- meta_ads_raw
- crm_leads_raw

---

## Silver Layer

Cleaned and standardized tables.

- google_ads_clean
- meta_ads_clean
- crm_leads_clean

---

## Dimension Tables

- dim_campaign
- dim_channel
- dim_date

---

## Fact Tables

- fact_marketing
- fact_leads

---

## Reporting Views

- vw_campaign_performance
- vw_channel_performance
- vw_daily_summary
- vw_dashboard_metrics

---

# Event Flow

1. Marketing CSV uploaded into Cloud Storage
2. Eventarc detects new file
3. Eventarc triggers Cloud Run
4. Cloud Run executes Python ETL
5. CSV loaded into BigQuery Bronze layer
6. SQL transforms Bronze → Silver
7. SQL builds Dimensions
8. SQL builds Fact Tables
9. SQL creates Reporting Views
10. Looker Studio consumes Reporting Views

---

# Features

- Event-driven architecture
- Serverless data ingestion
- Automatic BigQuery loading
- Modular SQL transformations
- Star schema data warehouse
- Marketing attribution model
- Executive reporting views
- Cloud-native architecture

---

# Key Business Metrics

The platform calculates:

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

# Validation

Validation SQL scripts are available under

```

sql/validation/

```

These scripts verify

- Row counts
- Duplicate records
- NULL values
- Fact table integrity
- Dimension integrity
- Data quality
- Executive summary counts

---

# Deployment Steps

1. Create GCP Project
2. Enable APIs
3. Create Cloud Storage bucket
4. Upload sample data
5. Create BigQuery dataset
6. Deploy Cloud Run
7. Configure Eventarc trigger
8. Execute SQL transformations
9. Connect Looker Studio

---

# Future Improvements

- Google Ads API Integration
- Meta Marketing API Integration
- Incremental Loading
- Slowly Changing Dimensions (SCD Type 2)
- Dataform / dbt implementation
- Cloud Composer orchestration
- CI/CD using Cloud Build
- Cloud Monitoring alerts
- Data Quality Framework
- Unit testing
- Terraform Infrastructure as Code

---

# Sample Dashboard

Dashboard pages include:

- Executive Summary
- Campaign Performance
- Channel Performance
- Daily Trends
- Spend vs Revenue
- Top Campaigns
- Marketing Funnel
- ROAS Analysis

---

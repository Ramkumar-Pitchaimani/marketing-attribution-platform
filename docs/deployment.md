# Deployment Guide

# Marketing Attribution Platform on Google Cloud Platform (GCP)

---

# Overview

This guide explains how to deploy the Marketing Attribution Platform from scratch on Google Cloud Platform.

The application implements an event-driven ETL pipeline that automatically ingests marketing data into BigQuery and visualizes campaign performance in Looker Studio.

---

# Architecture

```
CSV Files
      │
      ▼
Cloud Storage
      │
      ▼
Eventarc
      │
      ▼
Cloud Run (Python ETL)
      │
      ▼
BigQuery Bronze
      │
      ▼
BigQuery Silver
      │
      ▼
Dimensions
      │
      ▼
Fact Tables
      │
      ▼
Reporting Views
      │
      ▼
Looker Studio
```

---

# Prerequisites

- Google Cloud Project
- Billing Enabled
- gcloud CLI
- Docker Desktop
- Git
- Python 3.11+
- VS Code

---

# Project Information

| Item | Value |
|------|-------|
| Project ID | `pro1-501113` |
| Region | `us-central1` |
| Runtime | Python 3.11 |
| Dataset | `marketing_dw` |
| Bucket | `marketing-files` |

---

# Enable APIs

Enable the following Google Cloud APIs:

- Cloud Run
- Cloud Build
- Artifact Registry
- Eventarc
- Cloud Storage
- BigQuery
- Cloud Logging

---

# Clone Repository

```bash
git clone <repository-url>

cd marketing-attribution-platform
```

---

# Install Python Dependencies

```bash
pip install -r requirements.txt
```

---

# Configure GCP Authentication

```bash
gcloud auth login
```

Set project

```bash
gcloud config set project pro1-501113
```

---

# Create Cloud Storage Bucket

```bash
gsutil mb \
-l us-central1 \
gs://marketing-files
```

---

# Create BigQuery Dataset

```bash
bq mk \
--dataset \
pro1-501113:marketing_dw
```

---

# Build Docker Image

```bash
gcloud builds submit \
--tag us-central1-docker.pkg.dev/pro1-501113/marketing-repo/marketing-etl
```

---

# Deploy Cloud Run

```bash
gcloud run deploy marketing-etl \
--image us-central1-docker.pkg.dev/pro1-501113/marketing-repo/marketing-etl \
--platform managed \
--region us-central1 \
--allow-unauthenticated
```

Deployment should complete successfully and return a Cloud Run URL.

---

# Configure Eventarc

Create a trigger to invoke Cloud Run whenever a CSV file is uploaded.

Trigger

```
Cloud Storage Object Finalize
```

Destination

```
Cloud Run
```

Bucket

```
marketing-files
```

---

# Upload Sample Files

Upload

```
google_ads.csv

meta_ads.csv

crm_leads.csv
```

to

```
gs://marketing-files
```

---

# Verify Cloud Run

Open

```
Cloud Run
```

Verify

- Request received
- CSV detected
- BigQuery load completed
- Status 200

---

# Verify BigQuery

Check Bronze tables

```
google_ads_raw

meta_ads_raw

crm_leads_raw
```

Check Silver tables

```
google_ads_clean

meta_ads_clean

crm_leads_clean
```

Verify row counts.

---

# Execute SQL Scripts

Run scripts in the following order.

## Silver

```
google_ads_clean.sql

meta_ads_clean.sql

crm_leads_clean.sql
```

---

## Dimensions

```
dim_date.sql

dim_campaign.sql

dim_channel.sql

dim_device.sql
```

---

## Facts

```
fact_marketing.sql

fact_leads.sql
```

---

## Reporting Views

```
vw_dashboard_metrics.sql

vw_campaign_performance.sql

vw_channel_performance.sql

vw_daily_summary.sql

vw_lead_attribution.sql
```

---

## Validation Scripts

Execute

```
01_raw_vs_clean_counts.sql

02_clean_vs_fact_counts.sql

03_dimension_validation.sql

04_null_checks.sql

05_duplicate_checks.sql

06_referential_integrity.sql

07_business_rules.sql

08_dashboard_validation.sql
```

All validation queries should complete successfully.

---

# Configure Looker Studio

Connect Looker Studio to the following views:

```
vw_dashboard_metrics

vw_campaign_performance

vw_channel_performance

vw_daily_summary

vw_lead_attribution
```

Create dashboards

- Executive Dashboard
- Campaign Performance
- Channel Analysis
- Lead Attribution

---

# End-to-End Testing

Upload a new CSV

↓

Verify Eventarc Trigger

↓

Verify Cloud Run Logs

↓

Verify Bronze Tables

↓

Verify Silver Tables

↓

Verify Fact Tables

↓

Verify Reporting Views

↓

Refresh Looker Studio

↓

Confirm dashboard updates

---

# Monitoring

Monitor

- Cloud Run Logs
- Cloud Logging
- Eventarc Trigger
- BigQuery Jobs

---

# Troubleshooting

## Cloud Run not triggered

Check

- Eventarc Trigger
- Bucket Name
- Region

---

## Data not loaded

Verify

- CSV Format
- Service Account Permissions
- BigQuery Dataset

---

## Dashboard not refreshing

Check

- Reporting Views
- BigQuery Data
- Refresh Looker Studio

---

# Repository Structure

```
marketing-attribution-platform/

app/

sql/

docs/

images/

requirements.txt

Dockerfile

README.md
```

---

# Deployment Checklist

| Step | Status |
|------|--------|
| APIs Enabled | ✅ |
| Bucket Created | ✅ |
| Dataset Created | ✅ |
| Cloud Run Deployed | ✅ |
| Eventarc Configured | ✅ |
| Bronze Tables Created | ✅ |
| Silver Tables Created | ✅ |
| Dimension Tables Created | ✅ |
| Fact Tables Created | ✅ |
| Reporting Views Created | ✅ |
| Validation Executed | ✅ |
| Dashboard Created | ✅ |
| End-to-End Testing Completed | ✅ |

---

# Technology Stack

- Google Cloud Storage
- Eventarc
- Cloud Run
- BigQuery
- Cloud Build
- Docker
- Python
- Flask
- SQL
- Looker Studio

---

# Deployment Status

**Project successfully deployed and validated using an event-driven architecture on Google Cloud Platform.**

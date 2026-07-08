# Marketing Attribution Platform on Google Cloud Platform (GCP)

![Python](https://img.shields.io/badge/Python-3.12-blue)
![Google Cloud](https://img.shields.io/badge/Google%20Cloud-GCP-blue)
![Cloud Run](https://img.shields.io/badge/Cloud%20Run-Serverless-success)
![BigQuery](https://img.shields.io/badge/BigQuery-Data%20Warehouse-blue)
![GitHub Actions](https://img.shields.io/badge/CI-CD-success)
![Status](https://img.shields.io/badge/Project-In%20Progress-orange)

---

# Overview

This project demonstrates an enterprise-style **Marketing Attribution Platform** built entirely on **Google Cloud Platform (GCP)** using a modern **serverless, event-driven architecture**.

The platform automatically ingests marketing data from multiple sources including **Google Ads, Meta Ads, and CRM systems**, loads the data into **BigQuery**, transforms it into an analytics-ready data warehouse, and prepares reporting datasets for **Looker Studio** dashboards.

This project closely simulates a production-grade marketing analytics platform used by digital marketing and analytics teams.

---

# Business Problem

Marketing teams receive campaign data from multiple independent systems.

- Google Ads
- Meta (Facebook) Ads
- CRM / Lead Management Systems

Since these platforms are disconnected, answering business questions becomes difficult.

Examples include:

- Which campaign generated the highest revenue?
- Which marketing channel delivers the best ROI?
- What is the Cost Per Lead (CPL)?
- What is the Return On Ad Spend (ROAS)?
- Which campaigns should receive additional budget?

This project solves those challenges by creating a centralized analytics platform on GCP.

---

# Solution Architecture

```
                    Google Ads
                    Meta Ads
                    CRM

                       │
                       ▼

          Google Cloud Storage (Landing)

                       │
              Object Created Event

                       ▼

                  Eventarc Trigger

                       ▼

          Cloud Run (Python ETL Service)

 ┌──────────────────────────────────────────────┐
 │                                              │
 │  Secret Manager                              │
 │  Environment Variables                       │
 │  Structured Logging                          │
 │  Audit Logging                               │
 │  File Validation                             │
 │  Dynamic Table Routing                       │
 │                                              │
 └──────────────────────────────────────────────┘

                       │

                       ▼

             BigQuery Bronze Layer

                       │

                       ▼

             BigQuery Silver Layer

                       │

                       ▼

          Dimension & Fact Tables

                       │

                       ▼

             Reporting Views

                       │

                       ▼

      Looker Studio / Power BI Dashboard
```

---

# Architecture Components

| Component | Purpose |
|------------|----------|
| Cloud Storage | Landing zone for incoming marketing files |
| Eventarc | Detects new file uploads |
| Cloud Run | Executes ETL automatically |
| Python | Data ingestion and processing |
| Secret Manager | Secure credential management |
| Environment Variables | Runtime configuration |
| BigQuery | Enterprise Data Warehouse |
| GitHub | Source Control |
| GitHub Actions | CI/CD Pipeline |
| Docker | Application Containerization |
| Cloud Logging | Centralized Application Logs |
| Audit Table | ETL Execution History |
| Looker Studio | Business Intelligence Dashboard |

---

# Technology Stack

## Cloud

- Google Cloud Platform
- Cloud Storage
- Cloud Run
- BigQuery
- Eventarc
- Secret Manager
- Cloud Logging
- IAM

## Programming

- Python 3.12
- Flask
- Pandas
- Google Cloud SDK

## DevOps

- Docker
- Git
- GitHub
- GitHub Actions

## Reporting

- Looker Studio

---

# Sample Dataset

| Dataset | Records |
|----------|---------|
| Google Ads | 5,000 |
| Meta Ads | 5,000 |
| CRM Leads | 2,000 |

---

# Project Structure

```
marketing-attribution-platform/

│
├── Cloudrun/
│   │
│   ├── app.py
│   ├── loader.py
│   ├── logger.py
│   ├── settings.py
│   ├── utils.py
│   ├── Dockerfile
│   ├── requirements.txt
│   │
│   ├── audit/
│   │     audit_logger.py
│   │
│   ├── config/
│   │     __init__.py
│   │     secret_manager.py
│   │
│   ├── credentials/
│   ├── sample_data/
│   ├── sql/
│   └── docs/
│
├── .github/
│    └── workflows/
│          deployment.yaml
│
├── architecture_diagram.png
│
└── README.md
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

Standardized and cleansed data.

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

# Current Event Flow

```
Marketing CSV Upload

        │

        ▼

Google Cloud Storage

        │

        ▼

Eventarc Trigger

        │

        ▼

Cloud Run

        │

        ▼

Python ETL

        │

        ▼

BigQuery

        │

        ▼

Audit Logging

        │

        ▼

Reporting Views

        │

        ▼

Looker Studio
```

---

# Features

## Data Engineering

- Event-driven architecture
- Serverless ETL
- Automatic BigQuery loading
- Dynamic table routing
- Modular ETL design

---

## Security

- Google Secret Manager
- Environment Variables
- IAM Service Accounts
- No credentials stored in source code

---

## Logging & Monitoring

- Structured Logging
- Cloud Logging
- Audit Logging
- Processing Statistics
- Error Handling

---

## DevOps

- Dockerized Application
- GitHub Repository
- GitHub Actions
- Automatic Cloud Run Deployment
- Version-controlled Infrastructure

---

# Key Business Metrics

The platform calculates:

- Total Spend
- Total Clicks
- Total Impressions
- Total Conversions
- Click Through Rate (CTR)
- Average CPC
- Cost Per Lead (CPL)
- Cost Per Acquisition (CPA)
- Return On Ad Spend (ROAS)
- Revenue by Campaign
- Revenue by Marketing Channel

---

# Data Validation

Validation SQL scripts verify:

- Row Counts
- Duplicate Records
- NULL Checks
- Fact Table Integrity
- Dimension Integrity
- Data Quality
- Summary Statistics

---

# CI/CD Pipeline

Every commit pushed to the **main** branch automatically triggers GitHub Actions.

Deployment Pipeline

1. Checkout Source Code
2. Build Docker Image
3. Push Image to Artifact Registry
4. Deploy Cloud Run
5. Create New Revision
6. Route 100% Traffic to Latest Revision

No manual deployment is required.

---

# Production Features Implemented

## Sprint 1–11

- Cloud Storage
- BigQuery
- Cloud Run
- Eventarc
- Modular ETL
- Audit Logging
- Google Ads Integration (Foundation)

---

## Sprint 12

- Docker
- GitHub Repository
- GitHub Actions
- Automated CI/CD

---

## Sprint 13

- Secret Manager
- Environment Variables
- Structured Logging
- Production Configuration
- Secure Credential Management

---

# Deployment Steps

1. Create GCP Project
2. Enable Required APIs
3. Create IAM Service Accounts
4. Configure Secret Manager
5. Create Cloud Storage Bucket
6. Create BigQuery Dataset
7. Deploy Cloud Run
8. Configure Eventarc Trigger
9. Configure GitHub Actions
10. Upload Marketing Files
11. Monitor Cloud Logging
12. Build Reporting Views
13. Connect Looker Studio

---

# Future Enhancements

- Google Ads API Integration
- Meta Marketing API Integration
- Incremental Loading
- Slowly Changing Dimensions (SCD Type 2)
- Data Quality Framework
- Monitoring Dashboard
- Email Alerts
- Retry Framework
- Cloud Scheduler
- dbt / Dataform
- Terraform Infrastructure as Code
- Unit Testing
- Integration Testing
- Cost Monitoring

---

# Sample Dashboard

Dashboard pages will include:

- Executive Summary
- Campaign Performance
- Channel Performance
- Daily Trends
- Spend vs Revenue
- Top Campaigns
- Marketing Funnel
- ROAS Analysis

---

# Author

**Ramkumar Pitchaimani**

Google Cloud Platform | Data Engineering | BigQuery | Cloud Run | Eventarc | Python | GitHub Actions


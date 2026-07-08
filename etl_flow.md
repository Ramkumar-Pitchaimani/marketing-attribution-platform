                                MARKETING ATTRIBUTION PLATFORM
                                       ETL FLOW DIAGRAM

┌──────────────────────────────────────────────────────────────────────────────┐
│                            SOURCE SYSTEMS                                    │
├──────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  Google Ads CSV      Meta Ads CSV       CRM Leads CSV                        │
│                                                                              │
└───────────────────────────────┬──────────────────────────────────────────────┘
                                │
                                ▼
┌──────────────────────────────────────────────────────────────────────────────┐
│                         GOOGLE CLOUD STORAGE                                 │
│                                                                              │
│                  Landing Bucket (marketing-files)                            │
└───────────────────────────────┬──────────────────────────────────────────────┘
                                │
                     File Uploaded Event
                                │
                                ▼
┌──────────────────────────────────────────────────────────────────────────────┐
│                               EVENTARC                                       │
│                                                                              │
│        Detects Cloud Storage Object Finalize Event                           │
└───────────────────────────────┬──────────────────────────────────────────────┘
                                │
                                ▼
┌──────────────────────────────────────────────────────────────────────────────┐
│                            CLOUD RUN ETL                                     │
├──────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  ✓ Detect uploaded file                                                      │
│  ✓ Identify dataset (Google / Meta / CRM)                                    │
│  ✓ Validate filename                                                         │
│  ✓ Load CSV to BigQuery                                                      │
│  ✓ Write application logs                                                    │
│  ✓ Write audit logs                                                          │
│                                                                              │
└───────────────────────────────┬──────────────────────────────────────────────┘
                                │
                                ▼
┌──────────────────────────────────────────────────────────────────────────────┐
│                          BRONZE LAYER                                        │
├──────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│ google_ads_raw                                                               │
│ meta_ads_raw                                                                 │
│ crm_leads_raw                                                                │
│                                                                              │
└───────────────────────────────┬──────────────────────────────────────────────┘
                                │
                                ▼
                    SQL Transformation Layer
                                │
                                ▼
┌──────────────────────────────────────────────────────────────────────────────┐
│                          SILVER LAYER                                        │
├──────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│ ✓ Standardize column names                                                   │
│ ✓ Remove bad records                                                         │
│ ✓ Convert data types                                                         │
│ ✓ Clean NULL values                                                          │
│ ✓ Apply business rules                                                       │
│                                                                              │
│ google_ads_clean                                                             │
│ meta_ads_clean                                                               │
│ crm_leads_clean                                                              │
│                                                                              │
└───────────────────────────────┬──────────────────────────────────────────────┘
                                │
                Build Star Schema Warehouse
                                │
               ┌────────────────┴────────────────┐
               ▼                                 ▼
┌───────────────────────────┐        ┌───────────────────────────┐
│ Dimension Tables          │        │ Fact Tables               │
├───────────────────────────┤        ├───────────────────────────┤
│ dim_date                  │        │ fact_marketing            │
│ dim_campaign              │        │ fact_leads                │
│ dim_channel               │        └───────────────────────────┘
│ dim_device                │
└──────────────┬────────────┘
               │
               ▼
┌──────────────────────────────────────────────────────────────────────────────┐
│                         REPORTING VIEWS                                      │
├──────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│ vw_dashboard_metrics                                                         │
│ vw_campaign_performance                                                      │
│ vw_channel_performance                                                       │
│ vw_daily_summary                                                             │
│ vw_lead_attribution                                                          │
│                                                                              │
└───────────────────────────────┬──────────────────────────────────────────────┘
                                │
                                ▼
┌──────────────────────────────────────────────────────────────────────────────┐
│                        LOOKER STUDIO                                         │
├──────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│ Executive Dashboard                                                          │
│ Campaign Performance Dashboard                                               │
│ Channel Analysis Dashboard                                                   │
│ Lead Attribution Dashboard                                                   │
│                                                                              │
└──────────────────────────────────────────────────────────────────────────────┘


───────────────────────────────────────────────────────────────────────────────

VALIDATION FRAMEWORK

Raw → Silver Validation

Silver → Fact Validation

Dimension Validation

NULL Checks

Duplicate Checks

Referential Integrity

Business Rule Validation

Dashboard Validation

───────────────────────────────────────────────────────────────────────────────

MONITORING

Cloud Logging

Audit Logs

BigQuery Job History

Cloud Run Logs
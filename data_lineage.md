                                     MARKETING ATTRIBUTION PLATFORM
                                         DATA LINEAGE DIAGRAM

┌────────────────────┐     ┌────────────────────┐     ┌────────────────────┐
│ Google Ads CSV     │     │ Meta Ads CSV       │     │ CRM Leads CSV      │
│ (5000 Records)     │     │ (5000 Records)     │     │ (2000 Records)     │
└─────────┬──────────┘     └─────────┬──────────┘     └─────────┬──────────┘
          │                          │                          │
          └──────────────┬───────────┴──────────────┬───────────┘
                         │
                         ▼
              ┌────────────────────────────┐
              │ Google Cloud Storage (GCS) │
              │ Landing Zone               │
              └─────────────┬──────────────┘
                            │
                            ▼
                  ┌───────────────────┐
                  │ Eventarc Trigger  │
                  └─────────┬─────────┘
                            │
                            ▼
                  ┌───────────────────┐
                  │ Cloud Run (Python)│
                  │ ETL Loader        │
                  └─────────┬─────────┘
                            │
                            ▼
         ┌──────────────────────────────────────────────┐
         │              BigQuery Bronze                 │
         │----------------------------------------------│
         │ google_ads_raw                               │
         │ meta_ads_raw                                 │
         │ crm_leads_raw                                │
         └───────────────────┬──────────────────────────┘
                             │
                             ▼
         ┌──────────────────────────────────────────────┐
         │              BigQuery Silver                 │
         │----------------------------------------------│
         │ google_ads_clean                             │
         │ meta_ads_clean                               │
         │ crm_leads_clean                              │
         └───────────────────┬──────────────────────────┘
                             │
          ┌──────────────────┴──────────────────┐
          │                                     │
          ▼                                     ▼
┌────────────────────────┐           ┌────────────────────────┐
│ Dimension Tables       │           │ Fact Tables            │
│------------------------│           │------------------------│
│ dim_date               │           │ fact_marketing         │
│ dim_campaign           │           │ fact_leads             │
│ dim_channel            │           └──────────┬─────────────┘
│ dim_device             │                      │
└───────────┬────────────┘                      │
            └──────────────────────┬───────────┘
                                   ▼
             ┌──────────────────────────────────────────┐
             │          Reporting Views                 │
             │------------------------------------------│
             │ vw_dashboard_metrics                     │
             │ vw_campaign_performance                  │
             │ vw_channel_performance                   │
             │ vw_daily_summary                         │
             │ vw_lead_attribution                      │
             └──────────────────┬───────────────────────┘
                                │
                                ▼
                 ┌────────────────────────────────┐
                 │        Looker Studio           │
                 │--------------------------------│
                 │ Executive Dashboard            │
                 │ Campaign Performance           │
                 │ Channel Performance            │
                 │ Lead Attribution               │
                 └────────────────────────────────┘



| Layer             | Purpose                      |
| ----------------- | ---------------------------- |
| **Source**        | Marketing CSV files          |
| **Landing**       | Cloud Storage                |
| **Ingestion**     | Eventarc + Cloud Run         |
| **Bronze**        | Raw data                     |
| **Silver**        | Cleansed & standardized data |
| **Dimensions**    | Business master data         |
| **Facts**         | Business metrics             |
| **Views**         | Reporting layer              |
| **Visualization** | Looker Studio                |

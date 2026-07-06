# Google Ads API Integration

## Objective

Replace mock CSV-based Google Ads data ingestion with live data fetched directly from the Google Ads API while keeping the existing BigQuery data warehouse, transformations and dashboard unchanged.

---

# Existing Architecture

```
Mock CSV
    │
    ▼
Google Cloud Storage
    │
    ▼
Cloud Run ETL
    │
    ▼
google_ads_raw
    │
    ▼
Cleaning SQL
    │
    ▼
Star Schema
    │
    ▼
Looker Studio
```

---

# Target Architecture

```
Google Ads API
      │
      ▼
google_ads_api.py
      │
      ▼
Pandas DataFrame
      │
      ▼
Cloud Run Loader
      │
      ▼
google_ads_raw
      │
      ▼
Cleaning SQL
      │
      ▼
Star Schema
      │
      ▼
Looker Studio
```

Only the data source changes.

Everything after **google_ads_raw** remains exactly the same.

---

# Phase 1 - Authentication 

Authentication was required before Google Ads data could be accessed.

The following components were configured.

## 1. Google Ads Manager Account (MCC)

Created a Google Ads Manager Account.

Purpose

- Manage Google Ads API access
- Request Developer Token
- Manage Google Ads customers

Status

```
Completed
```

---

## 2. Developer Token

Requested Developer Token from API Center.

Purpose

Allows the application to access the Google Ads API.

Status

```
Completed
```

---

## 3. Google Cloud OAuth Configuration

Configured OAuth authentication.

Completed

- Enabled Google Ads API
- Configured OAuth Consent Screen
- Added Test User
- Created OAuth Desktop Client

Status

```
Completed
```

---

## 4. OAuth Client Credentials

Downloaded

```
client_secret.json
```

Contains

- Client ID
- Client Secret

Purpose

Identifies our application to Google.

Status

```
Completed
```

---

## 5. Refresh Token

Generated Refresh Token using

```
generate_refresh_token.py
```

Purpose

Allows Cloud Run to authenticate automatically without user interaction.

Status

```
Completed
```

---

## 6. Google Ads Configuration File

Created

```
google-ads.yaml
```

Contains

- Developer Token
- Client ID
- Client Secret
- Refresh Token

Purpose

Central configuration for Google Ads SDK.

Status

```
Completed
```

---

## 7. Authentication Test

Created

```
test_google_ads.py
```

Verified

```
Google Ads API authentication successful!
```

Status

```
Completed
```

---

# Authentication Summary

Google validates four items before allowing API access.

```
Client ID
      │
      ▼
Client Secret
      │
      ▼
Refresh Token
      │
      ▼
Developer Token
      │
      ▼
Google Ads API
```

All four authentication steps are complete.

---

# Files Created

```
Cloudrun/

client_secret.json
google-ads.yaml
generate_refresh_token.py
test_google_ads.py
```

---

# Existing ETL

```
CSV
 │
 ▼
loader.py
 │
 ▼
BigQuery
```

---

# Future ETL

```
Google Ads API
       │
       ▼
google_ads_api.py
       │
       ▼
Pandas DataFrame
       │
       ▼
loader.py
       │
       ▼
BigQuery
```

---

# Code Impact

Only one new module will be added.

```
google_ads_api.py
```

The remainder of the project remains unchanged.

No changes required for

- BigQuery tables
- Cleaning SQL
- Star Schema
- Looker Studio Dashboard
- Audit Logging
- Monitoring
- Cloud Scheduler

---

# Phase 2 - Implementation 

## Step 1

Create

```
google_ads_api.py
```

Responsibilities

- Connect to Google Ads API
- Execute GAQL query
- Retrieve campaign metrics
- Convert response into Pandas DataFrame

---

## Step 2

Update

```
loader.py
```

Replace

```
Load CSV
```

with

```
Fetch Google Ads DataFrame
```

and load it into

```
google_ads_raw
```

---

## Step 3

Validate

Verify

- Row counts
- Campaign names
- Spend
- Clicks
- Impressions
- Conversions

---

## Step 4

Deploy Cloud Run

Deploy updated Cloud Run service containing

```
google_ads_api.py
```

---

## Step 5

Automation

Configure Cloud Scheduler to execute Cloud Run daily.

```
09:00 AM
      │
      ▼
Cloud Scheduler
      │
      ▼
Cloud Run
      │
      ▼
Google Ads API
      │
      ▼
BigQuery
```

---

# End Goal

Replace mock CSV ingestion with a production-style Google Ads API integration while preserving the existing analytics platform.

```
Google Ads API
      │
      ▼
Cloud Run
      │
      ▼
BigQuery
      │
      ▼
Data Warehouse
      │
      ▼
Looker Studio
```

---


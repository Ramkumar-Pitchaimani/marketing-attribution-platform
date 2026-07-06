# Sprint 4 - Event Driven Data Ingestion (Cloud Storage → Eventarc → Cloud Run → BigQuery)

## Objective

Implement a fully automated event-driven ingestion pipeline where uploading a CSV file to Cloud Storage automatically triggers Cloud Run, which loads the file into BigQuery.

---

# Final Architecture

```
                Upload CSV
                     │
                     ▼
          Cloud Storage Bucket
                     │
         Object Finalized Event
                     │
                     ▼
                Eventarc Trigger
                     │
                     ▼
              Cloud Run Service
                     │
              Python ETL Loader
                     │
                     ▼
             BigQuery Raw Tables
```

---

# Prerequisites

Completed Sprint 3.

The following resources should already exist:

- GCP Project
- Cloud Storage Bucket
- BigQuery Dataset
- BigQuery Raw Tables
- Artifact Registry Repository
- Cloud Run Source Code

Project ID

```
pro1-501113
```

Bucket

```
pro1-marketing-data
```

Dataset

```
marketing_dw
```

---

# Step 1 - Update Flask Application

Modify `app.py` to support:

- GET /
- POST /
- POST /load

GET

Used for Health Check.

POST /

Used by Eventarc.

POST /load

Used for manual testing.

---

# Step 2 - Update Loader

Modify `loader.py`

Replace

```python
logger.info("Destination :", table_id)
```

with

```python
logger.info(f"Destination : {table_id}")
```

---

# Step 3 - Local Testing

Run locally.

```
python3 app.py
```

Health Check

```
http://localhost:8080
```

Manual Load

```
curl -X POST http://localhost:8080/load \
-H "Content-Type: application/json" \
-d '{
"bucket":"pro1-marketing-data",
"file_name":"raw/google_ads/google_ads_mock_5000.csv"
}'
```

Expected

```
{
"status":"SUCCESS"
}
```

---

# Step 4 - Build Docker Image

Navigate to project directory.

```
cd Cloudrun
```

Verify Dockerfile exists.

```
ls
```

Build Image

```
gcloud builds submit \
--tag us-central1-docker.pkg.dev/pro1-501113/marketing-repo/marketing-etl:v4
```

Expected

```
STATUS: SUCCESS
```

---

# Step 5 - Deploy Cloud Run

```
gcloud run deploy marketing-etl \
--image us-central1-docker.pkg.dev/pro1-501113/marketing-repo/marketing-etl:v4 \
--region us-central1 \
--platform managed \
--allow-unauthenticated
```

Verify deployment.

```
gcloud run services describe marketing-etl \
--region us-central1 \
--format="value(spec.template.spec.containers[0].image)"
```

Expected

```
marketing-etl:v4
```

---

# Step 6 - Manual API Testing

```
curl -X POST \
https://marketing-etl-131913758459.us-central1.run.app/load \
-H "Content-Type: application/json" \
-d '{
"bucket":"pro1-marketing-data",
"file_name":"raw/google_ads/google_ads_mock_5000.csv"
}'
```

Expected

```
Rows Loaded : 5000
```

---

# Step 7 - Enable Required APIs

```
gcloud services enable \
eventarc.googleapis.com \
eventarcpublishing.googleapis.com \
storage.googleapis.com \
pubsub.googleapis.com
```

---

# Step 8 - Create Service Accounts

Eventarc Service Account

```
gcloud iam service-accounts create eventarc-sa \
--display-name="Eventarc Service Account"
```

Grant Event Receiver Role

```
gcloud projects add-iam-policy-binding pro1-501113 \
--member="serviceAccount:eventarc-sa@pro1-501113.iam.gserviceaccount.com" \
--role="roles/eventarc.eventReceiver"
```

Grant Cloud Run Invoker

```
gcloud run services add-iam-policy-binding marketing-etl \
--region=us-central1 \
--member="serviceAccount:eventarc-sa@pro1-501113.iam.gserviceaccount.com" \
--role="roles/run.invoker"
```

---

# Step 9 - Configure Cloud Storage Service Agent

Grant Pub/Sub Publisher

```
gcloud projects add-iam-policy-binding pro1-501113 \
--member="serviceAccount:service-131913758459@gs-project-accounts.iam.gserviceaccount.com" \
--role="roles/pubsub.publisher"
```

---

# Step 10 - Create Eventarc Trigger

```
gcloud eventarc triggers create marketing-upload-trigger \
--location=us-central1 \
--destination-run-service=marketing-etl \
--destination-run-region=us-central1 \
--event-filters="type=google.cloud.storage.object.v1.finalized" \
--event-filters="bucket=pro1-marketing-data" \
--service-account=eventarc-sa@pro1-501113.iam.gserviceaccount.com
```

Expected

```
Creating trigger...
Done.
```

---

# Step 11 - Verify Trigger

```
gcloud eventarc triggers list \
--location=us-central1
```

Expected

```
marketing-upload-trigger
```

---

# Step 12 - Upload File

```
gcloud storage cp \
google_ads_mock_5000.csv \
gs://pro1-marketing-data/raw/google_ads/
```

No API call required.

---

# Step 13 - Verify Cloud Run Logs

```
gcloud run services logs read marketing-etl \
--region us-central1 \
--limit=30
```

Expected

```
Starting BigQuery Load

Destination :
pro1-501113.marketing_dw.google_ads_raw

Rows Loaded : 5000
```

---

# Step 14 - Verify BigQuery

Run

```sql
SELECT COUNT(*)
FROM `pro1-501113.marketing_dw.google_ads_raw`;
```

Expected

```
5000
```

---

# Sprint 4 Deliverables

✅ Cloud Storage Bucket

✅ Cloud Run Service

✅ Dockerized Flask Application

✅ Artifact Registry

✅ Eventarc Trigger

✅ Event Driven Processing

✅ Automatic BigQuery Load

✅ Centralized Logging

---

# Final Architecture

```
Google Ads CSV
Meta Ads CSV
CRM CSV
        │
        ▼
Cloud Storage Bucket
        │
Object Finalized
        │
        ▼
Eventarc
        │
        ▼
Cloud Run
(Python ETL)
        │
        ▼
BigQuery Raw Tables
```

Sprint 4 Status

**COMPLETED**
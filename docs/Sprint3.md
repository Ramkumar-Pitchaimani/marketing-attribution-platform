# Sprint 3 - Containerization & Cloud Run Deployment

## Objective

Containerize the ETL application and deploy it as a Cloud Run service.

---

# Architecture

```
Python ETL

      │

Docker Image

      │

Artifact Registry

      │

Cloud Run
```

---

# Step 1 - Create Flask API

Endpoints

```
GET /

POST /load
```

Health Check

```
Running
```

---

# Step 2 - Create Dockerfile

Containerize

- Flask
- Loader
- Logger
- Config

---

# Step 3 - Create Artifact Registry

Repository

```
marketing-repo
```

Region

```
us-central1
```

---

# Step 4 - Build Image

```bash
gcloud builds submit \
--tag us-central1-docker.pkg.dev/pro1-501113/marketing-repo/marketing-etl:v1
```

---

# Step 5 - Deploy Cloud Run

```bash
gcloud run deploy marketing-etl \
--image us-central1-docker.pkg.dev/pro1-501113/marketing-repo/marketing-etl:v1 \
--region us-central1 \
--platform managed \
--allow-unauthenticated
```

---

# Step 6 - Verify Deployment

Browser

```
https://<cloud-run-url>
```

Expected

```json
{
"status":"Running"
}
```

---

# Step 7 - Test Loader

```bash
curl -X POST \
https://<cloud-run-url>/load \
-H "Content-Type: application/json" \
-d '{
"bucket":"pro1-marketing-data",
"file_name":"raw/google_ads/google_ads_mock_5000.csv"
}'
```

Expected

```json
{
"status":"SUCCESS"
}
```

---

# Step 8 - Logging

Verify

```
Rows Loaded : 5000
```

Cloud Run Logs

```
Starting BigQuery Load

Destination

Rows Loaded
```

---

# Sprint 3 Deliverables

- Docker Image
- Artifact Registry
- Cloud Run Service
- Public REST API
- Successful BigQuery Load
- Centralized Logging

Sprint Status

**COMPLETED**
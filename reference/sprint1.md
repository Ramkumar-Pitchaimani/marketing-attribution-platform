# Sprint 1 - Project Setup & Environment Configuration

## Objective

Set up the GCP environment, project structure, Cloud Storage, BigQuery, and local development environment.

---

# Architecture

```
Local Machine
      │
      ▼
Python Development
      │
      ▼
Google Cloud Platform
```

---

# Step 1 - Create GCP Project

Project Name

```
Pro1
```

Project ID

```
pro1-501113
```

---

# Step 2 - Enable Required APIs

Enable:

- BigQuery API
- Cloud Storage API
- Cloud Run API
- Artifact Registry API
- Cloud Build API
- IAM API

CLI

```bash
gcloud services enable \
bigquery.googleapis.com \
storage.googleapis.com \
run.googleapis.com \
artifactregistry.googleapis.com \
cloudbuild.googleapis.com \
iam.googleapis.com
```

---

# Step 3 - Install Local Tools

Install

- Python 3.12+
- Google Cloud SDK
- Git
- VS Code
- Docker Desktop (later used for deployment)

Verify

```bash
python3 --version

gcloud version

git --version
```

---

# Step 4 - Authenticate

```bash
gcloud auth login
```

Set project

```bash
gcloud config set project pro1-501113
```

---

# Step 5 - Create Bucket

```
pro1-marketing-data
```

Region

```
us-central1
```

Folder Structure

```
raw/

raw/google_ads/

raw/meta_ads/

raw/crm/
```

---

# Step 6 - Create BigQuery Dataset

Dataset

```
marketing_dw
```

Region

```
US
```

---

# Step 7 - Create Raw Tables

Create

```
google_ads_raw

meta_ads_raw

crm_leads_raw
```

---

# Step 8 - Local Repository

```
marketing-attribution-platform/
```

Create folders

```
cloudrun/

sample_data/

sql/

docs/

screenshots/

dashboards/
```

---

# Step 9 - Python Virtual Environment

```bash
python3 -m venv venv

source venv/bin/activate
```

---

# Step 10 - Install Packages

```bash
pip install

flask

google-cloud-storage

google-cloud-bigquery

gunicorn

pandas
```

Freeze

```bash
pip freeze > requirements.txt
```

---

# Sprint 1 Deliverables

- GCP Project
- Bucket
- BigQuery Dataset
- Local Repository
- Python Environment
- Required APIs Enabled

Sprint Status

**COMPLETED**
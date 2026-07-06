# Python
python3 --version
which python3

# how to install libraries in local
1.create requirements.txt 
2.include required libs:
    google-cloud-storage
    google-cloud-bigquery
    google-cloud-logging
    pandas
    pyarrow
    flask
    gunicorn
3.pip install -r requirements.txt


# goto this folder
marketing-attribution-platform/credentials/marketing-etl-sa.json
# run this
export GOOGLE_APPLICATION_CREDENTIALS="credentials/marketing-etl-sa.json"



# docker setup
gcloud artifacts repositories create marketing-repo \
    --repository-format=docker \
    --location=us-central1 \
    --description="Marketing Attribution Docker Repository"

run the build:
gcloud artifacts repositories create marketing-repo \
    --repository-format=docker \
    --location=us-central1 \
    --description="Marketing Attribution Docker Repository"

gs://pro1-501113_cloudbuild/source/1782975284.860336-6962de7aa6ff4f07b8f4618e647899dd.tgz

Cloud Build is working
Docker image was created
Docker image was pushed to Artifact Registry
Your project is correctly configured

gcloud services enable run.googleapis.com
gcloud services enable eventarc.googleapis.com
gcloud services enable cloudbuild.googleapis.com

# Deploy the Service
gcloud run deploy marketing-etl \
  --image us-central1-docker.pkg.dev/pro1-501113/marketing-repo/marketing-etl:v1 \
  --platform managed \
  --region us-central1 \
  --allow-unauthenticated

https://marketing-etl-131913758459.us-central1.run.app

Test it in browser
# Test in in terminal:
curl -X POST \
https://marketing-etl-131913758459.us-central1.run.app/load \
-H "Content-Type: application/json" \
-d '{
  "bucket":"pro1-marketing-data",
  "file_name":"raw/google_ads/google_ads_mock_5000.csv"
}'

# milestone
VS Code
    │
    ▼
Cloud Build
    │
    ▼
Artifact Registry
    │
    ▼
Cloud Run REST API
    │
    ▼
Google Cloud Storage
    │
    ▼
BigQuery


curl -X POST \
https://marketing-etl-131913758459.us-central1.run.app/load \
-H "Content-Type: application/json" \
-d '{
  "bucket":"pro1-marketing-data",
  "file_name":"raw/google_ads/google_ads_mock_5000.csv"
}'

curl -X POST \
https://marketing-etl-131913758459.us-central1.run.app/load \
-H "Content-Type: application/json" \
-d '{
  "bucket":"pro1-marketing-data",
  "name":"raw/google_ads/google_ads_mock_5000.csv"
}'
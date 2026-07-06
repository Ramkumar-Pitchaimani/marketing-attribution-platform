import os

# Read from Cloud Run Environment Variables
# If not available, use defaults (for local development)

PROJECT_ID = os.getenv(
    "PROJECT_ID",
    "pro1-501113"
)

DATASET = os.getenv(
    "DATASET",
    "marketing_dw"
)

TABLES = {
    "google_ads": "google_ads_raw",
    "meta_ads": "meta_ads_raw",
    "crm": "crm_leads_raw"
}
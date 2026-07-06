# Marketing Analytics attribution platform

Project ID  - pro1-501113
Bucket name - pro1-marketing-data
Dataset name    - marketing_dw
Region      - us-central1
Service account name    - marketing-etl-sa    --marketing-etl-sa@pro1-501113.iam.gserviceaccount.com

# Enabled APIs
 API                  
 --------------------- 
 BigQuery API          
 Cloud Storage API     
 Cloud Run Admin API   
 Eventarc API          
 Cloud Build API       
 Artifact Registry API 
 IAM API               
 Cloud Logging API     



# Cloud run setup
app.py      - Receives the Eventarc request.
loader.py   - Contains all BigQuery loading logic.
config.py   - Everything configurable stays here.
DockerFile  - dockerfile


from datetime import datetime

from google.cloud import bigquery

from config import PROJECT_ID, DATASET, TABLES
from logger import logger
from utils import file_exists
from audit.audit_logger import write_audit_log

client = bigquery.Client(project=PROJECT_ID)


def get_table_name(file_name: str) -> str:
    """
    Determine destination table based on uploaded file path.
    """

    file_name = file_name.lower()

    if "google_ads" in file_name:
        return TABLES["google_ads"]

    elif "meta_ads" in file_name:
        return TABLES["meta_ads"]

    elif "crm" in file_name:
        return TABLES["crm"]

    else:
        raise Exception(f"Unknown file type : {file_name}")


def load_file(bucket_name: str, file_name: str):

    start_time = datetime.utcnow()

    if not file_exists(bucket_name, file_name):
        raise Exception(
            f"{file_name} not found in {bucket_name}"
        )

    """
    Load CSV from GCS into BigQuery
    """

    table_name = get_table_name(file_name)

    table_id = f"{PROJECT_ID}.{DATASET}.{table_name}"

    gcs_uri = f"gs://{bucket_name}/{file_name}"

    logger.info("=" * 60)
    logger.info("Starting BigQuery Load")
    logger.info(f"GCS URI : {gcs_uri}")
    logger.info(f"Destination : {table_id}")
    logger.info("=" * 60)

    try:

        job_config = bigquery.LoadJobConfig(
            source_format=bigquery.SourceFormat.CSV,
            skip_leading_rows=1,
            write_disposition="WRITE_TRUNCATE",
        )

        load_job = client.load_table_from_uri(
            gcs_uri,
            table_id,
            job_config=job_config,
        )

        load_job.result()

        table = client.get_table(table_id)

        logger.info(f"Rows Loaded : {table.num_rows}")

        end_time = datetime.utcnow()

        write_audit_log(
            job_name="Marketing ETL",
            bucket=bucket_name,
            file_name=file_name,
            destination_table=table_name,
            rows_loaded=table.num_rows,
            status="SUCCESS",
            error_message="",
            start_time=start_time,
            end_time=end_time,
        )

        return {
            "table": table_name,
            "rows_loaded": table.num_rows,
        }

    except Exception as e:

        end_time = datetime.utcnow()

        write_audit_log(
            job_name="Marketing ETL",
            bucket=bucket_name,
            file_name=file_name,
            destination_table=table_name,
            rows_loaded=0,
            status="FAILED",
            error_message=str(e),
            start_time=start_time,
            end_time=end_time,
        )

        raise
from google.cloud import bigquery
from datetime import datetime
import uuid

from config import PROJECT_ID, DATASET

client = bigquery.Client(project=PROJECT_ID)


def write_audit_log(
    job_name,
    bucket,
    file_name,
    destination_table,
    rows_loaded,
    status,
    error_message,
    start_time,
    end_time,
):

    execution_time = (
        end_time - start_time
    ).total_seconds()

    table_id = f"{PROJECT_ID}.{DATASET}.etl_audit_log"

    rows = [

        {
            "audit_id": str(uuid.uuid4()),

            "job_name": job_name,

            "source_bucket": bucket,

            "source_file": file_name,

            "destination_table": destination_table,

            "rows_loaded": rows_loaded,

            "status": status,

            "error_message": error_message,

            "start_time": start_time.isoformat(),

            "end_time": end_time.isoformat(),

            "execution_time_seconds": execution_time,

        }

    ]

    errors = client.insert_rows_json(
        table_id,
        rows
    )

    return errors
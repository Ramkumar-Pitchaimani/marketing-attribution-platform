/******************************************************************************
Create Audit Table
******************************************************************************/

CREATE TABLE IF NOT EXISTS marketing_dw.etl_audit_log (

audit_id STRING,

job_name STRING,

source_bucket STRING,

source_file STRING,

destination_table STRING,

rows_loaded INT64,

status STRING,

error_message STRING,

start_time TIMESTAMP,

end_time TIMESTAMP,

execution_time_seconds FLOAT64,

load_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP()

);
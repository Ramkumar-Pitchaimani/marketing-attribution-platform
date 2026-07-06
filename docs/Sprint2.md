# Sprint 2 - Data Preparation & BigQuery Loading

## Objective

Prepare realistic marketing datasets and build a reusable Python loader to load CSV files into BigQuery.

---

# Architecture

```
CSV Files
      │
      ▼
Cloud Storage
      │
      ▼
Python Loader
      │
      ▼
BigQuery
```

---

# Step 1 - Create Mock Datasets

Files

```
google_ads_mock_5000.csv

meta_ads_mock_5000.csv

crm_leads_mock_2000.csv
```

---

# Step 2 - Upload Files

Upload to

```
raw/google_ads/

raw/meta_ads/

raw/crm/
```

---

# Step 3 - Create Config File

Store

- Project ID
- Dataset
- Table Names

---

# Step 4 - Create Logger

Configure Python logging

Output

```
INFO

ERROR

WARNING
```

---

# Step 5 - Utility Functions

Create reusable helpers

```
file_exists()

validate_bucket()

validate_file()
```

---

# Step 6 - Build Loader

Functions

```
get_table_name()

load_file()
```

Responsibilities

- Validate file
- Detect destination table
- Load CSV into BigQuery
- Log status
- Return row count

---

# Step 7 - Local Testing

Create

```
test_loader.py
```

Execute

```bash
python3 test_loader.py
```

Expected

```
Rows Loaded : 5000
```

---

# Step 8 - Verify BigQuery

Run SQL

```sql
SELECT COUNT(*)

FROM marketing_dw.google_ads_raw;
```

---

# Sprint 2 Deliverables

- Mock CSV Files
- Python Loader
- Logger
- Config Module
- Utility Module
- Successful BigQuery Loads

Sprint Status

**COMPLETED**
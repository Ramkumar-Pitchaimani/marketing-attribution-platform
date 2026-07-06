from loader import load_file

bucket = "pro1-marketing-data"

file_name = "raw/crm/crm_leads_mock_2000.csv"

result = load_file(bucket, file_name)

print(result)
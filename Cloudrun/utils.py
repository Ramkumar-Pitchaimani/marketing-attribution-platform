from google.cloud import storage

client = storage.Client()

def file_exists(bucket_name, file_name):

    bucket = client.bucket(bucket_name)

    blob = bucket.blob(file_name)

    return blob.exists()
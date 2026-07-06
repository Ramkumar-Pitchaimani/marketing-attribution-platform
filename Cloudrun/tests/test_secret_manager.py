from config.secret_manager import get_secret

PROJECT_ID = "pro1-501113"

secret = get_secret(
    "google-ads-developer-token",
    PROJECT_ID
)

print(secret)
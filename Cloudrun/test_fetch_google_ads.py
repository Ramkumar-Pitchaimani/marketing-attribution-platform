from google_ads_api import fetch_google_ads_data

# Replace with your Google Ads Customer ID
CUSTOMER_ID = "3526235821"

df = fetch_google_ads_data(CUSTOMER_ID)

print("=" * 60)
print(df.head())
print("=" * 60)

print(df.info())

print("=" * 60)
print(df.describe(include="all"))
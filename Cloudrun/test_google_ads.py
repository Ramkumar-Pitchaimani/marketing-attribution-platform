from google.ads.googleads.client import GoogleAdsClient

# Load credentials from google-ads.yaml
client = GoogleAdsClient.load_from_storage("google-ads.yaml")

print("=" * 60)
print("Google Ads API authentication successful!")
print("=" * 60)
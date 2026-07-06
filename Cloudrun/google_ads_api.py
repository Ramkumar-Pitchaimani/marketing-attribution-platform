from google.ads.googleads.client import GoogleAdsClient
import pandas as pd


def fetch_google_ads_data(customer_id: str) -> pd.DataFrame:
    """
    Fetch campaign performance from Google Ads API
    Returns Pandas DataFrame
    """

    client = GoogleAdsClient.load_from_storage("google-ads.yaml")

    ga_service = client.get_service("GoogleAdsService")

    query = """
        SELECT
            campaign.id,
            campaign.name,
            segments.date,
            metrics.impressions,
            metrics.clicks,
            metrics.cost_micros,
            metrics.conversions
        FROM campaign
        WHERE segments.date DURING LAST_30_DAYS
        ORDER BY segments.date DESC
    """

    response = ga_service.search(
        customer_id=customer_id,
        query=query,
    )

    rows = []

    for row in response:

        rows.append({

            "campaign_date": row.segments.date,

            "campaign_id": row.campaign.id,

            "campaign_name": row.campaign.name,

            "impressions": row.metrics.impressions,

            "clicks": row.metrics.clicks,

            # Google returns cost in micros
            "spend": row.metrics.cost_micros / 1_000_000,

            "conversions": row.metrics.conversions

        })

    df = pd.DataFrame(rows)

    return df
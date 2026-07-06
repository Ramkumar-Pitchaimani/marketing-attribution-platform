from google_auth_oauthlib.flow import InstalledAppFlow

SCOPES = ["https://www.googleapis.com/auth/adwords"]

flow = InstalledAppFlow.from_client_secrets_file(
    "client_secret.json",
    scopes=SCOPES
)

credentials = flow.run_local_server(port=8080)

print("\n" + "=" * 60)
print("REFRESH TOKEN")
print("=" * 60)
print(credentials.refresh_token)
print("=" * 60)
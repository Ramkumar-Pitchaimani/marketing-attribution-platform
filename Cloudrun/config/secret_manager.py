from google.cloud import secretmanager


def get_secret(secret_name, project_id):
    """
    Read a secret value from Google Secret Manager.
    """

    client = secretmanager.SecretManagerServiceClient()

    secret_path = (
        f"projects/{project_id}/secrets/{secret_name}/versions/latest"
    )

    response = client.access_secret_version(
        request={"name": secret_path}
    )

    return response.payload.data.decode("UTF-8")
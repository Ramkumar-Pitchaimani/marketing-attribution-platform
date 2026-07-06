import logging

logger = logging.getLogger("marketing-etl")

logger.setLevel(logging.INFO)

if not logger.handlers:

    console = logging.StreamHandler()

    formatter = logging.Formatter(
        "%(asctime)s | %(levelname)s | %(message)s"
    )

    console.setFormatter(formatter)

    logger.addHandler(console)


def log_event(event, **kwargs):
    """
    Standard logging helper.

    Example:
        log_event(
            "FILE_RECEIVED",
            file_name="google_ads.csv",
            bucket="marketing-data-lake"
        )
    """

    message = f"EVENT={event}"

    for key, value in kwargs.items():
        message += f" | {key}={value}"

    logger.info(message)
from flask import Flask, request, jsonify
from loader import load_file

app = Flask(__name__)


@app.route("/", methods=["GET", "POST"])
def root():
    """
    GET  -> Health Check
    POST -> Eventarc Trigger
    """

    if request.method == "GET":
        return jsonify({
            "status": "Running",
            "service": "Marketing Attribution ETL"
        })

    try:
        body = request.get_json(force=True)

        # Eventarc payload
        bucket = body.get("bucket")
        file_name = body.get("name")

        if not bucket or not file_name:
            return jsonify({
                "status": "FAILED",
                "message": "Invalid Eventarc payload"
            }), 400

        result = load_file(bucket, file_name)

        return jsonify({
            "status": "SUCCESS",
            "details": result
        })

    except Exception as e:
        return jsonify({
            "status": "FAILED",
            "message": str(e)
        }), 500


@app.route("/load", methods=["POST"])
def load():
    """
    Manual API endpoint for testing
    """

    try:
        body = request.get_json(force=True)

        bucket = body.get("bucket")
        file_name = body.get("file_name") or body.get("name")

        if not bucket or not file_name:
            return jsonify({
                "status": "FAILED",
                "message": "bucket and file_name are required"
            }), 400

        result = load_file(bucket, file_name)

        return jsonify({
            "status": "SUCCESS",
            "details": result
        })

    except Exception as e:
        return jsonify({
            "status": "FAILED",
            "message": str(e)
        }), 500


if __name__ == "__main__":
    app.run(
        host="0.0.0.0",
        port=8080,
        debug=True
    )
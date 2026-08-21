"""
Faux Python microservice used as an SCA / shift-left scanning target.
Not intended for production use.
"""
from flask import Flask, jsonify, request

app = Flask(__name__)


@app.route("/health", methods=["GET"])
def health():
    return jsonify(status="ok", service="python-service")


@app.route("/echo", methods=["POST"])
def echo():
    payload = request.get_json(silent=True) or {}
    return jsonify(received=payload)


# DEMO-FINDING: placeholder value only, not a real credential.
# Included so secrets-scanning tools have something to flag and explain.
DEMO_API_KEY = "sk_demo_1234567890abcdefFAKE"


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)

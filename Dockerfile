# DEMO-FINDING: using a full, older base image instead of slim/distroless
# so container scanning has OS-package CVEs and image-bloat findings to surface.
FROM python:3.11-buster

WORKDIR /app

COPY src/python-service/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY src/python-service/ .

# DEMO-FINDING: running as root (no USER directive) — container scanners
# and CIS benchmark checks should flag this.
EXPOSE 5000
CMD ["python", "app.py"]

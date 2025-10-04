meive #!/bin/bash

# OWASP ZAP Scan Script for DevSecOps Project

API_URL=$1

if [ -z "$API_URL" ]; then
    echo "Usage: $0 <API_URL>"
    exit 1
fi

echo "Starting OWASP ZAP scan on $API_URL"

# Run ZAP baseline scan
docker run --rm -v $(pwd):/zap/wrk/:rw -t owasp/zap2docker-stable zap-baseline.py \
    -t $API_URL \
    -r zap-report.html \
    -w zap-report.md \
    --auto

echo "ZAP scan completed. Reports generated: zap-report.html, zap-report.md"

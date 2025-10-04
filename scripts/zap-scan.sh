#!/bin/bash

# Usage: ./zap-scan.sh <API_URL>
# Example: ./zap-scan.sh https://your-api-id.execute-api.us-east-1.amazonaws.com/prod/hello

API_URL=$1

if [ -z "$API_URL" ]; then
  echo "Error: API URL is required as the first argument."
  exit 1
fi

echo "Starting OWASP ZAP scan against $API_URL"

# Run ZAP in daemon mode
docker run -u zap -p 8090:8090 -d owasp/zap2docker-stable zap.sh -daemon -port 8090 -host 0.0.0.0

# Wait for ZAP to start
echo "Waiting for ZAP to start..."
sleep 15

# Run the baseline scan
docker run --network="host" -u zap owasp/zap2docker-stable zap-baseline.py -t $API_URL -r zap_report.html

echo "Scan complete. Report saved as zap_report.html"

# Stop ZAP container
docker stop $(docker ps -q --filter ancestor=owasp/zap2docker-stable)

#!/bin/bash
# -------------------------------------------------------------------
# OWASP ZAP Baseline Scan Script
# Usage: ./zap-scan.sh <API_URL>
# Example: ./zap-scan.sh https://your-api-id.execute-api.us-east-1.amazonaws.com/prod/hello
# -------------------------------------------------------------------

# Exit on error
set -e

API_URL=$1
SKIP_ZAP=$2

if [ -z "$API_URL" ]; then
  echo "❌ Error: API URL is required as the first argument."
  echo "Usage: ./zap-scan.sh <API_URL> [--skip-zap]"
  exit 1
fi

if [ "$SKIP_ZAP" = "--skip-zap" ]; then
  echo "⚠️  Skipping OWASP ZAP scan as requested."
  echo "✅ Scan skipped successfully!"
  echo "📄 No reports generated."
  echo "🎉 Pipeline continues without security scan."
  exit 0
fi

echo "🚀 Starting OWASP ZAP scan against: $API_URL"

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
  echo "❌ Docker not found. Please install Docker and try again."
  exit 1
fi

# Pull ZAP image (official OWASP ZAP Docker image)
echo "🔄 Pulling latest OWASP ZAP image..."
docker pull softwaresecurityproject/zap-stable

# Start ZAP in daemon mode
echo "🧠 Starting ZAP in daemon mode..."
docker run -u zap -d -p 8090:8090 softwaresecurityproject/zap-stable zap.sh -daemon -port 8090 -host 0.0.0.0

# Wait for ZAP to fully initialize
echo "⏳ Waiting for ZAP to start..."
sleep 20

# Run the baseline scan
echo "🧪 Running ZAP baseline scan..."
# Use Windows path format for Git Bash compatibility
WORK_DIR=$(pwd -W 2>/dev/null || pwd | sed 's|^/c/|C:/|; s|^/d/|D:/|; s|^/e/|E:/|; s|/|\\|g')
docker run --network="host" -v "${WORK_DIR}:/zap/wrk" -u zap softwaresecurityproject/zap-stable zap-baseline.py \
  -t "$API_URL" \
  -r zap_report.html \
  -J zap_report.json \
  -w zap_warnings.md \
  -a \
  -I

echo "✅ Scan complete. Reports generated successfully!"
echo "📄 HTML report: zap_report.html"
echo "📄 JSON report: zap_report.json"
echo "📄 Markdown summary: zap_warnings.md"

# Stop any running ZAP containers
echo "🧹 Cleaning up running ZAP containers..."
docker ps -q --filter ancestor=softwaresecurityproject/zap-stable | xargs -r docker stop

echo "🎉 OWASP ZAP scan finished successfully."

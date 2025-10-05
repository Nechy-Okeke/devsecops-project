# DevSecOps Project

[![CI/CD](https://github.com/yourusername/devsecops-project/actions/workflows/deploy.yml/badge.svg)](https://github.com/yourusername/devsecops-project/actions/workflows/deploy.yml)
[![CodeQL](https://github.com/yourusername/devsecops-project/actions/workflows/codeql-analysis.yml/badge.svg)](https://github.com/yourusername/devsecops-project/actions/workflows/codeql-analysis.yml)

A comprehensive DevSecOps CI/CD pipeline demonstrating secure deployment of a serverless API using AWS CloudFormation, GitHub Actions, and OWASP ZAP for security scanning.

## Architecture

- **Application**: Node.js Lambda function serving a simple API.
- **Infrastructure**: AWS CloudFormation for IaC (Lambda, API Gateway, IAM).
- **CI/CD**: GitHub Actions with build, test, security scan, and deployment.
- **Security**: CodeQL for SAST, OWASP ZAP for DAST.

## Features

- Automated testing and linting.
- Security scanning with CodeQL and ZAP.
- CloudFormation change sets to prevent rollbacks.
- Serverless deployment for cost-efficiency.

## Setup

1. **Clone the repository**:
   ```bash
   git clone https://github.com/yourusername/devsecops-project.git
   cd devsecops-project
   ```

2. **AWS Setup**:
   - Create an S3 bucket for Lambda code.
   - Set up IAM user with necessary permissions (CloudFormation, Lambda, API Gateway, S3, IAM).
   - Note the bucket name.

3. **GitHub Secrets**:
   - `AWS_ACCESS_KEY_ID`: Your AWS access key.
   - `AWS_SECRET_ACCESS_KEY`: Your AWS secret key.
   - `AWS_REGION`: e.g., us-east-1
   - `AWS_S3_BUCKET`: Your S3 bucket name.
   - `DOCKER_USERNAME`: Your Docker Hub username (optional, if using Docker in workflow).
   - `DOCKER_PASSWORD`: Your Docker Hub PAT (optional).

4. **Run the pipeline**:
   - Push code to GitHub to trigger the workflow.
   - The pipeline will build, test, scan, and deploy your API.

5. **Run OWASP ZAP scan locally**:
   - Ensure Docker is installed and running.
   - Run the scan script against your deployed API URL:
     ```bash
     ./scripts/zap-scan.sh https://your-api-id.execute-api.us-east-1.amazonaws.com/prod/hello
     ```
   - The scan report will be saved as `zap_report.html`.

## API Usage

After deployment, the API URL will be available in CloudFormation outputs.

Example: `https://your-api-id.execute-api.region.amazonaws.com/prod/hello`

Query with name: `?name=YourName`

## Avoiding Rollbacks

This project uses CloudFormation change sets to review and approve changes before execution, preventing unexpected rollbacks.

## Contributing

Feel free to open issues or PRs for improvements.
###
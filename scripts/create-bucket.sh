#!/bin/bash

# Script to create S3 bucket for DevSecOps project

BUCKET_NAME=$1

if [ -z "$BUCKET_NAME" ]; then
    echo "Usage: $0 <bucket-name>"
    exit 1
fi

echo "Creating S3 bucket: $BUCKET_NAME"

# Create bucket (adjust for region if needed)
aws s3 mb s3://$BUCKET_NAME --region us-east-1

echo "Bucket created successfully."

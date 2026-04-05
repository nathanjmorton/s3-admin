#!/bin/bash

if [ -z "$1" ]; then
  echo "Usage: $0 <bucket-name>" >&2
  exit 1
fi

BUCKET_NAME="$1"

POLICY="{
  \"Version\": \"2012-10-17\",
  \"Statement\": [
    {
      \"Effect\": \"Allow\",
      \"Principal\": {
        \"AWS\": \"arn:aws:iam::073343495859:root\"
      },
      \"Action\": [\"s3:GetObject\", \"s3:ListBucket\"],
      \"Resource\": [
        \"arn:aws:s3:::${BUCKET_NAME}\",
        \"arn:aws:s3:::${BUCKET_NAME}/*\"
      ]
    }
  ]
}"

echo "Applying bucket policy to s3://$BUCKET_NAME..."

aws s3api put-bucket-policy \
  --bucket "$BUCKET_NAME" \
  --policy "$POLICY" \
  --profile temp

if [ $? -eq 0 ]; then
  echo "Policy applied successfully."
else
  echo "Failed to apply policy. Check your AWS credentials and permissions." >&2
  exit 1
fi

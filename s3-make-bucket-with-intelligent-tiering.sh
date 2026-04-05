#!/bin/bash

if [ -z "$1" ]; then
  echo "Usage: $0 <bucket-name>" >&2
  exit 1
fi

BUCKET_NAME="nathanjmorton-$1"

if aws s3api head-bucket --bucket "$BUCKET_NAME" >/dev/null 2>&1; then
  echo "Bucket '$BUCKET_NAME' already exists. Exiting."
  exit 0
fi

aws s3api create-bucket --bucket "$BUCKET_NAME"

aws s3api put-bucket-lifecycle-configuration \
   --bucket "$BUCKET_NAME" \
   --lifecycle-configuration '{
     "Rules": [
       {
         "ID": "intelligent-tiering-90-day",
         "Status": "Enabled",
         "Filter": {"Prefix": ""},
         "Transitions": [
           {
             "Days": 90,
             "StorageClass": "INTELLIGENT_TIERING"
           }
         ]
       }
     ]
   }'


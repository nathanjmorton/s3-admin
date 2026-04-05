#!/bin/bash

if [ -z "$1" ]; then
  echo "Usage: $0 <bucket-name>" >&2
  exit 1
fi

BUCKET_NAME="$1"

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


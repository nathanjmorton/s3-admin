#!/bin/bash

if [ -z "$1" ]; then
  echo "Usage: $0 <bucket-name>" >&2
  exit 1
fi

BUCKET_NAME="$1"

aws s3 sync s3://"$BUCKET_NAME" s3://nathanjmorton-"$BUCKET_NAME" --copy-props none

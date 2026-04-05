aws s3api create-bucket --bucket nathanjmorton-ardanlabslms-bucket

aws s3api put-bucket-lifecycle-configuration \
   --bucket nathanjmorton-ardanlabslms-bucket \
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


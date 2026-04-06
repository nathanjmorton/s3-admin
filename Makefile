.PHONY: help create-bucket set-policy sync setup

# Default target: show help
help:
	@echo ""
	@echo "s3-admin — AWS S3 utility scripts"
	@echo ""
	@echo "Usage: make <target> BUCKET=<bucket-name>"
	@echo ""
	@echo "Targets:"
	@echo ""
	@echo "  create-bucket  BUCKET=<name>"
	@echo "      Creates a new S3 bucket and configures a lifecycle rule to"
	@echo "      automatically transition objects to S3 Intelligent-Tiering"
	@echo "      after 90 days."
	@echo "      Example: make create-bucket BUCKET=my-new-bucket"
	@echo ""
	@echo "  set-policy     BUCKET=<name>"
	@echo "      Applies a bucket policy that grants s3:GetObject and"
	@echo "      s3:ListBucket access to the root of AWS account 073343495859."
	@echo "      Runs under the 'temp' AWS CLI profile."
	@echo "      Example: make set-policy BUCKET=my-new-bucket"
	@echo ""
	@echo "  sync           BUCKET=<name>"
	@echo "      Syncs the contents of s3://<bucket-name> into"
	@echo "      s3://nathanjmorton-<bucket-name> (no property copying)."
	@echo "      Example: make sync BUCKET=my-source-bucket"
	@echo ""
	@echo "  setup          BUCKET=<name>"
	@echo "      Runs create-bucket, set-policy, and sync in sequence."
	@echo "      Example: make setup BUCKET=my-new-bucket"
	@echo ""

create-bucket:
ifndef BUCKET
	$(error BUCKET is required. Usage: make create-bucket BUCKET=<bucket-name>)
endif
	bash s3-make-bucket-with-intelligent-tiering.sh $(BUCKET)

set-policy:
ifndef BUCKET
	$(error BUCKET is required. Usage: make set-policy BUCKET=<bucket-name>)
endif
	bash s3-bucket-policy.sh $(BUCKET)

sync:
ifndef BUCKET
	$(error BUCKET is required. Usage: make sync BUCKET=<bucket-name>)
endif
	bash s3-synch.sh $(BUCKET)

setup:
ifndef BUCKET
	$(error BUCKET is required. Usage: make setup BUCKET=<bucket-name>)
endif
	$(MAKE) create-bucket BUCKET=$(BUCKET)
	$(MAKE) set-policy BUCKET=$(BUCKET)
	$(MAKE) sync BUCKET=$(BUCKET)

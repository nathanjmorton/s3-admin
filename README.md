# s3-admin

A collection of AWS S3 utility scripts for common bucket administration tasks, wrapped in a `Makefile` for easy invocation.

## Prerequisites

- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html) installed and configured
- `make` installed (available by default on macOS)

---

## Usage

All commands follow this pattern:

```sh
make <target> BUCKET=<bucket-name>
```

Run `make` or `make help` to print a summary of all available targets.

---

## Targets

### `create-bucket`

Creates a new S3 bucket and attaches a lifecycle rule that automatically transitions objects to [S3 Intelligent-Tiering](https://aws.amazon.com/s3/storage-classes/intelligent-tiering/) after 90 days.

```sh
make create-bucket BUCKET=my-new-bucket
```

---

### `set-policy`

Applies a bucket policy granting `s3:GetObject` and `s3:ListBucket` access to the root of AWS account `073343495859`. Runs under the `temp` AWS CLI profile.

```sh
make set-policy BUCKET=my-new-bucket
```

---

### `sync`

Syncs all objects from `s3://<bucket-name>` into `s3://nathanjmorton-<bucket-name>`. Object properties are not copied (`--copy-props none`).

```sh
make sync BUCKET=my-source-bucket
```

---

## Example Workflow

Create a bucket, apply a policy, then sync it to a personal bucket:

```sh
make create-bucket BUCKET=my-project-data
make set-policy    BUCKET=my-project-data
make sync          BUCKET=my-project-data
```

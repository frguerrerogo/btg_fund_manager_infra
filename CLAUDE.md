# Terraform Project Architecture Rules

## Stack

- IaC: Terraform
- Database: AWS DynamoDB
- Storage: AWS S3
- Environment managed via `var.env` (e.g., `dev`, `staging`, `prod`)

---

## Environment Setup

Environments are controlled by a `terraform.tfvars` file at the root. This file is **never committed to git** — each developer or CI pipeline has its own.

```hcl
# terraform.tfvars
env = "dev"

common_tags = {
  Project     = "my-app"
  Environment = "dev"
  ManagedBy   = "terraform"
}
```

To deploy to a different environment, either change the file or pass the variable inline:

```bash
terraform apply -var="env=staging"
```

The root `variables.tf` declares the accepted values:

```hcl
variable "env" {
  type        = string
  description = "Deployment environment"

  validation {
    condition     = contains(["dev", "staging", "prod"], var.env)
    error_message = "env must be dev, staging, or prod."
  }
}

variable "common_tags" {
  type    = map(string)
  default = {}
}
```

---

## Module Structure

Each domain module follows this structure (replace `<module_name>` with your module's name):

```
modules/
└── <module>/
    ├── main.tf           # Orchestrator: calls sub-modules only
    ├── variables.tf      # Receives variables from root
    ├── outputs.tf        # Exposes sub-module outputs to root
    ├── dynamodb/
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    └── s3/               # Only if the module requires S3
        ├── main.tf
        ├── variables.tf
        └── outputs.tf
```

### Rules

- The `main.tf` at module level **does not create resources directly** — it only calls sub-modules.
- Each sub-module (`dynamodb/`, `s3/`) has a **single responsibility**.
- Sub-modules receive variables from the parent module and return outputs back to it.
- Sub-modules **do not call each other** — only the parent `main.tf` orchestrates them.

---

## Data Flow

```
root/main.tf
    └── module "<module_name>" (env, tags, ...)
            ├── module "dynamodb" → creates table → returns ARNs
            └── module "s3"       → creates bucket → returns ARNs (optional)
```

Variables flow **downward** (root → module → sub-module).
Outputs flow **upward** (sub-module → module → root).

---

## DynamoDB Conventions

- Billing mode: `PAY_PER_REQUEST` (default)
- Table naming: `${var.env}-<entity>` (e.g., `dev-users`, `dev-transactions`)
- Use `String` type for all IDs
- Add `tags = var.tags` to every table

### When to create a GSI

Create a GSI **only when you need to query by a field that is not the Partition Key**.

| You need to...                           | Solution                       |
| ---------------------------------------- | ------------------------------ |
| Get one item by `id`                     | No GSI — use `GetItem` with PK |
| Get all items (e.g., list all funds)     | No GSI — use `Scan`            |
| Get all transactions by `user_id`        | GSI on `user_id`               |
| Get all orders with `status = "PENDING"` | GSI on `status`                |
| Lookup a user by `email`                 | GSI on `email`                 |

> Rule of thumb: if your app needs to ask _"give me all X that belong to Y"_, that's a GSI.

### Example Table Definitions

| Scenario           | PK Example        | SK Example   | GSI Examples                           |
| ------------------ | ----------------- | ------------ | -------------------------------------- |
| Single entity      | `entity_id` (S)   | —            | Query indexes (e.g., `email-index`)    |
| Hierarchy/Timeline | `parent_id` (S)   | `created_at` | Lookup indexes (e.g., `user_id-index`) |
| Complex lookups    | `primary_key` (S) | —            | Multiple indexes for different queries |

### GSI naming

```
<lookup_field>-index
```

Examples: `user_id-index`, `email-index`, `status-index`

---

## S3 Conventions

- Bucket naming: `${var.env}-<module>-${var.bucket_suffix}` (e.g., `dev-users-profile-pictures`)
- Always enable:
  - Versioning
  - Server-side encryption (`AES256`)
  - Block all public access
- Add `tags = var.tags` to every bucket

### Bucket suffixes

All S3 bucket suffixes are defined centrally in `root/locals.tf` — never as loose variables per module call.

```hcl
# root/locals.tf
locals {
  common_tags = {
    Project     = "my-app"
    Environment = var.env
    ManagedBy   = "terraform"
  }

  bucket_suffixes = {
    users    = "profile-pictures"
    products = "product-images"
    reports  = "exports"
  }
}
```

This way, all bucket names are visible and consistent in one place.

---

## Shared Variables (all modules must accept)

```hcl
variable "env"  { type = string }           # dev | staging | prod
variable "tags" { type = map(string) }      # common tags
```

---

## Outputs (all modules must expose)

```hcl
# DynamoDB sub-module
output "table_arn"  { value = aws_dynamodb_table.<name>.arn }
output "table_name" { value = aws_dynamodb_table.<name>.id }

# S3 sub-module
output "bucket_arn" { value = aws_s3_bucket.<name>.arn }
output "bucket_id"  { value = aws_s3_bucket.<name>.id }
```

---

## Root `main.tf` Pattern

To add a new module, follow this pattern:

```hcl
module "<module_name>" {
  source = "./modules/<module_name>"
  env    = var.env
  tags   = local.common_tags
  # Add bucket_suffix only if the module uses S3
  # Always pull the value from local.bucket_suffixes
}
```

**Example additions:**

```hcl
module "products" {
  source        = "./modules/products"
  env           = var.env
  tags          = local.common_tags
  bucket_suffix = local.bucket_suffixes["products"]
}

module "notifications" {
  source = "./modules/notifications"
  env    = var.env
  tags   = local.common_tags
}
```

---

## Naming Conventions

| Resource       | Pattern                                   |
| -------------- | ----------------------------------------- |
| DynamoDB table | `${var.env}-<entity>`                     |
| S3 bucket      | `${var.env}-<module>-${var.suffix}`       |
| GSI            | `<lookup_field>-index`                    |
| Module folder  | lowercase, singular (e.g., `users`)       |
| Sub-module     | named by resource type (`dynamodb`, `s3`) |

---

## What NOT to do

- Do not create resources directly in a domain module's `main.tf` — always delegate to sub-modules.
- Do not hardcode environment names — always use `var.env`.
- Do not share state between sub-modules directly — route through the parent module.
- Do not skip outputs — every sub-module must expose its resource ARNs.
- Do not create a GSI unless you have a concrete query pattern that requires it.
- Do not define `bucket_suffix` as a hardcoded string in `root/main.tf` — always pull from `local.bucket_suffixes`.
- Do not commit `terraform.tfvars` to git — add it to `.gitignore`.

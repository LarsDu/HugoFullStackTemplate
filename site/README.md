# Hugo Full Stack Template

This template has everything one needs to deploy a static site on Google Cloud and Cloudflare with free SSL through Cloudflare DNS management.

This repo is WIP and may require running `make apply` for deploying Terraform changes multiple times.

Deploying a site requires the following steps:

1. Get a Google Cloud Account and get a `service account key`
    - Escalate service account IAM permissions to administer:
        - Project IAM Admin (to change bucket permissions)
        - IAM Workload Identity Pool Admin (for WIF iam permissions)
        - Service Account Admin (to create service accounts)
        - Storage Admin (to create and delete buckets)
    - Create a project with a `project_id`
2. Get a CloudFlare account and get a `api_token`
3. *IMPORTANT* Create and fill out `terraform/prod/terraform.tfvars`.
3. `cd terraform/prod; make apply`
    - Errors will occur due to lack of domain registration confirmation. Go ahead and confirm domain registration following any prompts that appear.
5. Edit `site/config.toml` deployment targets to point at your bucket/root domain (ie: `gs://mysite.net`).
6. Add `PROVIDER_NAME` (workload_provider_name in your `*tfstate`) `SA_EMAIL` (storage_service_account_email in `*tfstate`) to `Github Actions Secrets` in Github.
7. Push to Github `$ git push origin main`!
    - *Optional*: Consider adding a theme to your Hugo site before pushing


#### TODOs:
 - Move state management from `terraform.tfvars` to  GCloud
 - Use terragrunt to key things DRY
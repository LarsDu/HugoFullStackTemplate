# Hugo Full Stack Template

### Background

This template has everything one needs to deploy a static site on Google Cloud and Cloudflare with free SSL through Cloudflare DNS management.

This repo consolidates the steps covered in [Making a HUGO Website The Full Stack Way](https://du-blog.net/blog/hugo-blog-0/) automating a large number of steps with Terraform.


This repo is WIP and may still require running `make apply` for deploying Terraform changes multiple times to resolve DNS issues that might arise.

### Steps
Deploying a site requires the following steps:

1. Get a Google Cloud Account and get a `service account key`
    - Escalate service account IAM permissions to administer:
        - Project IAM Admin (to change bucket permissions)
        - IAM Workload Identity Pool Admin (for WIF iam permissions)
        - Service Account Admin (to create service accounts)
        - Storage Admin (to create and delete buckets)
    - Create a project with a `project_id`
2. Get a CloudFlare account and get a `api_token`
3. Register a domain with Cloudflare
4. *IMPORTANT* Create and fill out `terraform/prod/terraform.tfvars`.
5. `cd terraform/prod; terraform init; make apply`
    - Errors will occur due to lack of domain registration confirmation. Go ahead and confirm domain registration following any prompts that appear.
6. Edit `site/config.toml` deployment targets to point at your bucket/root domain (ie: `gs://mysite.net`).
7. Add `PROVIDER_NAME` (workload_provider_name in your `*tfstate`) `SA_EMAIL` (storage_service_account_email in `*tfstate`) to `Github Actions Secrets` in Github.
8. Enable Github Actions for your Repo in your Repo settings.
9. Push to Github with `$ git push origin main`
    - *Optional*: Consider adding a theme to your Hugo site before pushing.
10. Verify Github Actions is working and check your domain name for your new website! 

### Explanation

The Terraform step (4) above should setup a Cloudflare DNS, DNS records for your site, Forwarding rules for HTTPS, SSL records, Caching and CDN via Cloudflare, Google Cloud Storage bucket for your site, a service account + workload identity pool to let Github Actions work on your bucket!

#### TODOs:
 - Move state management from `terraform.tfvars` to  GCloud
 - Use terragrunt to key things DRY
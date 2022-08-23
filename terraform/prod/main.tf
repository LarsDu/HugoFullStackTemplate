terraform{
  required_providers{
    google = {
      source = "hashicorp/google"
      version = "4.32.0"
    }

    cloudflare ={
      source = "cloudflare/cloudflare"
      version = "3.21.0"
    }

  }
}

provider "google" {
  region = var.region
  credentials = file(var.gcp_key_file) # TODO: Replace with ADC: https://cloud.google.com/sdk/gcloud/reference/auth/application-default
  project = var.project_id
}

provider "cloudflare" {
    email = var.cloudflare_email
    api_key = var.cloudflare_api_key
}

# Needed for OIDC module
provider "google-beta" {
  region = var.region
  credentials = file(var.gcp_key_file) # TODO: Replace with ADC: https://cloud.google.com/sdk/gcloud/reference/auth/application-default
  project = var.project_id
}

locals {
  storage_service_account_name = "storage-sa"
}

module "cloudflare_dns" {
  source = "../modules/dns"
  cloudflare_zone_id = var.cloudflare_zone_id
  root_domain = var.root_domain
  ssl_override = var.ssl_override
  confirm_dns_txt = var.confirm_dns_txt
  static_site_storage_domain = var.static_site_storage_domain
}

module "bucket" {
  source = "../modules/bucket"
  project_id = var.project_id
  root_domain = var.root_domain
  storage_class = "STANDARD"
  depends_on = [
    module.cloudflare_dns # Creates TXT record with domain registration confirmation
  ]
}

# The blog_service_acct is used by github_oidc to update the blog
# It has full admin ability over storage for the project
# See: https://github.com/terraform-google-modules/terraform-google-service-accounts/blob/master/outputs.tf
module "storage_service_account" {
  source        = "terraform-google-modules/service-accounts/google"
  version       = "~> 3.0"
  project_id    = var.project_id
  prefix        = var.prefix # No dashes in the prefix!
  names         = [local.storage_service_account_name]
  display_name = "Storage admin service account"
  description = "Service account for managing storage access"
  project_roles = [
    "${var.project_id}=>roles/storage.objectAdmin", # Need to edit iam permissions for this service account
  ]
  depends_on = [
    module.bucket,
    module.cloudflare_dns
  ]
}


// https://github.com/terraform-google-modules/terraform-google-github-actions-runners/tree/master/modules/gh-oidc
module "oidc" {
  source = "terraform-google-modules/github-actions-runners/google//modules/gh-oidc"
  version = "3.1.0"
  project_id = var.project_id
  provider_id = var.oidc_provider_id
  pool_id = "${var.prefix}-wif-pool"
  issuer_uri = var.oidc_issuer_uri
  sa_mapping = {
    "storage-service-account" = {
      sa_name = "projects/${var.project_id}/serviceAccounts/${var.prefix}-${local.storage_service_account_name}@${var.project_id}.iam.gserviceaccount.com"
      attribute = "*"
    }
  }
  depends_on = [
    module.storage_service_account
  ]
}






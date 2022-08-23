variable "project_id" {
    type = string
    description = "Project id"
}

variable "region" {
    type = string
    description = "Availability Zone region. See: https://cloud.google.com/compute/docs/regions-zones"
}

# Tokens and Keys
# TODO: Try to replace with https://cloud.google.com/sdk/gcloud/reference/auth/application-default
variable "gcp_key_file" {
    type = string
    description = "Keyfile for bucket authentication. Used for GCloud "
}

variable "cloudflare_api_key" {
    type = string
    description = "Cloudflare API key"
}

variable "cloudflare_email" {
    type = string
    description = "E-mail registered with Cloudflare"
}

# Cloudflare DNS

variable "cloudflare_zone_id" {
    type = string
    description = "Cloudflare zone id"
}

variable "confirm_dns_txt" {
    type = string
    description = "A TXT record to confirm domain ownership. See (replace mysite.net with your domain): https://www.google.com/webmasters/verification/verification?siteUrl=mysite.net"
}

variable "ssl_override" {
    type = string
    default = "full"
    description = "Allowed values: \"off\" (default), \"flexible\", \"full\"(default), \"strict\", \"origin_pull\""
}

variable "static_site_storage_domain" {
    type = string
    description = "Endpoint of the storage provider for our static site"
}

# Bucket management
variable "root_domain" {
    type = string
    description = "Domain name and bucket name for site. ie: www.mysite.net"
}

variable "prefix" {
    type = string
    description = "Prefix for storage account and wif pools"
}

variable "oidc_provider_id" {
    type = string
    description = "Open ID Connect provider id. ie: \"GitHub\""
    default = "GitHub"
}

variable "oidc_issuer_uri" {
    type = string
    description = "Open ID connect issuer ID"
    default = "https://token.actions.githubusercontent.com"
}

# Storage Bucket
#output "static_site_url" {
#    value = module.bucket.url
#}

# OIDC
output "workload_identity_pool_name" {
    value = module.oidc.pool_name
}

output "workload_provider_name" {
  value = module.oidc.provider_name
}

# Storage service account
output "storage_service_account_email" {
  description = "Storage Service account resource (for single use)."
  value       = module.storage_service_account.email
}

output "storage_service_account" {
  description = "Storage Service account resources as list."
  value       = module.storage_service_account.service_account
}

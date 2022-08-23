
variable "cloudflare_zone_id" {
    type = string
    description = "Cloudflare zone id"
}

variable "root_domain" {
    type = string
    description = "Root domain (ie: mysite.net)"
}

variable "static_site_storage_domain" {
    type = string
    default = "c.storage.googleapis.com"
    description = "Storage endpoint for our static site."
}

variable "ssl_override" {
    type = string
    default = "full"
    description = "Allowed values: \"off\" (default), \"flexible\", \"full\"(default), \"strict\", \"origin_pull\""
}

variable "confirm_dns_txt" {
    type = string
    description = "A TXT record to confirm domain ownership. See: https://www.google.com/webmasters/verification/verification?siteUrl=mysite.net"

}
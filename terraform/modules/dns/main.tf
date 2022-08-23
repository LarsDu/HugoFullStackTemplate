// See: https://blog.cloudflare.com/getting-started-with-terraform-and-cloudflare-part-2/

terraform{
  required_providers{
    cloudflare ={
      source = "cloudflare/cloudflare"
      version = "3.21.0"
    }
  }
}

# Create a CNAME record
resource "cloudflare_record" "www" {
    zone_id = var.cloudflare_zone_id
    #domain   = var.root_domain
    name    = "www"
    value = var.static_site_storage_domain
    type    = "CNAME"
    ttl     = 1
    proxied = true
}

# Create a CNAME record
resource "cloudflare_record" "root" {
    zone_id = var.cloudflare_zone_id
    #domain = var.root_domain
    name    = "@"
    value   = var.static_site_storage_domain
    type    = "CNAME"
    ttl     = 1
    proxied = true
}
resource "cloudflare_record" "txt_confirm"{
    zone_id = var.cloudflare_zone_id
    #domain = var.root_domain
    name = var.root_domain
    value = var.confirm_dns_txt
    type = "TXT"
    ttl = 3600
}

# Redirect www subdomain traffic to root domain
resource "cloudflare_page_rule" "www_to_root" {
    zone_id = var.cloudflare_zone_id
    target = "www.${var.root_domain}/*"
    actions {
        forwarding_url {
            status_code = "301"
            url = "https://${var.root_domain}/$1"
        }
    }
}

# Add a free SSL cert (this may be a bit buggy?)
# Note: This may actually depend on our bucket existing (??)
resource "cloudflare_zone_settings_override" "ssl_tls_overview" {
    zone_id = var.cloudflare_zone_id
    settings{
        ssl = var.ssl_override
    }
    depends_on = [
      cloudflare_page_rule.www_to_root,
      cloudflare_record.root,
      cloudflare_record.txt_confirm
    ]
}
# Note: You will need to tie service account e-mail to the domain name manually!

resource "google_storage_bucket" "static-site" {
    name          = var.root_domain
    location      = "US"
    storage_class = var.storage_class
    force_destroy = true
    uniform_bucket_level_access = true
    website{
      main_page_suffix = "index.html"
      not_found_page   = "404.html"
    }
    cors {
      origin = [ "*" ]
      method          = ["GET", "HEAD", "PUT", "POST", "DELETE"]
      response_header = ["*"]
      max_age_seconds = 3600
  }
}

resource "google_storage_bucket_iam_member" "viewers" {
  bucket   = var.root_domain
  role     = "roles/storage.objectViewer"
  member   = "allUsers"
  depends_on = [
    google_storage_bucket.static-site
  ]
}

# ref: https://github.com/simplycubed/terraform-google-static-assets/tree/v0.5.2/modules/cloud-storage-static-website
# ref: https://www.youtube.com/watch?v=-kuZ4NT4jpk
# ref: https://stackoverflow.com/questions/23439840/google-cloud-storage-cant-add-bucket-with-domain-ownership-error
# ref: https://cloud.google.com/storage/docs/domain-name-verification
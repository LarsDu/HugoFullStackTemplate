output "bucket_link" {
    description = "Website static site link"
    value = google_storage_bucket.static-site.self_link
}
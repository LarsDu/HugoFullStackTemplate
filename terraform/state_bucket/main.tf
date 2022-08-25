terraform{
  required_providers{
    google = {
      source = "hashicorp/google"
      version = "4.32.0"
    }
  }
}

provider "google" {
  region = var.region
  credentials = file(var.gcp_key_file)
  project = var.project_id
}

resource "random_id" "instance_id" {
  byte_length = 8
}

resource "google_storage_bucket" "state_bucket" {
  name = "bucket-tfstate-${random_id.instance_id.hex}"
  location      = "US"
  storage_class = "STANDARD"
  versioning {
    enabled = true
  }
}
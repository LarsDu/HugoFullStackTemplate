variable "project_id" {
  type = string
}

variable "root_domain" {
  type = string
  description = "Root domain name and bucket name for site. ie: myblog.net"
}

variable "bucket_location" {
  type = string
  default = "us-west-1b"
}

variable "storage_class" {
  type = string
}

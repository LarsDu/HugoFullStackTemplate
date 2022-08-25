variable "region" {
    type = string
    default = "us-west-1b"
}

variable "project_id" {
    type = string
    description = "Project id"
}

variable "gcp_key_file" {
    type = string
    description = "Keyfile for bucket authentication. Used for GCloud "
}
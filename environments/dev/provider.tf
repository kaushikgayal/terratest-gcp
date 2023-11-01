provider "google" {
  project      = var.project
  access_token = var.auth_token
}

provider "google-beta" {
  project      = var.project
  access_token = var.auth_token
}
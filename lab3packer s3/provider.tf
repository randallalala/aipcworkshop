terraform {
  required_version = ">=1.0.0"
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "2.12.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.1.0"
    }
  }
  backend "s3" {
    endpoint                    = "sgp1.digitaloceanspaces.com"
    key                         = "workshop3/terraform.tfstate"
    bucket                      = "aipc"
    skip_requesting_region      = true
    skip_requesting_account_id  = true
    skip_credentials_validation = true
    skip_get_ex2_plaforms       = true
    skip_metadata_api_check     = true
    access_key                  = "value"
    secret_key                  = "value"
  }
}


provider "digitalocean" {
  token = var.DO_token
}

provider "local" {
}

variable DO_token {
            type = string
            default = env("DO_token")
            sensitive = true
            # also possible pkr_var_name
}
variable DO_region {
            type = string
            default = "sgp1"
}

variable DO_size {
            type = string
            default = "s-1vcpu-1gb"
}

data terraform_remote_state mysql8 {
  backend = "s3"
  config = {
    endpoint                    = "https://sgp1.digitaloceanspaces.com"
    key                         = "workshop3/terraform.tfstate"
    bucket                      = "aipc"
    region                      = "spg1"
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_metadata_api_check     = true
   }
}


output database_endpoint {
  value = data.terraform_remote_state.mysql8.outputs.mysql8_enpoint
}
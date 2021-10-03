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

# data terraform_remote_state mysql8 {
#   backend = "s3"
#   config = {
#     endpoint                    = "https://sgp1.digitaloceanspaces.com"
#     key                         = "workshop3/terraform.tfstate"
#     bucket                      = "aipc"
#     region                      = "spg1"
#     skip_region_validation      = true
#     skip_credentials_validation = true
#     skip_metadata_api_check     = true
#    }
# }


data digitalocean_ssh_key aipc {
    name = "aipc-sept27"
}

data digitalocean_image mysql8 {
    name = "mysql8"
}

# output database_endpoint {
#   value = data.terraform_remote_state.mysql8.outputs.mysql8_enpoint
# }

resource digitalocean_droplet mysql8-sgp1 {
    name = "mysql8-sgp1"
    image = data.digitalocean_image.mysql8.id
    region = var.DO_region
    size = var.DO_size
    ssh_keys = [ data.digitalocean_ssh_key.aipc.id ]
}

resource local_file root_at_ip {
    filename = "root@${digitalocean_droplet.mysql8-sgp1.ipv4_address}"
    file_permission = "0444"
}

output mysql8_enpoint {
    value = "${digitalocean_droplet.mysql8-sgp1.ipv4_address}:3306"
}
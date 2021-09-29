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

variable DO_image {
            type = string
            default = "ubuntu-20-04-x64"
}



source digitalocean mysql_droplet {
    api_token   = var.DO_image
    region   = var.DO_region
    size   = var.DO_size
    image   = var.DO_image
    snapshot_name =  "mysql8"
    ssh_username = "root"
}

build {
    sources = [
        "source.digitalocean.mysql8_image"
    ]

    provisioner ansible{

        
    }
}
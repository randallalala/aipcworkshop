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

# variable DO_image {
#             type = string
#             default = "ubuntu-20-04-x64"
# }

data digitalocean_ssh_key aipc {
  name = "aipc-sept27"
}

data digitalocean_image mysql8{
    name = "mysql8"
}

data digitalocean_droplet mysql8{
    name = "mysql8_sgp1"
    image = data.digitalocean_image.mysql8.id
    region = var.DO_region
    size = var.DO_size
    ssh_keys = [data.digitalocean_ssh_key.id]
}
resource "localfile" "root_at_ip" {
  filename = "root@${digitalocean_droplet.mysql8-sgp1.ipv4.id}"
  file_permission = "0444"
  directory_permission = "0777"
}
output mysql8_ip {
  value = digitalocean_droplet.mysql8_sgp1.ipv4_address
}
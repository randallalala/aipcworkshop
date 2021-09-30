variable DO_token {
    type = string 
    sensitive = true
}

data digitalocean_ssh_key aipc {
    name = "aipc"
}

resource "digitalocean_droplet" "myserver" {
  
}

output "ipv4" {
  value = join (",",digitalocean_droplet.myserver[*])
}
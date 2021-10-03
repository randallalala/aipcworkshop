variable DO_token {
    type = string 
    sensitive = true
}

data digitalocean_ssh_key aipc {
    name = "aipc"
}

resource digitalocean_droplet myserver {
    // mandatory attributes
    count = 1
    name = "myserver-${count.index}"
    image = "ubuntu-21-04-x64"
    size = "s-1vcpu-1gb"
    region = "sgp1"

    // ssh key
    ssh_keys = [ data.digitalocean_ssh_key.aipc-sept27.id ]
}

resource local_file inventory {
    filename = "inventory.yaml"
    file_permission = "0444"
    content = templatefile("inventory.yaml.tpl", {
        droplets = digitalocean_droplet.myserver
    })
}
resource local_file add_host {
    filename = "add_host.sh"
    file_permission = "0755"
    content = templatefile("add_host.sh.tpl", {
        droplets = digitalocean_droplet.myserver
    })
}

output "ipv4" {
  value = join (",",digitalocean_droplet.myserver[*])
}

output name_to_ipv4 {
    value = { for d in digitalocean_droplet.myserver: d.name => d.ipv4_address}
}
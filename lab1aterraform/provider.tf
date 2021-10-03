terraform {
    required_version = ">= 1.0.0"
    required_providers {
        docker = {
            source = "kreuzwerker/docker"
            version = "2.15.0"
        }
    }
}

provider docker {
    host = "tcp://188.166.237.66:2376"
    cert_path = "/home/cmlee/.docker/machine/machines/my-docker"
}
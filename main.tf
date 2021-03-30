terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "2.11.0"
    }
  }
}

provider "docker" {
  # Configuration options
}

resource "docker_image" "nodered_image" {
  name = "nodered/node-red:latest"
}

resource "docker_container" "nodered_container" {
  name  = "nodered"
  image = docker_image.nodered_image.latest
  ports {
    internal = 1880
    external = 1890
  }
}

## Fetching output

output "IP-Address" {
  value = docker_container.nodered_container.ip_address
  description = "The IP address of the container"
}
output "Container-Name" {
  value = docker_container.nodered_container.name
  description = "The name of the container"
}

output "Application-Access-URL" {
  value = join(":",[docker_container.nodered_container.ip_address, docker_container.nodered_container.ports[0].external])
  description = "Application-Access-URL"
}

output "Image-Used" {
  value = docker_image.nodered_image.name
  description = "The name of the image used for container"
}

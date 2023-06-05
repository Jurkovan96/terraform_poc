# Terraform provider for docker
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.2"
    }
  }
}

# General network
resource "docker_network" "docker_network_with_terraform" {
  name = "docker_network_with_terraform"
}

# Custom image
resource "docker_image" "mysql_tf" {
  name         = "mysql:latest"
  keep_locally = true
}

# Docker container
resource "docker_container" "mysql_tf_container" {
  image    = docker_image.mysql_tf.image_id
  name     = "mysql"
  env = [
    "MYSQL_ROOT_PASSWORD=adminMasterPass",
    "MYSQL_PASSWORD=adminPass",
    "MYSQL_USER=test_user",
  ]

  ports {
    internal = 3306
    external = 8088
  }

  network_mode = docker_network.docker_network_with_terraform.name
}

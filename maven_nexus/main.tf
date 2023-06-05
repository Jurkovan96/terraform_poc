# Terraform provider for docker
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.2"
    }
  }
}

# Custom image
resource "docker_image" "nexus_sonar" {
  name = "sonatype/nexus3"
}

# Docker container
resource "docker_container" "mysql_tf_container" {
  image = docker_image.nexus_sonar.image_id  
  name  = "nexus_sonar"
 
  ports {
    internal = 8081
    external = 8082
  }
}

provider "local"{}
# Start a container
resource "docker_container" "tomcat" {
  image = "${docker_image.tomcat.latest}"
  must_run = true
  name  = "tomcat"
     ports {
        internal = 8080
        external = 8080
        }
}

# Find the latest precise image.
resource "docker_image" "tomcat" {
  name = "tomcat"
}
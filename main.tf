provider "local"{}
# Start a container
resource "docker_container" "tomcat7" {
  image = "${docker_image.tomcat.latest}"
  must_run = true
  name  = "tomcat7"
     ports {
        internal = 8080
        external = 8080
        }
}

# Find the latest precise image.
resource "docker_image" "tomcat7" {
  name = "rafaelbonilha85/tomcat7:latest"
}
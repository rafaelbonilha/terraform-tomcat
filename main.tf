provider "local"{}
# Start a container
resource "docker_container" "tomcat7" {
  image = "${docker_image.tomcat7.latest}"
  must_run = true
  name  = "tomcat7"
     ports {
        internal = 8080
        external = 8080
        }
}

# Find the latest precise image.
resource "docker_image" "tomcat7" {
  name = "fabric8/tomcat-7:1.2.1"
}
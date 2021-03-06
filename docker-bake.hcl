# by allex_wang

variable "TAG" {
  default = "8-jre-alpine"
}

group "default" {
  targets = ["8-jre-alpine"]
}

target "8-jre-alpine" {
  context = "."
  dockerfile =  "Dockerfile"
  args = {
    JAR_FILE = "target/tdio-cms-serve.jar"
  }
  tags = [
    "docker.io/tdio/spring-boot-base:${TAG}"
  ]
  platforms = ["linux/amd64","linux/arm64"]
}

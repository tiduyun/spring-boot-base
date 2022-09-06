# by allex_wang

variable "PREFIX" { default = "tdio" }
variable "TAG" { default = "8-jre-alpine" }
variable "BUILD_GIT_HEAD" { default = "" }

group "default" {
  targets = ["8-jre-alpine"]
}

target "8-jre-alpine" {
  context = "."
  dockerfile =  "Dockerfile"
  args = {
    JAR_FILE = "target/tdio-cms-serve.jar"
    BUILD_GIT_HEAD = "${BUILD_GIT_HEAD}"
  }
  tags = [
    "${PREFIX}/spring-boot-base:latest",
    "${PREFIX}/spring-boot-base:${TAG}"
  ]
  platforms = ["linux/amd64","linux/arm64"]
}

# Usage

A base docker image for spring-boot build. Based on [openjdk:8-jre-alpine](https://hub.docker.com/_/openjdk/?tab=tags&page=1&ordering=last_updated&name=8-jre-alpine) with some fixes and enhancements. for more details see [Dockerfile](https://github.com/tiduyun/spring-boot-base/blob/main/Dockerfile)

* Simplify project Dockerfile configurations. 
* Fix fontconfig lossing.

## Simple Dockerfile

```sh
cat <<EOF > Dockerfile
FROM tdio/spring-boot-base:8-jre-alpine
EOF
```

```sh
$ docker build -t xx --build-arg JAR_FILE=./target/xx.jar
```

or build with `buildx bake`

## docker-bake.hcl

```sh
cat <<EOF > docker-bake.hcl
variable "TAG" {
  default = "latest"
}

group "default" {
  targets = ["test"]
}

target "test" {
  context = "."
  dockerfile =  "Dockerfile"
  args = {
    JAR_FILE = "target/test-spring-app.jar"
  }
  tags = [
    "test-spring-app:${TAG}",
  ]
  platforms = ["linux/amd64", "linux/arm64"]
}
EOF
```

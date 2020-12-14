#!/bin/sh
# Simple bootstrap wrapper for spring-boot application
# by allex_wang
set -e

dir=/app

__main__ () {
  [ -d $dir ] || {
    echo >&2 "app context not exits."
    exit 1
  }

  cd $dir
  local SERVER_PORT=${SERVER_PORT:-8089}
  local APP_OPTS="${APP_OPTS:-}"
  local JAVA_OPTS="${JAVA_OPTS:-} ${JAVA_OPTS_EXT:-}"

  set -x
  java -Djava.security.egd=file:/dev/./urandom \
    -Dloader.path=lib,config \
    -Dfile.encoding=utf-8 -Duser.timezone=GMT+08 -Duser.language=zh -Duser.region=CN ${JAVA_OPTS} \
    -jar /app.jar ${APP_OPTS} --server.port=${SERVER_PORT}
}

__main__

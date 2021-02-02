# by allex_wang
FROM openjdk:8-jre-alpine
LABEL maintainer="Allex Wang <allex.wxn@gmail.com>"

ARG TZ="Asia/Shanghai"

ENV TZ $TZ
ENV JAVA_OPTS -XX:MetaspaceSize=128m -XX:MaxMetaspaceSize=128m -Xms4096m -Xmx4096m -Xmn2g -Xss1024k -XX:SurvivorRatio=8 -XX:+UseConcMarkSweepGC
ENV JAVA_OPTS_EXT "-Dspring.profiles.active=prod"
ENV APP_OPTS ""
ENV SERVER_PORT 8080

EXPOSE ${SERVER_PORT}

WORKDIR /app

VOLUME /app

COPY ./repositories /etc/apk/
COPY start.sh /start.sh

RUN apk add --no-cache ttf-dejavu fontconfig \
    && chmod 555 /start.sh \
# add defualt timezone
    && apk add --no-cache --virtual .apt-deps \
        tzdata \
        && cp -s /usr/share/zoneinfo/${TZ} /etc/localtime \
        && echo "${TZ}" > /etc/timezone \
    && tar -cf tz.tar /usr/share/zoneinfo/${TZ} \
    && apk del .apt-deps && tar -C / -xf tz.tar && rm -f tz.tar

ONBUILD ARG JAR_FILE=target/app.jar
ONBUILD ARG BUILD_GIT_HEAD
ONBUILD ENV BUILD_GIT_HEAD ${BUILD_GIT_HEAD}
ONBUILD COPY ${JAR_FILE} /app.jar

ENTRYPOINT [ "/start.sh" ]

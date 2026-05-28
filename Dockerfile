FROM alpine:3.23

ENV LANG=zh_CN.UTF-8 \
    TZ=Asia/Shanghai \
    PUID=1000 \
    PGID=1000 \
    PS1="\[\e[32m\][\[\e[m\]\[\e[36m\]\u \[\e[m\]\[\e[37m\]@ \[\e[m\]\[\e[34m\]\h\[\e[m\]\[\e[32m\]]\[\e[m\] \[\e[37;35m\]in\[\e[m\] \[\e[33m\]\w\[\e[m\] \[\e[32m\][\[\e[m\]\[\e[37m\]\d\[\e[m\] \[\e[m\]\[\e[37m\]\t\[\e[m\]\[\e[32m\]]\[\e[m\] \n\[\e[1;31m\]$ \[\e[0m\]"

RUN echo "https://dl-cdn.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories \
    && apk add --no-cache --update \
    acme.sh \
    curl \
    fontconfig \
    net-tools \
    nginx=1.30.1-r0 \
    nginx-mod-stream=1.30.1-r0 \
    nginx-mod-stream-geoip=1.30.1-r0 \
    nginx-mod-stream-geoip2=1.30.1-r0 \
    nginx-mod-stream-js=1.30.1-r0 \
    nginx-mod-stream-keyval=1.30.1-r0 \
    nginx-mod-http-headers-more=1.30.1-r0 \
    nginx-mod-http-js=1.30.1-r0 \
    nginx-mod-http-keyval=1.30.1-r0 \
    nginx-mod-http-lua=1.30.1-r0 \
    nginx-mod-http-brotli=1.30.1-r0 \
    nginx-mod-rtmp=1.30.1-r0 \
    nginx-mod-mail=1.30.1-r0 \
    nginx-mod-http-geoip=1.30.1-r0 \
    nginx-mod-http-geoip2=1.30.1-r0 \
    nginx-mod-http-zip=1.30.1-r0 \
    nginx-mod-http-zstd=1.30.1-r0 \
    nginx-mod-http-perl=1.30.1-r0 \
    nginx-mod-http-upload=1.30.1-r0 \
    nginx-mod-http-upload-progress=1.30.1-r0 \
    nginx-mod-http-upstream-fair=1.30.1-r0 \
    nginx-mod-http-echo=1.30.1-r0 \
    nginx-mod-http-cache-purge=1.30.1-r0 \
    nginx-mod-dynamic-upstream=1.30.1-r0 \
    nginx-mod-dynamic-healthcheck=1.30.1-r0 \
    openjdk8-jre \
    shadow \
    su-exec \
    logrotate \
    dumb-init \
    ttf-dejavu \
    tzdata \
    wget \
    bash \
    && fc-cache -f -v \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo "${TZ}" > /etc/timezone \
    && nginx -V \
    && rm -rf /var/cache/apk/* /tmp/*

COPY --chmod=755 entrypoint.sh /usr/local/bin/entrypoint.sh
COPY --chmod=755 src/target/nginxWebUI-*.jar /home/nginxWebUI.jar

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]

VOLUME ["/home/nginxWebUI"]

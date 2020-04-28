FROM alpine:latest as base

RUN apk update && apk add --no-cache --virtual .build-deps ca-certificates curl \
 && curl -L -H "Cache-Control: no-cache" -o /v2ray.zip https://github.com/v2ray/v2ray-core/releases/latest/download/v2ray-linux-64.zip \
 && mkdir /usr/bin/v2ray /etc/v2ray /ws \
 && touch /etc/v2ray/config.json \
 && unzip /v2ray.zip -d /usr/bin/v2ray \
 && rm -rf /v2ray.zip /usr/bin/v2ray/*.sig /usr/bin/v2ray/doc /usr/bin/v2ray/*.json /usr/bin/v2ray/*.dat /usr/bin/v2ray/sys* \
 && chgrp -R 0 /etc/v2ray \
 && chmod -R g+rwX /etc/v2ray
ADD startup.sh /startup.sh
RUN chmod +x /startup.sh

###############################################################
FROM base as prod

ENV OTPORT=8080 && \
    UUID=king0987-3def-8656-90ab-0987xy8521f9
    
ADD config.json /etc/v2ray/config.json

EXPOSE 8080
ENTRYPOINT ["sh", "/startup.sh"]

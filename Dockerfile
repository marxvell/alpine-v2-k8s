FROM kingma/alpine-v2-k8s:base

ENV OTPORT=8080
ENV UUID=none
ADD config.json /etc/v2ray/config.json

EXPOSE 8080
ENTRYPOINT ["sh", "/startup.sh"]

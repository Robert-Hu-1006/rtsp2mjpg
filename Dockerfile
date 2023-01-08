FROM alpine:3.8
RUN apk add curl bash ffmpeg && \
    rm -rf /var/cache/apk/*
COPY stream.sh /usr/bin/stream.sh
RUN chmod +x /usr/bin/stream.sh
COPY ./ffserver.conf /etc/ffserver.conf

ENTRYPOINT stream.sh
FROM alpine:3.9

ENV \
    TERM=xterm-color       \
    TIME_ZONE=Europe/Minsk \
    EMAIL=hello@world.com \
    HOSTNAME=www.example.com

COPY ./init.sh /

RUN \
    chmod +x /init.sh && \
    apk add --no-cache --update ca-certificates \
    dumb-init\
    tzdata \
    curl \
    httpie \
    bash \
    git \
    htop \
    vim \
    tmux \
    python3 && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --upgrade pip setuptools && \
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \
    if [[ ! -e /usr/bin/python ]]; then ln -sf /usr/bin/python3 /usr/bin/python; fi && \
    mkdir -p /home/docker/code && \
    cp /usr/share/zoneinfo/${TIME_ZONE} /etc/localtime && \
    echo "${TIME_ZONE}" > /etc/timezone && \
    ln -s /usr/bin/dumb-init /sbin/dinit && \
    rm -rf /var/cache/apk/* /root/.cache

ENTRYPOINT ["/init.sh"]

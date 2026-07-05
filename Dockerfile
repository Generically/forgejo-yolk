# ----------------------------------
# Pelican Panel Dockerfile
# ----------------------------------

FROM        --platform=$TARGETOS/$TARGETARCH codeberg.org/forgejo/forgejo:15

LABEL       org.opencontainers.image.authors=“lorcster222@gmail.com” \
            org.opencontainers.image.source=“” \
            org.opencontainers.image.licenses= \
            org.opencontainers.image.description=“Custom Yolk for Pelican Hosting Panel”

RUN         apt update -y \
            && apt install -y \
                tini 

## Setup user and working directory
RUN         useradd -m -d /home/container -s /bin/bash container
USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

STOPSIGNAL SIGINT

COPY        --chown=container:container ./entrypoint.sh /entrypoint.sh
RUN         chmod +x /entrypoint.sh
ENTRYPOINT    ["/usr/bin/tini", "-g", "--"]
CMD         ["/entrypoint.sh"]

# ----------------------------------
# Pelican Panel Dockerfile
# ----------------------------------

FROM        codeberg.org/forgejo/forgejo:15

LABEL       org.opencontainers.image.authors=“lorcster222@gmail.com”

# Setup user and working directory
RUN         adduser -D -h /home/container -s /bin/bash container
USER        container
ENV         USER=container HOME=/home/container

WORKDIR     /home/container

STOPSIGNAL SIGINT

COPY        --chown=container:container ./entrypoint.sh /entrypoint.sh
COPY        --chown=container:container ./tini /tini
COPY        --chown=container:container ./app.ini /data/gitea/conf/app.ini

RUN         chmod +x /entrypoint.sh
RUN         chmod +x /tini

ENTRYPOINT    ["/tini", "-g", "--"]
CMD         ["/entrypoint.sh"]

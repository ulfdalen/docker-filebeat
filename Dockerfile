FROM    alpine:latest

# Build variables
ENV     FILEBEAT_VERSION 5.2.1
ENV     FILEBEAT_URL https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-${FILEBEAT_VERSION}-linux-x86_64.tar.gz

# Environment variables
ENV     FILEBEAT_HOME /opt/filebeat-${FILEBEAT_VERSION}-linux-x86_64
ENV     PATH $PATH:${FILEBEAT_HOME}

WORKDIR /opt/

RUN     apk add --update curl && \
        rm -rf /var/cache/apk/*

RUN     curl -sL ${FILEBEAT_URL} | tar xz -C . && ln -s ${FILEBEAT_HOME} /opt/filebeat

COPY    filebeat.yml /opt/
COPY    docker-entrypoint.sh    /docker-entrypoint.sh

ENTRYPOINT  ["/docker-entrypoint.sh"]
CMD ["filebeat", "-c", "/opt/filebeat.yml", "-path.home", "/opt/filebeat"]

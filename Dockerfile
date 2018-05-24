FROM java:9-jre
MAINTAINER Michael Ferguson <mpherg@gmail.com>

ENV BLYNK_SERVER_VERSION 0.36.4
RUN mkdir /blynk
RUN curl -L https://github.com/blynkkk/blynk-server/releases/download/v${BLYNK_SERVER_VERSION}/server-${BLYNK_SERVER_VERSION}-java8.jar > /blynk/server.jar

# Create data folder. To persist data, map a volume to /data
RUN mkdir /data

# Create configuration folder. To persist data, map a file to /config/server.properties
RUN mkdir /config && touch /config/server.properties
VOLUME ["/config", "/data/backup"]

# IP port listing:
# 8080: Hardware without ssl/tls support
# 8441: Hardware ssl/tls port (for hardware that supports SSL/TLS sockets)
# 9443: Blynk app, https, web sockets, admin port
EXPOSE 8080 8441 9443

WORKDIR /data
ENTRYPOINT ["java", "-jar", "/blynk/server.jar", "-dataFolder", "/data", "-serverConfig", "/config/server.properties"]

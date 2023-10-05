FROM openjdk:11-jre
MAINTAINER Michael Ferguson <mpherg@gmail.com>

RUN mkdir /blynk
RUN curl -L https://github.com/prodisz/blynk-server/raw/ba990a6c0d7c5e21f854047f97268f33cb9a2ead/server-0.41.17.jar > /blynk/server.jar

# Create data folder. To persist data, map a volume to /data
RUN mkdir /data

# Create configuration folder. To persist data, map a file to /config/server.properties
RUN mkdir /config && touch /config/server.properties
VOLUME ["/config", "/data/backup"]

# IP port listing:
# 8080: Hardware without ssl/tls support
# 9443: Blynk app, https, web sockets, admin port
EXPOSE 8080 9443

WORKDIR /data
ENTRYPOINT ["java", "-jar", "/blynk/server.jar", "-dataFolder", "/data", "-serverConfig", "/config/server.properties"]

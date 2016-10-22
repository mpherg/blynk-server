FROM java:8-jre
MAINTAINER Michael Ferguson <mpherg@gmail.com>

ENV BLYNK_SERVER_VERSION 0.19.0
RUN mkdir /blynk
RUN curl -L https://github.com/blynkkk/blynk-server/releases/download/v${BLYNK_SERVER_VERSION}/server-${BLYNK_SERVER_VERSION}.jar > /blynk/server.jar

# Create data folder. To persist data, map a volume to /data
RUN mkdir /data
# Place symbolic link to server config file so that this can be persisted in /data
RUN ln -s /data/server.properties /blynk/server.properties

# IP port listing:
# 8443: Application mutual ssl/tls port
# 8442: Hardware plain tcp/ip port
# 8441: Hardware ssl/tls port (for hardware that supports SSL/TLS sockets)
# 8081: Web socket ssl/tls port
# 8082: Web sockets plain tcp/ip port
# 9443: HTTPS port
# 8080: HTTP port
# 7443: Administration UI HTTPS port
EXPOSE 7443 8080 8081 8082 8441 8442 8443 9443
WORKDIR /data
ENTRYPOINT ["java", "-jar", "/blynk/server.jar", "-dataFolder", "/data"]

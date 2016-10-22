FROM java:8-jre
MAINTAINER Michael Ferguson <mpherg@gmail.com>

ENV BLYNK_SERVER_VERSION 0.19.0
RUN mkdir /blynk
RUN curl -L https://github.com/blynkkk/blynk-server/releases/download/v${BLYNK_SERVER_VERSION}/server-${BLYNK_SERVER_VERSION}.jar > /blynk/server.jar

# Create data folder. To persist data, map a volume to /data
RUN mkdir /data
# Place symbolic link to server config file so that this can be persisted in /data
RUN ln -s /data/server.properties /blynk/server.properties

# By default, mobile application uses port 8443 and is based on SSL/TLS
# sockets. Default hardware port is 8442 and is based on plain TCP/IP
# sockets.
# Blynk server also has administration panel where you could monitor your 
# server. It could be accessible with URL https://your_ip:7443/admin
EXPOSE 7443 8442 8443
WORKDIR /data
ENTRYPOINT ["java", "-jar", "/blynk/server.jar", "-dataFolder", "/data"]

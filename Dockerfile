FROM java:8-jre
MAINTAINER Michael Ferguson <mpherg@gmail.com>

ENV BLYNK_SERVER_VERSION 0.11.0
RUN mkdir /data
RUN curl -L https://github.com/blynkkk/blynk-server/releases/download/v${BLYNK_SERVER_VERSION}/server-${BLYNK_SERVER_VERSION}.jar > /data/server.jar

# By default, mobile application uses port 8443 and is based on SSL/TLS
# sockets. Default hardware port is 8442 and is based on plain TCP/IP
# sockets.
EXPOSE 8442 8443
WORKDIR /data
ENTRYPOINT ["java", "-jar", "server.jar"]

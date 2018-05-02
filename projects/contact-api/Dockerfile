FROM openjdk:8-jdk-alpine
VOLUME /tmp
ADD target/contact-api.war app.jar
EXPOSE 8090
EXPOSE 8091
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app.jar"]
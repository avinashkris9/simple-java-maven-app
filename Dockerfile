FROM openjdk:8

WORKDIR /usr/src/myapp
COPY target/my-app-1.0-SNAPSHOT.jar /usr/src/my-app.jar


ENTRYPOINT ["java", "-jar", "/usr/src/my-app.jar" ]
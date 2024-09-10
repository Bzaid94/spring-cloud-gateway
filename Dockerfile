#
# Build stage
#
FROM maven:3.9.9-eclipse-temurin-22-alpine AS build
WORKDIR /home/app
COPY pom.xml /home/app
RUN mvn dependency:resolve
COPY src /home/app/src
RUN mvn clean package -DskipTests

#
# Package stage
#
FROM eclipse-temurin:22-jdk-alpine
VOLUME /tmp
COPY --from=build /home/app/target/cloud-gateway-service-1.0.0.jar /usr/local/lib/cloud-gateway-service.jar

EXPOSE 8888
ENTRYPOINT ["java","-jar","/usr/local/lib/cloud-gateway-service.jar"]
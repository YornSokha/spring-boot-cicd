## Use a base image with Java and Gradle installed
FROM maven:latest as builder
#
## Set the working directory
WORKDIR /app
#
## Copy the project files to the container
COPY . .
#
## Build the project using Gradle
RUN mvn clean install

# Use a new image without any build tools
FROM openjdk:17-jdk
LABEL authors="sokha"
MAINTAINER sokhayorn.com

# Set the working directory
WORKDIR /app

# Copy the built JAR file from the builder image
COPY --from=builder /app/target/spring-boot-cicd-0.0.1-SNAPSHOT.jar .

# Start the application
CMD ["java", "-jar", "spring-boot-cicd-0.0.1-SNAPSHOT.jar"]


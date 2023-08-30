# Use Ubuntu as the base image
FROM ubuntu:latest

# Install Java Development Kit (JDK) and Maven
RUN apt-get update
RUN apt-get install -y openjdk-17-jdk maven

# Set the working directory
WORKDIR /app

# Copy the project files to the container
COPY . .

# Build the project using Maven
RUN mvn clean install

# Use a new image without any build tools
FROM openjdk:17-jdk
FROM maven:latest as builder
LABEL authors="sokha"
MAINTAINER sokhayorn.com

# Set the working directory
WORKDIR /app

# Copy the built JAR file from the builder image
COPY --from=builder /app/target/spring-boot-cicd-0.0.1-SNAPSHOT.jar .

# Start the application
CMD ["java", "-jar", "spring-boot-cicd-0.0.1-SNAPSHOT.jar"]

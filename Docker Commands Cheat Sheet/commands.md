# Docker

Sample Docker file

```
#############################################
# Stage 1: Build the application
#############################################
FROM maven:3.9.6-eclipse-temurin-17 AS build

# Build arguments (passed during docker build)
ARG APP_VERSION=1.0.0
ARG BUILD_PROFILE=prod

# Labels for enterprise metadata
LABEL app.version="${APP_VERSION}" \
      maintainer="devops-team@example.com"

# Set working directory
WORKDIR /app

# Copy only dependency files first (faster caching)
COPY pom.xml .
RUN mvn -B dependency:go-offline

# Copy source code
COPY src ./src

# Package the application
RUN mvn -B clean package -P${BUILD_PROFILE} -DskipTests

#############################################
# Stage 2: Runtime image
#############################################
FROM eclipse-temurin:17-jre-alpine AS runtime

# Security hardening
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Application arguments with defaults
ARG APP_HOME=/opt/app
ARG JAR_NAME=myapp.jar

# Environment variables (override during deployment)
ENV APP_ENV=production \
    JAVA_OPTS="-Xms512m -Xmx1024m -XX:+UseContainerSupport" \
    LOG_LEVEL=INFO \
    TZ=UTC

# Create app directory
WORKDIR ${APP_HOME}

# Copy the JAR from the build stage
COPY --from=build /app/target/*.jar ${APP_HOME}/${JAR_NAME}

# Expose the application port
EXPOSE 8080

# Change permissions
RUN chown -R appuser:appgroup ${APP_HOME}

USER appuser

# Healthcheck (optional but recommended)
HEALTHCHECK --interval=30s --timeout=5s --start-period=15s --retries=3 \
  CMD wget -qO- http://localhost:8080/actuator/health || exit 1

# Entry point
ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -jar ${JAR_NAME}"]

```
The difference between CMD and ENTRYPOINT in a Dockerfile,
_ENTRYPOINT_:Defines the main executable of the container.
It always runs, unless overridden with --entrypoint.

_CMD_:Defines default arguments passed to the entrypoint OR
a default command if no ENTRYPOINT is provided.

## Docker Commands Cheat Sheet

| Commands |  Descriptions  |
|:-----|:--------:|
|docker build -t <image_name> .| Build an Image from a Dockerfile |
|docker build -t <image_name> . –no-cache | Build an Image from a Dockerfile without the cache |
|docker images | List local images |
|docker rmi <image_name>  | Delete an Image |
| docker image prune | Remove all unused images|
| docker login -u <username> | Login into Docker |
| docker push <username>/<image_name> | Publish an image to Docker Hub |
|docker search <image_name> | Search Hub for an image |
|docker pull <image_name> | Pull an image from a Docker Hub |
|docker -d | Start the docker daemon |
|docker --help | Get help with Docker. Can also use –help on all subcommands |
|docker info | Display system-wide information |
|docker run --name <container_name> <image_name> | Create and run a container from an image, with a custom name: |
|docker run -p <host_port>:<container_port> <image_name> | Run a container with and publish a container’s port(s) to the host.|
|docker run -d <image_name> | Run a container in the background |
|docker start|stop <container_name> (or <container-id>) | Start or stop an existing container: |
| docker rm <container_name> | Remove a stopped container: |
| docker exec -it <container_name> sh | Open a shell inside a running container: |
| docker logs -f <container_name> | Fetch and follow the logs of a container: |
|docker inspect <container_name> (or <container_id>) | To inspect a running container: |
| docker ps | To list currently running containers:|
| docker ps --all | List all docker containers (running and stopped): |
|docker container stats | View resource usage stats|

## Docker file Commands

| Commands |  Descriptions  | Example |
|:-----|:--------:|:--------:|
| FROM |Specifies the base image for the build | FROM ubuntu:latest |
|RUN | Executes a command inside the container during build time | RUN apt-get update && apt-get install -y curl |
|CMD | Specifies the default command to run when the container starts | CMD ["npm", "start"]|
|EXPOSE | Informs Docker that the container listens on specific network ports at runtime | EXPOSE 80/tcp |
| ENV | Sets environment variables inside the container | ENV NODE_ENV=production |
|COPY | Copies files or directories from the build context into the container | COPY app.js /usr/src/app/|
|ADD | Similar to COPY but supports additional features like URL retrieval and decompression | ADD https://example.com/file.tar.gz /usr/src/|
|WORKDIR | Sets the working directory for subsequent instructions | WORKDIR /usr/src/app |
|ARG | Defines variables that users can pass at build-time to the builder with the docker build command | ARG VERSION=1.0 |
|ENTRYPOINT | Configures a container to run as an executable | ENTRYPOINT ["python", "app.py"] |
|VOLUME | Creates a mount point and assigns it to a specified volume | VOLUME /data|
|USER | Sets the user or UID to use when running the image | USER appuser |
|LABEL | Adds metadata to an image in the form of key-value pairs | LABEL version="1.0" maintainer="John Doe |
| ONBUILD | Configures commands to run when the image is used as the base for another build | ONBUILD ADD . /app/src |
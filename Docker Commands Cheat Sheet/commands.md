# Docker

Docker is an open platform for developing, shipping and running applications.

## Containers
Containers are isolated processes for each of the app's components. Each component - the frontend React app, the Python API engine, and the database - runs in its own isolated environment, completely isolated from everything else on your machine.

## Containers VS Virtual Machines.
VMs is an operating system with it's own kernel, hardware devices, applications, and programs.
Container is isolated process with all files it needs to run. 

## Image
A container image is a standardized package that includes all of the files, binaries, libraries, and configurations to run a container. Container images are composed of layers. Each layer represents a set of file system changes that add, remove, or modify files.

## Registry
An image registry is a centralized location for storing and sharing your container images. It can be either public (Docker hub) or private (Amazon Elastic container registry - ECR, Azure container registry - ACR, Google container registry - GCR).

## Registry vs. repository
A _registry_ is a centralized location that stores and manages container images, whereas a _repository_ is a collection of related container images within a registry. Think of it as a folder where you organize your images based on projects.

## Docker Compose 

Docker compose is a tool that lets you define and run multi-container applications using Docker, in a simple and repeatable way.

Instead of starting containers one by one with long docker run commands, you describe everything in a YAML file and start it with one command docker compose up.

## Dockerfile versus Compose file
A Dockerfile provides instructions to build a container image while a Compose file defines your running containers. Quite often, a Compose file references a Dockerfile to build an image to use for a particular service.

Different waye

```
version: "3"
services:
  web:
    image: "nginx:latest"
    ports:
      - "8080:80"
    restart: always
  web2:
    image: "nginx:latest"
    ports:
      - "8082:80"
    restart: always
networks:
  coffee:
    ipam:
      driver: default
      config:
        - subnet: "192.168.92.0/24"
```
 ```
version: "3.8"
services:
  wordpress:
    image: wordpress
    ports:
      - "8089:80"
    depends_on:
      - mysql
    environment:
      WORDPRESS_DB_HOST: mysql
      WORDPRESS_DB_USER: root
      WORDPRESS_DB_PASSWORD: "coffee"
      WORDPRESS_DB_NAME: wordpress
  mysql:
      image: mysql:5.7
      environment:
        MYSQL_ROOT_PASSWORD: "coffee"
        MYSQL_DATABASE: wordpress
      volumes:
        - db_data:/var/lib/mysql
networks:
  wnet:
    ipam:
      driver: default
      config:
        - subnet: "192.268.100.1/24"
```
etc

## Image Layers
Each layer in an image contains a set of filesystem changes - additions, deletions, or modifications.

| No | Layer | Description |
|----|-------|-------------|
| 1  | App Source | 1st layer adds basic commands and package manager |
| 2  | App dependencies | 2nd layer installs dependencies for management |
| 3  | App requirements  | 3rd layer copies in an application's specificrequirements |
| 4 | Python and pip | 4th layer installs the application specific dependencies |
| 5 | Debian base | 5th layer copies in the actual source code of the application |

```
FROM python:3.13
WORKDIR /usr/local/app

# Install the application dependencies
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# Copy in the source code
COPY src ./src
EXPOSE 8080

# Setup an app user so the container doesn't run as the root user
RUN useradd app
USER app

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8080"]
```

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
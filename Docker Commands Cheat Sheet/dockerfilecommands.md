# Docker file Commands

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
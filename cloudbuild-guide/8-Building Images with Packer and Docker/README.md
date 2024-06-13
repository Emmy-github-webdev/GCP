# Building Images with Packer and Docker

This chapter focuses on using Packer and Docker within Google Cloud Build pipelines to create consistent and reproducible images for both virtual machines and containers. Building images with Packer and Docker facilitates the deployment of applications across various environments, ensuring that your infrastructure is provisioned in a reliable and automated manner.

### Building Docker Images

Docker is a set of platform-as-a-service (PaaS) products that use OS-level virtualization to deliver software in packages called containers. Containers are isolated from one another and bundle their own software, libraries, and configuration files.

### Integrating Docker Builds into Cloud Build

1. **Define a Dockerfile:** The first step is to create a `Dockerfile` in your project’s root directory. This file contains all the commands a user could call on the command line to assemble an image.

2. **Use Cloud Build to Build and Push Docker Images:**

— Configure your `cloudbuild.yaml` to build the Docker image using the `docker` build step and then push the image to Google Container Registry (GCR) or Google Artifact Registry.

**Example `cloudbuild.yaml` for building and pushing a Docker image:**

```
steps:
  - name: 'gcr.io/cloud-builders/docker'
    args: ['build', '-t', 'gcr.io/$PROJECT_ID/my-app:$SHORT_SHA', '.']
    id: 'build'

  - name: 'gcr.io/cloud-builders/docker'
    args: ['push', 'gcr.io/$PROJECT_ID/my-app:$SHORT_SHA']
    id: 'push'
```
This configuration builds a Docker image from the Dockerfile in the current directory and pushes it to GCR.

### Building Images with Packer
Packer is an open-source tool for creating identical machine images for multiple platforms from a single source configuration. Packer can be used to pre-bake images with all your applications and configurations, making deployments faster and more consistent.

Integrating Packer Builds into Cloud Build
1. **Create a Packer Template:** Define a Packer template (`template.json`) that specifies how the VM images should be built. The template includes builders, provisioners, and post-processors.

2. **Use Cloud Build to Execute Packer Builds:**

— Configure your `cloudbuild.yaml` to execute Packer, building the image according to your template and uploading it to Google Compute Engine (GCE).

**Example `cloudbuild.yaml` for executing a Packer build:**

```
steps:
  - name: 'gcr.io/$PROJECT_ID/packer'
    args: ['build', 'template.json']
    id: 'packer-build'
```

This assumes you have a custom builder image for Packer (`gcr.io/$PROJECT_ID/packer`) that is capable of executing Packer commands.
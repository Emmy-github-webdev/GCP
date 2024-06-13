# Deploying Applications

Deploying applications efficiently and reliably to various Google Cloud Platform (GCP) services is a critical aspect of the CI/CD pipeline. This chapter focuses on how to use Google Cloud Build to deploy applications to Google Kubernetes Engine (GKE), Google Cloud Functions, Cloud Run, and App Engine, highlighting best practices and providing example configurations.

### Deploying to Google Kubernetes Engine (GKE)

Google Kubernetes Engine (GKE) offers a managed environment for deploying, managing, and scaling your containerized applications using Google infrastructure. To deploy applications to GKE using Cloud Build, follow these steps:

1. **Build Container Image:** Use Cloud Build to build your Docker container image.

2. **Push Image to Container Registry:** Push the built image to Google Container Registry (GCR) or Google Artifact Registry.

3. **Update Kubernetes Deployment:** Use `kubectl` to update your GKE deployment with the new image.

**Example `cloudbuild.yaml`:**

```
steps:
  - name: 'gcr.io/cloud-builders/docker'
    args: ['build', '-t', 'gcr.io/$PROJECT_ID/my-app:$SHORT_SHA', '.']
    id: 'build'

  - name: 'gcr.io/cloud-builders/docker'
    args: ['push', 'gcr.io/$PROJECT_ID/my-app:$SHORT_SHA']
    id: 'push'

  - name: 'gcr.io/cloud-builders/kubectl'
    args: ['set', 'image', 'deployment/my-deployment', 'my-container=gcr.io/$PROJECT_ID/my-app:$SHORT_SHA']
    env:
      - 'CLOUDSDK_COMPUTE_ZONE=your-zone'
      - 'CLOUDSDK_CONTAINER_CLUSTER=your-cluster'
    id: 'deploy'
```

### Deploying to Google Cloud Functions
Google Cloud Functions is a serverless execution environment for building and connecting cloud services. With Cloud Build, you can automatically deploy code to Cloud Functions upon changes.

**Example `cloudbuild.yaml`:**

```
steps:
  - name: 'gcr.io/cloud-builders/gcloud'
    args: ['functions', 'deploy', 'my-function', '--trigger-http', '--runtime', 'nodejs10', '--source', '.']
```

### Deploying to Cloud Run

Cloud Run is a managed compute platform that automatically scales your stateless containers. Cloud Build can build your container images and deploy them to Cloud Run.

**Example `cloudbuild.yaml`:**

```
steps:
  - name: 'gcr.io/cloud-builders/docker'
    args: ['build', '-t', 'gcr.io/$PROJECT_ID/my-service', '.']
    id: 'build'

  - name: 'gcr.io/cloud-builders/gcloud'
    args: ['run', 'deploy', 'my-service', '--image', 'gcr.io/$PROJECT_ID/my-service', '--platform', 'managed']
    id: 'deploy'
```

### Deploying to App Engine
App Engine allows you to build highly scalable applications on a fully managed serverless platform. Deploying an App Engine application with Cloud Build is straightforward.

**Example `cloudbuild.yaml`:**

```
steps:
  - name: 'gcr.io/cloud-builders/gcloud'
    args: ['app', 'deploy']
```
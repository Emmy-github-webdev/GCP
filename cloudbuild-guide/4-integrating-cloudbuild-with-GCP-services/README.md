# Integrating Cloud Build with GCP Services

Integrating Google Cloud Build with other Google Cloud Platform (GCP) services enhances your CI/CD pipelines, enabling seamless deployment, efficient resource management, and comprehensive monitoring. This chapter focuses on leveraging these integrations to streamline your development workflows.

### Cloud Storage

Cloud Storage can be used to store build artifacts, logs, or any files generated during the build process. This integration is particularly useful for archiving build outputs and sharing resources across your GCP environment.

- Storing Build Artifacts: Specify Cloud Storage as the destination for your build artifacts in the `cloudbuild.yaml` file.

**Example:**

```

artifacts:
  objects:
    location: 'gs://my-artifacts-bucket/'
    paths:
      - 'path/to/artifacts/**

```
### Cloud Functions

Deploying Cloud Functions directly from Cloud Build enables automated updates of serverless applications in response to code changes. Use the `gcloud functions deploy` command within a Cloud Build step to deploy functions.

**Example:**

```
steps:
  - name: 'gcr.io/cloud-builders/gcloud'
    args: ['functions', 'deploy', 'my-function', '--trigger-http', '--runtime', 'nodejs10', '--source', '.']
```

### Google Kubernetes Engine (GKE)
Deploying applications to GKE from Cloud Build simplifies the delivery of containerized applications. After building your Docker images, you can use `kubectl` or Helm to deploy them to your GKE clusters.

**Example:**

```
steps:
  - name: 'gcr.io/cloud-builders/docker'
    args: ['build', '-t', 'gcr.io/$PROJECT_ID/my-app:$SHORT_SHA', '.']

  - name: 'gcr.io/cloud-builders/kubectl'
    args: ['set', 'image', 'deployment/my-app', 'my-app=gcr.io/$PROJECT_ID/my-app:$SHORT_SHA', '--namespace', 'default']
    env:
      - 'CLOUDSDK_COMPUTE_ZONE=us-central1-a'
      - 'CLOUDSDK_CONTAINER_CLUSTER=my-cluster'
```

### Cloud Run
Cloud Run allows you to deploy containerized applications on a fully managed platform. Cloud Build can build your container images and deploy them to Cloud Run with minimal configuration.

**Example:**

```
steps:
  - name: 'gcr.io/cloud-builders/gcloud'
    args: ['builds', 'submit', '--tag', 'gcr.io/$PROJECT_ID/my-service']
  
  - name: 'gcr.io/cloud-builders/gcloud'
    args: ['run', 'deploy', 'my-service', '--image', 'gcr.io/$PROJECT_ID/my-service', '--platform', 'managed', '--region', 'us-central']
```

### App Engine
For App Engine deployments, Cloud Build can automate the deployment process, ensuring your applications are updated with every code change.

**Example:**

```
steps:
  - name: 'gcr.io/cloud-builders/gcloud'
    args: ['app', 'deploy']
```

### Artifact Registry
Cloud Build can push built images or artifacts to the Artifact Registry, providing a secure, scalable repository for your software packages.

**Example:**

```
steps:
  - name: 'gcr.io/cloud-builders/docker'
    args: ['build', '-t', 'us-central1-docker.pkg.dev/$PROJECT_ID/my-repo/my-image:latest', '.']
  
  - name: 'gcr.io/cloud-builders/docker'
    args: ['push', 'us-central1-docker.pkg.dev/$PROJECT_ID/my-repo/my-image:latest']
```

### Best Practices for Integration

- **Use IAM Roles and Permissions:** Ensure Cloud Build has the appropriate IAM roles to interact with other GCP services.
- **Secure Secrets:** Utilize Secret Manager to securely manage and access secrets needed for deploying to GCP services.
- **Monitor Builds:** Leverage Cloud Monitoring and Cloud Logging to keep track of your builds and deployments, identifying issues early.
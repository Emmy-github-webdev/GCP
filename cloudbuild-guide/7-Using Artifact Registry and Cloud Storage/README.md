# Using Artifact Registry and Cloud Storage

Let's delve into how Google Cloud Build can be integrated with Google Artifact Registry and Google Cloud Storage to manage artifacts produced during the build process. These services offer secure and scalable options for storing build outputs, such as Docker images, application binaries, and other build artifacts, facilitating their reuse and deployment across your CI/CD pipelines.

### Google Artifact Registry

Google Artifact Registry provides a single place for your team to manage Docker images, language packages (such as Maven and npm), and other artifacts needed for your applications. Integrating Cloud Build with Artifact Registry allows you to automatically push your build artifacts to a secure repository.

### Setting Up Artifact Registry
1. **Create an Artifact Registry Repository:** First, create a Docker repository in Artifact Registry to store your Docker images.

```
gcloud artifacts repositories create my-repo --repository-format=docker \
--location=us-central1 --description="Docker repository"
```

2. **Configure Cloud Build to Push Images:** In your `cloudbuild.yaml`, add steps to build your Docker image and push it to the Artifact Registry repository.

**Example `cloudbuild.yaml`:**

```
steps:
  - name: 'gcr.io/cloud-builders/docker'
    args: ['build', '-t', 'us-central1-docker.pkg.dev/$PROJECT_ID/my-repo/my-app:$SHORT_SHA', '.']
    id: 'build'

  - name: 'gcr.io/cloud-builders/docker'
    args: ['push', 'us-central1-docker.pkg.dev/$PROJECT_ID/my-repo/my-app:$SHORT_SHA']
    id: 'push'
```

This configuration builds a Docker image and pushes it to the specified repository in Artifact Registry.

### Google Cloud Storage

Google Cloud Storage is a powerful and versatile object storage service that can be used to store any type of data. It’s particularly useful for storing large build artifacts, such as binaries, libraries, or any files generated during the build process.

### Utilizing Cloud Storage in Cloud Build
1. **Store Build Artifacts:** You can configure Cloud Build to upload artifacts directly to a Cloud Storage bucket as part of your build process.

**Example `cloudbuild.yaml`:**

```
steps:
  # Your build steps here

# Store artifacts in Cloud Storage
artifacts:
  objects:
    location: 'gs://my-bucket-name/'
    paths:
      - 'path/to/artifacts/**'
```


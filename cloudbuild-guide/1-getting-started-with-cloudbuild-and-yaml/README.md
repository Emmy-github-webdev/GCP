# Getting Started with Cloud Build and YAML

1. **Enable Cloud Build in GCP:** Before you can start using Cloud Build, you need to enable it in your GCP project.

2. **Create a _cloudbuild.yaml_ file:** This YAML file contains the configuration for your build. You define the steps Cloud Build should execute, along with any necessary environment variables, artifacts, and other configurations.

<br>

**Example `cloudbuild.yaml`:**
```
steps:
  - name: 'gcr.io/cloud-builders/gcloud'
    args: ['builds', 'submit', '--tag', 'gcr.io/$PROJECT_ID/hello-world']
    id: 'build-and-push-docker-image'
images:
  - 'gcr.io/$PROJECT_ID/hello-world'
timeout: '1200s'

```

This simple example defines a single step that uses the `gcloud` builder to build and push a Docker image to Google Container Registry.

3. **Submit a Build:** With your `cloudbuild.yaml` file in place, you can submit a build to Cloud Build using the Google Cloud SDK or the GCP Console.

```
gcloud builds submit --config cloudbuild.yaml .

```

This command submits your build to Cloud Build, specifying the configuration file and the current directory as the source code location.
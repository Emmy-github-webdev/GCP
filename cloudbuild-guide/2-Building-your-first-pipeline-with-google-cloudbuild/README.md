# Building Your First Pipeline with Google Cloud Build

1. **Preparing your source code:** Before you can build a pipeline, you need a project to build. Your project should be stored in a source code repository that Cloud Build can access, such as Cloud Source Repositories, GitHub, or Bitbucket.

- Organize Your Project: Ensure your project’s structure is clear and your source code is ready for building. For example, if you’re working with a Node.js application, ensure your `package.json` and any necessary build scripts are in place.

2. **Creating a `cloudbuild.yaml` Configuration:** The `cloudbuild.yaml` file is where you define the steps of your build pipeline. Each step in the build can execute a specific task, like installing dependencies, running tests, or deploying your application.

- Define Build Steps: Specify each action Cloud Build should take. Steps are executed in the order they appear in the file.

<br>

**Example `cloudbuild.yaml` for a Node.js application:**

```
steps:
  # Install dependencies
  - name: 'gcr.io/cloud-builders/npm'
    args: ['install']

  # Run tests
  - name: 'gcr.io/cloud-builders/npm'
    args: ['test']

  # Build the application
  - name: 'gcr.io/cloud-builders/npm'
    args: ['run', 'build']

# Specify the images to be pushed to the Container Registry
images:
  - 'gcr.io/$PROJECT_ID/my-app:latest'

# Optional: Define a timeout for the build
timeout: '1600s'

```

This example defines three steps for a Node.js application: installing dependencies, running tests, and building the application. The `images` section specifies that the built application image should be pushed to the Container Registry.

3. **Triggering the Build:** You can trigger builds in Cloud Build manually, by pushing code to your repository, or through the GCP Console.

- **Manual Trigger via Command Line:**

```
gcloud builds submit --config cloudbuild.yaml
```

This command submits your source code and the `cloudbuild.yaml` file to Cloud Build for processing.

- **Automated Triggers:** Set up automated triggers in Cloud Build to start builds on events like code commits or pull requests. This is done through the GCP Console under Cloud Build > Triggers.

4. **Monitoring Build Progress:** Once you’ve triggered a build, you can monitor its progress in the GCP Console. Cloud Build provides detailed logs for each step of the build process, allowing you to diagnose and fix any issues that arise.

### Best Practices

- **Granular Steps:** Keep your steps small and focused. Each step should perform a single task, making your build process easier to understand and debug.
- **Build Optimizations:** Use caching to speed up build times, especially for steps that download dependencies or use Docker layers.
- **Security:** Use Secret Manager for sensitive data and ensure your build environment is secure, especially when deploying to production.
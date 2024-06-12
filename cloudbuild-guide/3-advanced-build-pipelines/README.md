# Advanced Build Pipelines

After mastering the basics of Google Cloud Build, you can leverage its advanced features to create more sophisticated and efficient CI/CD pipelines. This chapter explores conditional executions, parallel and serial step execution, managing artifacts, and optimizing build times.

<br>

### Conditional Executions

Cloud Build supports conditional executions, allowing steps to run based on specific conditions. This is useful for creating dynamic pipelines that adjust to changes in your codebase or build environment.

- **Using Substitutions:** You can define custom substitutions in your `cloudbuild.yaml` file and use them to control whether steps are executed.

<br>

**Example of conditional execution:**

```
steps:
  - name: 'gcr.io/cloud-builders/gcloud'
    args: ['compute', 'instances', 'create', 'example-instance', '--zone', 'us-central1-a']
    id: 'create-instance'
    condition: '$BUILD_SUCCESS'

  - name: 'gcr.io/cloud-builders/gcloud'
    args: ['compute', 'instances', 'delete', 'example-instance', '--zone', 'us-central1-a']
    id: 'delete-instance'
    condition: '$BUILD_FAILURE'

```

In this example, a compute instance is created if the build succeeds and deleted if the build fails

### Parallel and Serial Step Execution

Cloud Build allows you to run steps in parallel or serially, providing flexibility in how your build process is orchestrated.

- Parallel Steps: To run steps in parallel, define them in the same stage of your build process. Use the `waitFor` attribute to manage dependencies between steps.

### _Example of parallel execution:_

```
steps:
  - name: 'gcr.io/cloud-builders/npm'
    args: ['install']
    id: 'install'

  - name: 'gcr.io/cloud-builders/npm'
    args: ['test']
    id: 'test'
    waitFor: ['install']

  - name: 'gcr.io/cloud-builders/npm'
    args: ['lint']
    id: 'lint'
    waitFor: ['install']

  - name: 'gcr.io/cloud-builders/npm'
    args: ['build']
    id: 'build'
    waitFor: ['-']
```
In this example, the `test` and `lint` steps wait for `install` to complete before running in parallel. The `build` step starts immediately without waiting

### Managing Artifacts

Effectively managing to build artifacts is crucial for a seamless CI/CD process. Cloud Build can store artifacts in Google Cloud Storage, making them accessible for deployment or further processing.

- Artifact Storage: Use the `artifacts` object in your `cloudbuild.yaml` to specify the artifacts to be stored and their storage location.

### _Example of artifact storage:_

```
artifacts:
  objects:
    location: 'gs://my-artifacts-bucket/'
    paths:
      - 'build/**'

```

This configuration stores all files from the `build/` directory in the specified Cloud Storage bucket.

### Optimizing Build Times

Optimizing your build times can significantly reduce costs and speed up your development cycle.

- **Use Cache:** Cache dependencies and build outputs to avoid redundant work in subsequent builds.
- **Choose the Right Machine Type:** Select an appropriate machine type for your build environment. Cloud Build offers several machine types that vary in CPU, memory, and disk size.
- **Parallelize Steps:** As demonstrated, running steps in parallel can reduce your build time.

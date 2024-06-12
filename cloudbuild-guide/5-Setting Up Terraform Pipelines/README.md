# Setting Up Terraform Pipelines

Terraform is an open-source infrastructure as code (IaC) tool that allows you to build, change, and version infrastructure safely and efficiently. Integrating Terraform with Google Cloud Build enables automated deployment and management of your Google Cloud Platform (GCP) infrastructure. This chapter guides you through setting up Terraform pipelines in Cloud Build to automate the provisioning of GCP resources.

### Preparing Your Terraform Configuration

1. **Terraform Configuration Files:** Begin by creating Terraform configuration files (`.tf`) that define the GCP resources you want to manage. Store these files in your source code repository alongside your application code or in a dedicated infrastructure repository.

2. **Terraform Backend:** Configure a Terraform backend to store your state file securely. Google Cloud Storage (GCS) is a common choice for a Terraform backend when working with GCP.

**Example `backend.tf`:**

```
terraform {
  backend "gcs" {
    bucket = "your-terraform-state-bucket"
    prefix = "terraform/state"
  }
}
```

### Creating the Cloud Build Pipeline for Terraform

1. **Cloud Build Service Account Permissions:** Ensure the Cloud Build service account has the necessary IAM roles to create and manage the resources defined in your Terraform configurations.

2. **`cloudbuild.yaml` for Terraform:** Define a Cloud Build configuration (`cloudbuild.yaml`) that specifies the steps to initialize Terraform, plan the changes, and apply the configuration.

Example `cloudbuild.yaml`:

```
steps:
  # Initialize Terraform
  - name: 'hashicorp/terraform:light'
    args: ['init']
  
  # Plan Terraform changes
  - name: 'hashicorp/terraform:light'
    args: ['plan']
    id: 'plan'
  
  # Apply Terraform changes
  - name: 'hashicorp/terraform:light'
    args: ['apply', '-auto-approve']
    id: 'apply'
    waitFor: ['plan']
```

This configuration uses the official Terraform Docker image to run the Terraform commands. The `waitFor` attribute ensures that the apply step only runs after the plan step is completed successfully.

### Managing Terraform State
Storing your Terraform state in a secure and accessible location is crucial for team collaboration and for managing infrastructure state over time. Using GCS as a backend provides versioning, locking, and secure storage.

- Configure State Locking: Ensure your GCS backend is configured with state locking to prevent concurrent executions from causing state corruption.

### Advanced Terraform Pipelines

- **Dynamic Environments:** Use Cloud Build substitutions or Terraform variables to manage different environments (e.g., development, staging, production) within the same pipeline.
- **Pull Request Previews:** Integrate Cloud Build with your version control system to trigger Terraform plan operations on pull requests. This can provide visibility into the potential impact of changes before they are merged.
- **Security Scanning:** Include steps in your Cloud Build pipeline to scan Terraform configurations for security issues or misconfigurations using tools like Checkov or Terraform Cloud.
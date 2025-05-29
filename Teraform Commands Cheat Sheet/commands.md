# Terraform Commands


| Commands |  Descriptions  |
|:-----|:--------:|
| terraform --version  | Utilizing a common format, create Terraform configuration files. |
| terraform --help  | Displays help information and lists available commands and options for Terraform. |
| terraform fmt  | Prepare Terraform configuration files using a standard format. |
| terraform fmt --recursive | Formats every Terraform configuration file automatically in the current directory and all of its subdirectories.|
|terraform fmt --diff | Format Terraform configuration files and displays the updated version of the file without actually making the changes.|
| terraform fmt --check | Verifies whether Terraform configuration files follow formatting guidelines without modifying them. |
| terraform init  | Sets the initial Terraform configuration, whether it is new or old. |
| terraform init -get-plugins=false | Launches Terraform without requiring updates for plugins. |
| terraform init -lock=false | Initiates a new Terraform configuration or launches an existing one without gaining a lock on state files. |
| terraform init -migrate-state | Used during initialization to move the Terraform state to an alternate backend. |
| terraform get  | Download and install any modules referenced in the configuration files. |
| terraform get -update | Updates modules to their latest versions, ensuring the configuration uses the most recent module releases. |
| terraform validate | Checks the syntax and structure of Terraform configuration files.|
| terraform validate -json | Checks the syntax of Terraform configuration files and outputs the results in JSON format. |
| terraform plan | Generates an execution plan, detailing the actions Terraform will take to achieve the desired infrastructure state. |
| terraform plan -out=<path> | Generates an execution plan for infrastructure changes and saves it to the specified path for later application. |
| terraform plan -destroy | Generates an execution plan specifically for destroying existing infrastructure resources defined in the Terraform configuration. |
| terraform apply | Executes the planned changes defined in the configuration files. |
| terraform apply --auto-approve | Automatically applies the execution plan without requiring manual confirmation.|
| terraform apply -var="environment=dev" | Deploys infrastructure defined in Terraform files, while "-var" lets you pass variables, like "environment=dev", during execution.|
| terraform apply -var-file="varfile.tfvars" | Applies changes to infrastructure defined in Terraform configuration files, using variable values specified in the "varfile.tfvars" file.|
| terraform destroy | Removes all resources defined in the Terraform configuration from the infrastructure. |
| terraform destroy --auto-approve | Automatically destroys all Terraform-managed infrastructure without requiring manual confirmation |
| terraform taint | Marks a specific resource for recreation during the next apply, effectively forcing it to be destroyed and recreated.|
| terraform untaint | Inverse of the terraform taint. |
| terraform refresh | updates the Terraform state file. |
| terraform show | Displays the current state of Terraform-managed infrastructure. |
| terraform show <path to statefile> | Displays the current state of infrastructure resources defined in the specified state file. |
| terraform state | Manages the state of Terraform-managed infrastructure. |
| terraform state list | List of all resources managed by Terraform within the current state file. |
| terraform state push | uploads the local state to the configured remote state storage.|
| terraform state rm | Remove a resource from the Terraform state. |
| terraform state mv | Move a resource instance from one Terraform state file to another. |
| terraform providers | Displays a list of all available providers along with their versions |
| terraform workspace list | Displays a list of available workspaces |
| terraform workspace show | Displays the current workspace name being used in Terraform. |
| terraform workspace new <workspace name> | Creates a new isolated workspace for managing Terraform configurations and state |
| terraform workspace delete <workspace name> | Remove a workspace, effectively deleting its state and associated resources.|
| terraform output | Displays the values of outputs defined in Terraform configurations. |
| terraform output -json | Displays Terraform output values in JSON format for easy consumption by other tools or scripts.|
| terraform force-unlock <lock_id> | Forcefully release a Terraform state lock identified by <lock_id>. |
| terraform login | Allows users to authenticate with Terraform Cloud or Terraform Enterprise |
| terraform logout | Remove locally stored credentials for Terraform Cloud or Terraform Enterprise |
| terraform graph | Generates a visual representation of the dependency graph for Terraform resources |
| terraform graph -draw-cycles | Generates a visual representation of the dependency graph, highlighting any cycles present within the infrastructure configuration.|
| terraform console | Opens an interactive shell for evaluating expressions and testing |
| terraform -chdir=”../stage” apply | Applies Terraform configurations located in the "../stage" directory. |
| terraform -install-autocomplete | Enables shell autocompletion for Terraform commands |
| terraform -debug <command> | '-debug' flag along with the specific Terraform command you want to debug.|
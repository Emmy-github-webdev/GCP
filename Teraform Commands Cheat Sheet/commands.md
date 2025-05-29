# Terraform Commands


#### _Check Terraform Version_

| Commands |  Descriptions  |
|:-----|:--------:|
| terraform --version  | Utilizing a common format, create Terraform configuration files. |

#### _Terraform Help Command_

| Commands |  Descriptions  |
|:-----|:--------:|
| terraform --help  | Displays help information and lists available commands and options for Terraform. |

#### _Optimizing Code Structure_

| Commands |  Descriptions  |
|:-----|:--------:|
| terraform fmt  | Prepare Terraform configuration files using a standard format. |
| terraform fmt --recursive | Formats every Terraform configuration file automatically in the current directory and all of its subdirectories.|
|terraform fmt --diff | Format Terraform configuration files and displays the updated version of the file without actually making the changes.|
| terraform fmt --check | Verifies whether Terraform configuration files follow formatting guidelines without modifying them. |

#### _Initializing Your Terraform Configuration_
| Commands |  Descriptions  |
|:-----|:--------:|
| terraform init  | Sets the initial Terraform configuration, whether it is new or old. |
| terraform init -get-plugins=false | Launches Terraform without requiring updates for plugins. |
| terraform init -lock=false | Initiates a new Terraform configuration or launches an existing one without gaining a lock on state files. |
| terraform init -migrate-state | Used during initialization to move the Terraform state to an alternate backend. |

#### _Module Management_

| Commands |  Descriptions  |
|:-----|:--------:|
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
| [日本語](/examples/basic/README-ja.md) | **English** |
| --- | --- |

## NGINX Application Example
This is an example of a web application using these modules with an NGINX Docker image.

### Quick Start
#### 1. Create `dev.tfvars`
Copy `dev.tfvars.example` to create `dev.tfvars`.  
Change `account_id` and `profile` to match your environment.

```tfvars
account_id = "123456789012"   # Your AWS account ID
region     = "ap-northeast-1"
profile    = "my-profile"     # Your AWS SSO profile name
```

Change other values as needed.

#### 2. Change Directory
Move to the `examples/basic` directory:

```bash
cd <repository_root>/examples/basic
```

#### 3. Initialize Terraform Modules
Run the following command to initialize the backend and update external modules/providers:

```bash
terraform init -upgrade
```

#### 4. Plan and Apply
Run the `plan` command to verify the changes, then run `apply` to deploy the resources on AWS:

```bash
# Verify the execution plan
terraform plan -var-file="dev.tfvars"

# Deploy the resources
terraform apply -var-file="dev.tfvars"
```

#### 5. Verify the Application
Retrieve the DNS name of the Application Load Balancer (ALB) from the AWS Management Console.  
Then, access the following URL in your browser:

```
http://<ALB_DNS_name>
```

#### 6. Destroy Resources
After testing, run the following command to destroy all resources and avoid unnecessary AWS charges.

```bash
terraform destroy -var-file="dev.tfvars"
```
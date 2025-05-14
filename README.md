# terraform-migration-project
This is a basic infrastructure setup in AWS using terraform.

## Folder Structure

<pre> ``` Folder Structure . 
  ├── modules/ │ ├── vpc/ # VPC, subnets, NAT, IGW 
               │ ├── ec2-autoscaling/ # Launch Template, Auto Scaling Group, Security Groups 
               │ ├── s3/ # S3 buckets with versioning 
               │ └── iam/ # IAM roles, policies, and instance profiles 
  ├── environments/ │ ├── dev/ # terraform.tfvars, backend.tf, main.tf 
                    │ ├── stage/ 
                    │ └── prod/ ``` </pre>


## Terraform Deployment commands to launch the infrastructure.

### 📁 Navigate to your environment directory
```cd environments/dev```

### 🧱 Initialize Terraform (downloads providers, configures backend)
```terraform init```

### ✅ Validate your configuration
```terraform validate```

### 🧠 (Optional) Preview what Terraform will do
```terraform plan -var-file="terraform.tfvars"```

### 💾 Save the plan
```terraform plan -var-file="terraform.tfvars" -out=tfplan```

### 🚀 Apply the infrastructure

```terraform apply tfplan```


## For Cleanup (Safe Destroy)

```terraform plan -destroy -var-file="terraform.tfvars" -out=destroy.tfplan```
```terraform apply destroy.tfplan```


# terraform-migration-project
This is a basic infrastructure setup in AWS using terraform.

## Folder Structure

<pre> ``` Folder Structure . 
  ├── modules/ │ ├── vpc/ # VPC, subnets, NAT, IGW 
               │ ├── ec2-autoscaling/ # Launch Template, Auto Scaling Group, Security Groups 
               │ ├── s3/ # S3 buckets with versioning 
               │ └── iam/ # IAM roles, policies, and instance profiles 
  ├── envs/ │ ├── dev/ # terraform.tfvars, backend.tf, main.tf 
            │ ├── stage/ 
            │ └── prod/ ``` </pre>

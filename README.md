# Terraform AWS Infra Project

This repository contains Terraform code to provision a complete AWS infrastructure with **multi-environment support** (Dev & Prod).  
It includes EC2 instances, VPC, subnets, security groups, IAM roles, and optionally RDS MySQL for production.

---

## 🌐 Features

- **VPC & Subnets:** Public and private subnets across multiple AZs.  
- **EC2:** Ubuntu server with Apache installed.  
  - Dev: Apache + MySQL on the same EC2.  
  - Prod: Apache on EC2, MySQL on managed RDS.  
- **RDS (optional):** Managed MySQL for production environment.  
- **IAM & SSM:** EC2 access using **Session Manager**, no PEM key needed.  
- **Security Groups:** Configurable via variables.  
- **Fully Variable-driven:** No hardcoded values; use `.tfvars` per environment.

---

## 📂 Project Structure
terraform-ec2-mysql-rds/
│── modules/ # Optional: reusable modules
│── environments/
│ ├── dev/ # Dev environment
│ │ └── dev.tfvars
│ └── prod/ # Prod environment
│ └── prod.tfvars
│── userdata/
│ └── userdata.sh # EC2 user-data script
│── provider.tf
│── variables.tf
│── locals.tf
│── vpc.tf
│── iam.tf
│── ec2.tf
│── rds.tf
│── outputs.tf
│── README.md

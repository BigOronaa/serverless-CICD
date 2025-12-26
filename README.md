# Serverless Application with CI/CD Pipeline

## Project Overview

This project demonstrates the provisioning and deployment of a **serverless API backend** using **Terraform** and a **GitHub Actions CI/CD pipeline**.  
The serverless infrastructure includes:

- **AWS Lambda** — executes the API logic  
- **API Gateway (HTTP API)** — exposes the Lambda as an HTTP endpoint  
- **DynamoDB** — serves as a simple NoSQL database for the application  

The project supports **multiple environments** (dev, staging, prod) using **Terraform variables**.

---

## Project Structure

```
serverless-CICD/
├── modules/
│   ├── lambda/
│   ├── api-gateway/
│   └── dynamodb/
├── environments/
│   ├── dev/
│   ├── staging/
│   └── prod/
└── .github/
    └── workflows/
        └── terraform-dev.yml
```

- **modules/** — reusable Terraform modules for each resource  
- **environments/** — environment-specific configurations (dev, staging, prod)  
- **.github/workflows/** — CI/CD pipeline for dev environment

---

## Prerequisites

- Terraform >= 1.5.0  
- AWS account with programmatic access  
- GitHub repository for CI/CD  
- GitHub Actions secrets:
  - `AWS_ACCESS_KEY_ID`
  - `AWS_SECRET_ACCESS_KEY`
  - `AWS_REGION`

---

## Deployment

### Local Deployment (Dev)

1. Navigate to the dev environment:

```bash
cd environments/dev
```

2. Initialize Terraform:

```bash
terraform init
```

3. Validate configuration:

```bash
terraform validate
```

4. Create a plan:

```bash
terraform plan -var "environment=dev" -var "region=us-east-1" -input=false
```

5. Apply the infrastructure:

```bash
terraform apply -auto-approve -var "environment=dev" -var "region=us-east-1" -input=false
```

### CI/CD Deployment

- GitHub Actions workflow is configured for the **dev environment**:  
  `.github/workflows/terraform-dev.yml`
- Workflow steps:
  1. Checkout repository  
  2. Terraform Init  
  3. Terraform Validate  
  4. Terraform Plan  
  5. Terraform Apply (non-interactive)

---

## Environment Management

- Dev, staging, and prod environments are **folder-based** in `environments/`.  
- Variables such as `environment` and `region` are defined in `terraform.tfvars`.  
- Only **dev** is deployed automatically via CI/CD; staging and prod are structurally ready.

---

## Sample Application

- The deployed Lambda function responds with:

```
Hello World from Dev Environment!
```

- Accessible via API Gateway URL output:

```
https://<api_id>.execute-api.<region>.amazonaws.com/hello
```

Test with:

```bash
curl https://<api_id>.execute-api.<region>.amazonaws.com/hello
```

---

## Notes

- Terraform modules abstract resource configurations for **reusability**.  
- CI/CD workflow ensures **automated dev deployment**.  
- Staging and prod environments are prepared for future deployment.  

---




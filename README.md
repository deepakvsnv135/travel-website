# AWS EKS Infrastructure using Terraform

A production‑style Terraform project that provisions a complete Kubernetes environment on AWS.
This repository demonstrates how to create reusable modules, separate backend state, and organize infrastructure as code in a clean DevOps‑friendly structure.

---

## 🚀 What this project creates

* VPC with public & private subnets
* Internet Gateway & routing
* EKS Cluster
* Managed Node Group (Worker Nodes)
* Required IAM Roles & Policies
* Terraform backend configuration (separate state stack)

This repo focuses on **clean modular Terraform design** — not just running `terraform apply`.

---

## 🧱 Architecture Overview

```
AWS Account
│
├── VPC
│   ├── Public Subnets (for LoadBalancer / NAT / future ingress)
│   └── Private Subnets (for Kubernetes worker nodes)
│
├── EKS Control Plane
│
└── Node Group (EC2 worker nodes inside private subnet)
```

---

## 📁 Project Structure

```
aws-eks/
│
├── main.tf                # Root module orchestration
├── variable.tf            # Input variables
├── modules/
│   ├── vpc/               # Network layer (VPC + Subnets)
│   └── eks/               # Kubernetes cluster
│
├── backend/
│   ├── main.tf            # Backend infra (S3/DynamoDB state storage)
│   └── output.tf
│
└── README.md
```

---

## ⚙️ Prerequisites

Make sure these are installed:

* Terraform >= 1.3
* AWS CLI configured
* kubectl
* IAM user with programmatic access

Configure AWS credentials:

```
aws configure
```

---

## 🛠️ Deployment Steps

### 1️⃣ Create Backend Infrastructure

Stores Terraform state remotely (recommended for teams).

```
cd backend
terraform init
terraform apply
```

---

### 2️⃣ Deploy Main Infrastructure

```
cd ..
terraform init
terraform plan
terraform apply
```

After completion, EKS cluster will be created.

---

### 3️⃣ Configure kubectl

```
aws eks update-kubeconfig --region <region> --name <cluster-name>
```

Verify:

```
kubectl get nodes
```

---

## 🔐 State Management

This project separates:

| Layer   | Purpose                        |
| ------- | ------------------------------ |
| backend | Stores Terraform state infra   |
| main    | Creates Kubernetes environment |

State files are intentionally ignored from Git for security reasons.

---

## 🧪 Useful Commands

Destroy resources:

```
terraform destroy
```

Format code:

```
terraform fmt -recursive
```

Validate configuration:

```
terraform validate
```

---

## 💡 Learning Goals of this Repo

This repository demonstrates real DevOps practices:

* Modular Terraform design
* Environment separation
* Remote state usage
* Kubernetes provisioning via IaC
* Clean Git structure (no state or secrets)

---

## 🧹 Cleanup

To remove all infrastructure:

```
terraform destroy
```

Then remove backend resources manually if required.

---

## 📌 Future Improvements

* Helm deployment automation
* CI/CD pipeline integration
* ArgoCD / GitOps
* Monitoring stack (Prometheus + Grafana)

---

## 👨‍💻 Author

Infrastructure project built for learning and demonstrating production‑style DevOps Terraform workflow.

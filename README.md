# 🏗️ Production-Grade EKS Cluster Creation Using Terraform and GitHub Actions

This repository contains code from my [Hashnode blog series](https://koilraj.hashnode.dev/series/eks-cluster-terraform-github-actions), demonstrating how to create a robust Amazon EKS cluster with **Terraform** and CI/CD pipelines via **GitHub Actions**.

Through this series, you’ll learn how to **automate provisioning**, **secure your setup**, and follow **best practices for scalable, production-ready Kubernetes on AWS**.

---

## 📚 Blog Series Overview

| Part | Title | 
|------|--------|
| 🧩 **Part 1** | [Building a Production-Grade Kubernetes Cluster on AWS Using Terraform](https://koilraj.hashnode.dev/building-a-production-grade-kubernetes-cluster-on-aws-using-terraform-part-1-overview) | 
| ⚙️ **Part 2** | [Automating VPC Setup via GitHub Actions](https://koilraj.hashnode.dev/vpc-setup-with-github-actions)) | 
| ☸️ **Part 3** | [EKS Cluster Provisioning using Terraform Modules](https://koilraj.hashnode.dev/part-3-eks-cluster-provisioning-using-terraform-modules) | 
| 🚀 **Part 4** | [EKS Add-ons – AWS Load Balancer Controller, Autoscaler, Metrics Server](https://koilraj.hashnode.dev/deploying-eks-add-ons-aws-load-balancer-controller-autoscaler-metrics-server) | 
| 🧱 **Part 5** | [Deploying a Simple Application on Amazon EKS using Kubernetes Manifests](https://koilraj.hashnode.dev/part-5-deploying-a-simple-application-on-amazon-eks) | 

> 💡 Each part builds upon the previous one — from setting up the VPC to deploying workloads on a fully managed EKS cluster.

---

## 🧰 Technologies & Tools

- **AWS EKS (Elastic Kubernetes Service)**
- **Terraform** for Infrastructure as Code
- **GitHub Actions** for CI/CD Automation
- **Kubernetes** for container orchestration
- **AWS Services:** VPC, IAM, EC2, ALB, Auto Scaling
- **Helm** for managing Kubernetes add-ons

---

## 📂 Repository Structure

```
├── .github/
│   └── workflows/
│       ├── eks-addons.yaml
│       └── eks.yaml
├── deployment/
│   ├── deployment.yaml
│   ├── ingress.yaml
│   └── service.yaml
├── eks-iac-terraform/
│   ├── eks-addons/
│   │   ├── aws-lb-controller.tf
│   │   ├── backend.tf
│   │   ├── cluster-autoscaler.tf
│   │   ├── data.tf
│   │   ├── locals.tf
│   │   ├── metric-service.tf
│   │   ├── output.tf
│   │   ├── terraform.tfvars
│   │   └── variables.tf
│   ├── eks/
│   │   ├── addons.tf
│   │   ├── data.tf
│   │   ├── eks.tf
│   │   ├── locals.tf
│   │   ├── nodes.tf
│   │   ├── output.tf
│   │   ├── providers.tf
│   │   ├── terraform.tfvars
│   │   └── variables.tf
├── pre-requisite/
│   └── s3-bucket.tf
└── vpc/
    ├── igw.tf
    ├── locals.tf
    ├── nat.tf
    ├── providers.tf
    ├── routes.tf
    ├── subnets.tf
    └── vpc.tf
```

## ⭐ Support

If you found this helpful, please give the repo a ⭐ and share it with others learning Terraform, GitHub Actions, and EKS!

## 💬 Let’s Build Something Amazing Together
<p align="center"> <a href="https://www.linkedin.com/in/koil-raj/" target="_blank"> <img src="https://img.shields.io/badge/LinkedIn-%230077B5.svg?&style=for-the-badge&logo=linkedin&logoColor=white" alt="LinkedIn"/> </a> <a href="https://medium.com/@koilrajjee" target="_blank"> <img src="https://img.shields.io/badge/Medium-%23121212.svg?&style=for-the-badge&logo=medium&logoColor=white" alt="Medium"/> </a> <a href="mailto:koilrajjee@gmail.com" target="_blank"> <img src="https://img.shields.io/badge/Email-%23D14836.svg?&style=for-the-badge&logo=gmail&logoColor=white" alt="Email"/> </a> </p>

# Microservices Platform on AWS EKS

Production-ready microservices platform using:

- AWS EKS
- Terraform
- Docker
- GitHub Actions
- ArgoCD
- Prometheus
- Grafana
- NGINX Ingress
- AWS Cognito
- AWS Secrets Manager
- PostgreSQL RDS

---

# Architecture

Developer Push
↓
GitHub Actions
↓
Terraform Apply
↓
Docker Build & Push to ECR
↓
Deploy to EKS
↓
ArgoCD GitOps Sync

---

# Project Structure

```bash
terraform/
kubernetes/
services/
scripts/
.github/
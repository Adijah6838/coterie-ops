# Coterie Ops — Application Delivery Pipeline

An automated delivery pipeline for an ASP.NET Core API, featuring GitHub Actions CI, Docker containerization, and Kubernetes deployment manifests.

## Features
- **CI/CD**: Automatic build, test, and Docker image creation via GitHub Actions.
- **Testing**: xUnit test suite ensures the API works before deployment.
- **Container Health Checks**: Both Dockerfile and Kubernetes manifests contain health checks.
- **K8s Manifests**: Deployment and Service configurations with resource limits and probes.

## Deployment Steps
1. Build the Docker image: `docker build -t coterieops-api:latest .`
2. Apply K8s manifests: `kubectl apply -f k8s/deployment.yml -f k8s/service.yml`
3. Verify rollout: `kubectl rollout status deployment/coterieops-api`

## Rollback Procedures
If a deployment fails or causes errors, roll back to the previous version:
```bash
kubectl rollout undo deployment/coterieops-api
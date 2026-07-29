# sddp-infrastructure

Terraform for the Secure-by-Default Delivery Platform's Kubernetes cluster itself: node pools, VPC/networking, and cluster-level IAM.

**Target: DigitalOcean, DOKS, funded by GitHub Student Developer Pack credit.**

Part of the SDDP repo split (ADR-005). Rare, highest-review-weight repo — a mistake here affects the entire cluster and every tenant.

Also responsible for the one necessarily-imperative bootstrap step: provisioning the cluster and installing ArgoCD, before GitOps can take over anything.

## Usage

Requires a DigitalOcean API token available as `DIGITALOCEAN_TOKEN` (this repo loads it from a gitignored `.env` via `direnv` — see `.envrc`).

```
terraform init
terraform plan
terraform apply
```

Fetch cluster access after `apply`:
```
doctl kubernetes cluster kubeconfig save sddp-poc
kubectl get nodes
```

Tear down between sessions to conserve credit:
```
terraform destroy
```

ArgoCD is installed via the `helm` Terraform provider (`argocd.tf`) — no manual `helm install`, so `terraform apply` alone reproduces it. Access it:
```
kubectl port-forward svc/argocd-server -n argocd 8080:443
```
Then open `https://localhost:8080` (self-signed cert, accept the browser warning). Username `admin`, password from:
```
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
```

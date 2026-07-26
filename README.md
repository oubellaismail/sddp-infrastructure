# sddp-infrastructure

Terraform for the Secure-by-Default Delivery Platform's Kubernetes cluster itself: node pools, VPC/networking, and cluster-level IAM.

**Target: Google Cloud Platform, GKE, funded by GCP's free tier.**

Part of the SDDP repo split (ADR-005). Rare, highest-review-weight repo — a mistake here affects the entire cluster and every tenant.

Also responsible for the one necessarily-imperative bootstrap step: provisioning the cluster and installing ArgoCD, before GitOps can take over anything (cluster-architecture-spec.md §1a).

Design docs: see the `pfa` repo.

# sddp-infrastructure

Terraform for the Secure-by-Default Delivery Platform's Kubernetes cluster itself: node pools, VPC/networking, and cluster-level IAM.

**Target: Google Cloud Platform, GKE, funded by GCP's free tier** (decided in `sddp-docs/tracker/tickets/INFRA-001-decide-cluster-target.md`).

Part of the SDDP repo split (see `sddp-docs/adrs/adr-005-repo-structure.md` and `sddp-docs/specs/cluster-architecture-spec.md` §1a). Rare, highest-review-weight repo — a mistake here affects the entire cluster and every tenant.

Also responsible for the one necessarily-imperative bootstrap step: provisioning the cluster and installing ArgoCD, before GitOps can take over anything (cluster-architecture-spec.md §1a).

Design docs and progress tracking: see the `sddp-docs` repo (`tracker/STATUS.md` for current state, `tracker/tickets/INFRA-*` for this repo's work).

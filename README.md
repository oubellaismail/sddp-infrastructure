# sddp-infrastructure

Terraform for the Secure-by-Default Delivery Platform's Kubernetes cluster itself: node pools, VPC/networking, and cluster-level IAM.

Part of the SDDP repo split (see `pfa/adr-005-repo-structure.md` and `pfa/cluster-architecture-spec.md` §1a). Rare, highest-review-weight repo — a mistake here affects the entire cluster and every tenant.

Also responsible for the one necessarily-imperative bootstrap step: provisioning the cluster and installing ArgoCD, before GitOps can take over anything (cluster-architecture-spec.md §1a).

Design docs: see the `pfa` repo.

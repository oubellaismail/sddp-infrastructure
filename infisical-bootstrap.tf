# Bootstrap credential for External Secrets Operator (ESO).
#
# ESO runs in-cluster and pulls the platform's secrets (docr-read, db-credentials)
# from the Infisical Cloud project. To authenticate to Infisical it needs a
# machine-identity Universal Auth credential (clientId/clientSecret). That
# credential is the ONE standing bootstrap secret that replaces the three former
# imperative `kubectl create secret` steps — and unlike them it is declarative
# (Terraform-managed, fed from TF_VAR_* in .env), not hand-typed after each recreate.
#
# It is created here rather than by ArgoCD because it is a plaintext credential that
# must not live in git — the same reason the ArgoCD deploy keys are Terraform-managed.
# The namespace is created first so the secret has somewhere to land; the ESO
# Application (apps/external-secrets.yaml, CreateNamespace=true) adopts the existing ns.
#
# Teardown note: like the argocd_* kubectl_manifest resources, these authenticate
# with the cluster token captured at creation, which comes back empty on a post-
# creation plan/destroy. Include them in the `terraform state rm` list before
# `terraform destroy` (see the bring-up runbook).

resource "kubectl_manifest" "external_secrets_namespace" {
  yaml_body = <<-YAML
    apiVersion: v1
    kind: Namespace
    metadata:
      name: external-secrets
  YAML

  depends_on = [helm_release.argocd]
}

resource "kubectl_manifest" "infisical_universal_auth" {
  yaml_body = <<-YAML
    apiVersion: v1
    kind: Secret
    metadata:
      name: infisical-universal-auth
      namespace: external-secrets
    stringData:
      clientId: "${var.infisical_client_id}"
      clientSecret: "${var.infisical_client_secret}"
  YAML

  depends_on = [kubectl_manifest.external_secrets_namespace]
}

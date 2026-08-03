# ArgoCD repository credential for the private sddp-app-config repo (the app's
# GitOps config repo, watched by the sddp-app child Application).
#
# Mirrors argocd-repo-credentials.tf. GitHub deploy keys are per-repo, so the
# read-only key ArgoCD uses for sddp-platform-config cannot be reused here — this
# is a second, independent read-only deploy key scoped to just sddp-app-config.
# Private key material stays out of Git: it lives in .env as
# TF_VAR_argocd_app_config_ssh_private_key (same direnv pattern as the others).
#
# ArgoCD matches credentials to repos by EXACT url string, so this `url` and the
# child Application's `repoURL` must both be the git@ SSH form, character-for-
# character — a stray https:// anywhere breaks auth for that Application only.
resource "kubectl_manifest" "argocd_app_config_credentials" {
  yaml_body = <<-YAML
    apiVersion: v1
    kind: Secret
    metadata:
      name: sddp-app-config-creds
      namespace: argocd
      labels:
        argocd.argoproj.io/secret-type: repository
    stringData:
      type: git
      url: git@github.com:oubellaismail/sddp-app-config.git
      sshPrivateKey: |
        ${indent(4, replace(var.argocd_app_config_ssh_private_key, "\\n", "\n"))}
  YAML

  depends_on = [helm_release.argocd]
}

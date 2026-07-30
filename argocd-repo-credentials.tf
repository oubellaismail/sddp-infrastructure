resource "kubectl_manifest" "argocd_repo_credentials" {
  yaml_body = <<-YAML
    apiVersion: v1
    kind: Secret
    metadata:
      name: sddp-platform-config-creds
      namespace: argocd
      labels:
        argocd.argoproj.io/secret-type: repository
    stringData:
      type: git
      url: git@github.com:oubellaismail/sddp-platform-config.git
      sshPrivateKey: |
        ${indent(4, replace(var.argocd_repo_ssh_private_key, "\\n", "\n"))}
  YAML

  depends_on = [helm_release.argocd]
}

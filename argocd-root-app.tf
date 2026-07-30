provider "kubectl" {
  host = digitalocean_kubernetes_cluster.sddp.kube_config[0].host
  token = digitalocean_kubernetes_cluster.sddp.kube_config[0].token 
  cluster_ca_certificate = base64decode(digitalocean_kubernetes_cluster.sddp.kube_config[0].cluster_ca_certificate)
  load_config_file = false
}

resource "kubectl_manifest" "argocd_root_app" {
  yaml_body = <<-YAML
    apiVersion: argoproj.io/v1alpha1
    kind: Application
    metadata:
      name: root
      namespace: argocd
    spec:
      project: default
      source:
        repoURL: git@github.com:oubellaismail/sddp-platform-config.git
        targetRevision: main
        path: apps
        directory:
          recurse: true
      destination:
        server: https://kubernetes.default.svc
        namespace: argocd
      syncPolicy:
        automated:
          prune: true
          selfHeal: true
  YAML
  
  depends_on = [helm_release.argocd]
}

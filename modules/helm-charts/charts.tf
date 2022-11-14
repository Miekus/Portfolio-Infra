

resource "helm_release" "argo" {
  name             = "argo"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  version          = "5.13.8"
  namespace        = "default"
  create_namespace = true

  set {
    name  = "server.service.type"
    value = "LoadBalancer"
  }
}
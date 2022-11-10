# resource "helm_release" "nginx_ingress" {
#   name             = "nginx-ingress"
#   chart            = "/home/ubuntu/jenkins/git/demo-crm/nginx/nginx-ingress"
#   namespace        = "ingress"
#   create_namespace = "true"
# }

resource "helm_release" "argo_cd" {
  name             = "argo"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  version          = "4.8.2"
  namespace        = "gitops"
  create_namespace = true

  set {
    name  = "server.service.type"
    value = "LoadBalancer"
  }
}
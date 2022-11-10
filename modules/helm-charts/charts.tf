resource "helm_release" "nginx_ingress" {
  name             = "nginx-ingress"
  repository       = "https://helm.nginx.com/stable"
  chart            = "nginx-ingress"
  version          = "0.15.1"
  namespace        = "ingress"
  create_namespace = "true"
    set {
        name = "controller.replicaCount"
        value = "1"
    }
}
# resource "helm_release" "cm" {
#   name             = "cm"
#   chart            = "cert-manager"
#   repository       = "https://charts.jetstack.io"
#   version          = "1.10.0"
# }
# resource "helm_release" "argo_cd" {
#   name             = "argo"
#   repository       = "https://argoproj.github.io/argo-helm"
#   chart            = "argo-cd"
#   version          = "4.8.2"
#   namespace        = "gitops"
#   create_namespace = true

#   # annotations:
#   #   nginx.ingress.kubernetes.io/ssl-redirect: "false"
#   #   nginx.ingress.kubernetes.io/use-regex: "true"
#   #   nginx.ingress.kubernetes.io/rewrite-target: /$1
#   set {
#     name  = "server.ingress.annotations.nginx\\.ingress\\.kubernetes\\.io/ssl-redirect"
#     value = "false"
#     type  = "string"
#   }
#   set {
#     name  = "server.ingress.annotations.nginx\\.ingress\\.kubernetes\\.io/use-regex"
#     value = "true"
#     type  = "string"
#   }
#   set {
#     name  = "server.ingress.annotations.nginx\\.ingress\\.kubernetes\\.io/rewrite-target"
#     value = "/$1"
#   }
#   set {
#     name  = "server.ingress.enabled"
#     value = "true"
#   }
#   set {
#     name  = "server.ingress.https"
#     value = "true"
#   }
#   set {
#     name  = "server.ingress.ingressClassName"
#     value = "nginx"
#   }
#   set {
#     name  = "server.ingress.pathType"
#     value = "Prefix"
#   }
#   set {
#     name  = "server.ingress.paths"
#     value = "{/argocd(.*)}" # "[\"/argocd\"]"
#   }
# }
# Deploys Flux controller https://github.com/fluxcd/flux/tree/master/chart/flux and Helm Operator https://github.com/fluxcd/helm-operator
# Points flux to https://github.com/ams0/rancher-home/tree/master/manifests

provider "helm" {
  kubernetes {
    load_config_file = "false"


    host     = var.api_server_url
    username = var.kube_admin_user

    client_certificate     = var.client_cert
    client_key             = var.client_key
    cluster_ca_certificate = var.ca_crt
  }
}

provider kubernetes {
  load_config_file = "false"


  host     = var.api_server_url
  username = var.kube_admin_user

  client_certificate     = var.client_cert
  client_key             = var.client_key
  cluster_ca_certificate = var.ca_crt
}

resource "kubernetes_namespace" "fluxcd" {
  metadata {
    name = "fluxcd"
  }
    depends_on = [var.namespace_depends_on]

}

resource "kubernetes_secret" "flux-ssh" {
  metadata {
    name      = "flux-ssh"
    namespace = kubernetes_namespace.fluxcd.metadata.0.name
  }
  data = {
    identity = var.identity
  }

    depends_on = [var.secret_depends_on]
}

resource "helm_release" "flux" {
  name       = "flux"
  repository = "https://charts.fluxcd.io"
  namespace  = "fluxcd"
  chart      = "flux"

#https://www.hashicorp.com/blog/hashicorp-terraform-0-12-preview-for-and-for-each/
  dynamic "set" {
    for_each = local.flux_values

    content {
      name                 = set.key
      value               = set.value
    }
  }
}

resource "helm_release" "helmoperatorcrds" {
  name       = "helmoperatorcrds"
  repository = "../charts/"
  chart      = "helmoperatorcrds"
}

resource "helm_release" "helm-operator" {

  depends_on = [
    helm_release.helmoperatorcrds,
  ]

  name       = "helm-operator"
  repository = "https://charts.fluxcd.io"
  #we could use create_namespace = true, but the secret needs to be created first before the helm release
  namespace  = "fluxcd"
  chart      = "helm-operator"

#https://www.hashicorp.com/blog/hashicorp-terraform-0-12-preview-for-and-for-each/
  dynamic "set" {
    for_each = local.helmoperator_values

    content {
      name                 = set.key
      value               = set.value
    }
  }
}

#Sets up a Cluster role binding to grant a specific AAD group cluster-admin role and creates a generic kubeconfig for AAD auth

provider "azuread" {
  tenant_id       = var.tenant_id
  subscription_id = var.subscription_id #becouse of https://github.com/terraform-providers/terraform-provider-azuread/issues/294
}

data "azuread_user" "aadadmin" {
  user_principal_name = "${var.username}@${var.domain}"
}

data "azuread_group" "kubernetes-admin" {
  name = var.aadadmin_group
}

provider kubernetes {
  load_config_file = "false"


  host     = var.api_server_url
  username = var.kube_admin_user

  client_certificate     = var.client_cert
  client_key             = var.client_key
  cluster_ca_certificate = var.ca_crt
}

resource "kubernetes_cluster_role_binding" "rke-cluster-admins" {
  metadata {
    name = "rke-cluster-admins"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }
  subject {
    kind      = "Group"
    name      = data.azuread_group.kubernetes-admin.id
    api_group = "rbac.authorization.k8s.io"
  }
  depends_on = [var.aad_depends_on]
}

locals {
  kubeconfig_aad = <<-EOT
apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: ${base64encode(var.ca_crt)}
    server: https://${var.endpoint}:6443
  name: rkeaad
contexts:
- context:
    cluster: rkeaad
    namespace: default
    user: ${data.azuread_user.aadadmin.id}
  name: rkeaad
current-context: rkeaad
kind: Config
preferences: {}
users:
- name: ${data.azuread_user.aadadmin.id}
  user:
    auth-provider:
      config:
        apiserver-id: ${var.aadserverapp_id}
        client-id: ${var.aadclientapp_id}
        environment: AzurePublicCloud
        tenant-id: ${var.tenant_id}
      name: azure
  EOT
}

resource "local_file" "kubeconfig_aad" {
  filename = "kubeconfig_aad.yaml"
  content  = local.kubeconfig_aad
}

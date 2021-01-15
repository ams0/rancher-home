# count in module requires terraform 0.13
# change this to clusters/aks/ if you target AKS if on 0.12
module "cluster" {
  # count = var.cluster_type == "rke" ? 1 : 0

  source          = "./modules/clusters/rke"
  tenant_id       = var.tenant_id
  aadserverapp_id = var.aadserverapp_id
}

module "aad" {
  source          = "./modules/aad"
  username        = var.username
  domain          = var.domain
  tenant_id       = var.tenant_id
  subscription_id = var.subscription_id
  endpoint        = var.endpoint
  aadserverapp_id = var.aadserverapp_id
  aadclientapp_id = var.aadclientapp_id
  aadadmin_group  = var.aadadmin_group
  cluster_name    = module.cluster.cluster_name
  api_server_url  = module.cluster.api_server_url
  kube_admin_user = module.cluster.kube_admin_user
  client_cert     = module.cluster.client_cert
  client_key      = module.cluster.client_key
  ca_crt          = module.cluster.ca_crt

  aad_depends_on = module.cluster.cluster_name

}

module "github" {
  source = "./modules/github"
}

module "flux" {
  source          = "./modules/flux"
  api_server_url  = module.cluster.api_server_url
  kube_admin_user = module.cluster.kube_admin_user
  client_cert     = module.cluster.client_cert
  client_key      = module.cluster.client_key
  ca_crt          = module.cluster.ca_crt
  identity        = module.github.private_key_pem

  namespace_depends_on = module.cluster.cluster_name
  secret_depends_on    = module.github.private_key_pem

}

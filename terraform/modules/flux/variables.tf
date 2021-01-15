variable "cluster_type" {
  description = "Cluster type, aks or rke"
  default = "rke"
}

variable "org" {
  description = "Github org"
  default = "ams0"
}

variable "repo" {
  description = "Github repo"
  default = "rancher-home"
}

variable "endpoint" {
  description = "Kubernetes API endpoint"
  default = "cloud.stackmasters.com"
}

variable "api_server_url" {
  description = "api_server_url"
}

variable "kube_admin_user" {
  description = "kube_admin_user"
}

variable "client_cert" {
  description = "kube_admin_user"
}

variable "client_key" {
  description = "kube_admin_user"
}

variable "ca_crt" {
  description = "kube_admin_user"
}

variable "tenant_id" {
  description = "Tenant ID for AAD auth"
  default = "a68cdba5-68a4-49a3-8a42-2823316db54f"
}

variable "apiserver-id" {
  description = "AppID for AAD server app"
  default = "5bd13b05-c17a-4589-8a61-f2185ab7831f"
}

variable "client_id" {
  description = "AppID for AAD client app"
  default = "009ed4ad-ce28-45b9-b1ec-e515fd4e3d25"
}

variable "identity" {
  description = "ssh_identity"
}

variable "namespace_depends_on" {
  description = "Variable to force namespace to be deleted before cluster"
}

variable "secret_depends_on" {
  description = "Variable to force secret to be deleted before cluster"
}
variable "username" {
  description = "AAD user"
}

variable "domain" {
  description = "AAD user"
}

variable "aadadmin_group" {
  description = "AAD Admin group"
}

variable "aadserverapp_id" {
  description = "AAD Admin group"
}

variable "aadclientapp_id" {
  description = "AAD Admin group"
}

variable "endpoint" {
  description = "Kubernetes API endpoint"
}

variable "tenant_id" {
  description = "Tenant ID for AAD auth"
}

variable "subscription_id" {
  description = "Subscription ID for AAD auth, mostly useless"
}

variable "ca_crt" {
  description = "CA certifcate"
}

variable "cluster_name" {
  description = "CA certifcate"
}

variable "aad_depends_on" {
  description = "Variable to force AAD to be deleted before cluster"
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

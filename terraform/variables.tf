variable "cluster_type" {
  description = "Cluster type, aks or rke"
  default     = "rke"
}

variable "org" {
  description = "Github org"
  default     = "ams0"
}

variable "repo" {
  description = "Github repo"
  default     = "rancher-home"
}

variable "endpoint" {
  description = "Kubernetes API endpoint"
  default     = "cloud.stackmasters.com"
}

variable "tenant_id" {
  description = "Tenant ID for AAD auth"
}

#AAD module
variable "username" {
  description = "AAD user"
}

variable "subscription_id" {
  description = "Subscription ID for AAD auth, mostly useless"
}

variable "domain" {
  description = "AAD user"
}

variable "aadadmin_group" {
  description = "AAD Admin group"
}

variable "aadserverapp_id" {
  description = "AppID for AAD server app"
  default     = "5bd13b05-c17a-4589-8a61-f2185ab7831f"
}

variable "aadclientapp_id" {
  description = "AppID for AAD client app"
  default     = "009ed4ad-ce28-45b9-b1ec-e515fd4e3d25"
}
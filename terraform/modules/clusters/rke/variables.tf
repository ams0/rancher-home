variable "cluster-name" {
  description = " Cluster Name"
  default = "rancher-home"
}

variable "kubernetes-version" {
  description = " Version of hyperkube from https://hub.docker.com/r/rancher/hyperkube/tags"
  default = "v1.17.5-rancher1"
}

variable "tenant_id" {
  description = "Tenant ID for AAD auth"
  default = "a68cdba5-68a4-49a3-8a42-2823316db54f"
}

variable "aadserverapp_id" {
  description = "AppID for AAD server app"
  default = "5bd13b05-c17a-4589-8a61-f2185ab7831f"
}
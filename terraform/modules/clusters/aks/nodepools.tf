# https://blog.gruntwork.io/terraform-tips-tricks-loops-if-statements-and-gotchas-f739bbae55f9

variable "nodepools" {
  description = "nodepools"
  type        = list(string)
  default     = ["base", "gpu", "morpheus"]
}

resource "azurerm_kube_nodepools" "pool" {
  count = length(var.nodepools)
  name  = var.nodepools[count.index]
}

output "pool_name" {
  value       = azurerm_kube_nodepools.example[0].name
  description = "The name for pool 0"
}
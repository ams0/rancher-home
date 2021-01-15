# Definition of nodes for the RKE cluster
locals {
  nodes = {
    "nuc1"   = "192.168.178.5"
    "nuc2"   = "192.168.178.6"
    "hp01"   = "192.168.178.30"
    "hp02"   = "192.168.178.31"
  }
}
# Creates a public/private keypair, store the private as a kubernetes secrets that will be used by flux, and uploads the public part to Github as deploy key
provider "github" {
  organization = "ams0"
  individual   = false
  #because of https://github.com/terraform-providers/terraform-provider-github/issues/45
  version      = "2.4.0"
}

resource "tls_private_key" "flux-deploy-key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "github_repository_deploy_key" "flux-deploy" {
  title      = "Flux deploy key"
  repository = "rancher-home"
  key        = tls_private_key.flux-deploy-key.public_key_openssh
  read_only  = "false"
}

# Values to deploy the flux controller and the helm operator via the helm terraform profider (see flux.tf)
locals {
  flux_values = {
    "git.url"   = "git@github.com:${var.org}/${var.repo}"
    "git.readonly" = "false"
    "git.secretName" = "flux-ssh"
    "sync.state" = "git"
    "git.path" = "manifests"
    "git.pollInterval" =  "1m"
    "syncGarbageCollection.enabled" = "true"
    "manifestGeneration" = "true"
  }
}

locals {
  helmoperator_values = {
    "helm.versions"   = "v3"
    "configureRepositories.repositories[0].url" = "https://kubernetes-charts.storage.googleapis.com"
    "configureRepositories.repositories[0].name" = "stable"
    "configureRepositories.enable" = "true"
    "git.ssh.secretName" = "flux-ssh"
  }
}

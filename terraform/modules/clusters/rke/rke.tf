# Creates a RKE cluster
resource "rke_cluster" "cluster" {

  cluster_name = var.cluster-name
  ssh_key_path = "/home/alessandro/.ssh/id_rsa"

  ignore_docker_version = true

  addon_job_timeout = 60

  network {
    plugin = "canal"
  }

  ingress {
    provider = "none"
  }

  services {
    etcd {
      backup_config {
        retention      = "3"
        interval_hours = "12"
      }
    }
    kube_controller {
      extra_args = {
        feature-gates = "EphemeralContainers=true"
      }
    }

    scheduler {
      extra_args = {
        feature-gates = "EphemeralContainers=true"
      }
    }

    kubelet {
      extra_args = {
        feature-gates = "EphemeralContainers=true"
        max-pods      = 250
      }
    }

    kube_api {
      secrets_encryption_config {
        enabled = true
      }
      extra_args = {
        feature-gates = "EphemeralContainers=true"
        #encryption-provider-config = "/etc/kubernetes/encryption.yaml"
        oidc-client-id      = "spn:${var.aadserverapp_id}"
        oidc-issuer-url     = "https://sts.windows.net/${var.tenant_id}/"
        oidc-username-claim = "oid"
        oidc-groups-claim   = "groups"
      }
    }
  }

  nodes {
    address          = "cloud.stackmasters.com"
    internal_address = "192.168.178.2"
    port             = "2223"
    user             = "alessandro"
    role             = ["controlplane", "etcd", "worker"]
  }

  dynamic "nodes" {
    for_each = local.nodes

    content {
      address          = nodes.key
      internal_address = nodes.value
      user             = "alessandro"
      role             = ["worker"]
    }
  }

  authentication {
    strategy = "x509"
    sans = [
      "nas.stackmasters.com"
    ]
  }

  system_images {
    kubernetes = "rancher/hyperkube:${var.kubernetes-version}"
  }
}

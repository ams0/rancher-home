resource "local_file" "kube_cluster_yaml" {
  filename = "kubeconfig.yaml"
  content  = module.cluster.kube_config_yaml
}
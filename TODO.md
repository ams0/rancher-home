Outstanding improvements 

- [X] Switch between RKE and AKS
This needs 

- [ ] Ensure correct order when `terraform destroy`
This is rather tricky when using the kubernetes provider, as Terraform has no notion of implicit dependency of k8s resources (a namespace needs to be delete *before* the cluster itself).

- [ ] Istio 1.5
- [ ] Linkerd 2.8
- [ ] kube-virt
# A complete e2e Terraform-ed, Gitops-ed RKE cluster

## Requisites

You'll need:

- Azure CLI
- An Azure AD tenant (if you want to access the cluster after deployment), with one AD group for your Kubernetes admins
- A bunnch of VM/BM machines (I use 2 NUCs, 2 laptops and a PC) with docker preinstalled and passwordless SSH access
- Terraform :)

## Architecture

The cluster configuration is taken from https://github.com/ams0/rancher-home/tree/master/manifests; a new deploy key is added to the repo that will be used by Flux to update the manifests if you push a new image to one of the deployments. A second cluster-wide Flux controller is deployed (`fluxapps`) and a namespace-specific `flux-dev` flux controller is deployed in the `flux-dev` namespace (pointing to https://github.com/ams0/flux-dev, which is also a submodule of this repo). Warning! The latter has `syncGarbageCollection.enabled` set to true, so if you delete a manifest from the repo it will be delete from the namespace.

## Deployment

Make sure you're logged with the Azure CLI

```bash
az login --tenant <tenant id of your Azure AD tenant>
```

Terraform away:

```bash
terraform init 
terraform plan
terraform apply -auto-approve 
```

After successfuil completion, you can monitor the deployments (you should not do that! Your lack of trust in GitOps is..disturbing):

```bash
$ export KUBECONFIG=`pwd`/kubeconfig.yaml 
kubectl get pods -A
```

Should look like this:

```bash
NAMESPACE        NAME                                                  READY   STATUS      RESTARTS   AGE
cert-manager     cert-manager-8cf89d765-dvz8p                          1/1     Running     0          2m16s
cert-manager     cert-manager-cainjector-6df4b8c8d9-8x8jb              1/1     Running     0          2m17s
cert-manager     cert-manager-webhook-7759c6f49b-nffmt                 1/1     Running     0          2m17s
default          common-network-policy-operator-controller-manager-0   1/1     Running     0          2m52s
flux-dev         fluxdev-58d4dd8fb4-7ch9v                              1/1     Running     0          2m7s
flux-dev         fluxdev-memcached-85b8f9b99d-nnwh5                    1/1     Running     0          2m7s
fluxcd           flux-6cc697b69b-lcszd                                 1/1     Running     0          3m23s
fluxcd           flux-memcached-64f7865494-mj9j9                       1/1     Running     0          3m23s
fluxcd           fluxapps-75c7444566-tsqqt                             1/1     Running     0          2m12s
fluxcd           fluxapps-memcached-f97b659d6-xmmfk                    1/1     Running     0          2m12s
fluxcd           helm-operator-55869b9c9b-ph7hl                        1/1     Running     0          3m13s
ingress          nginx-ingress-controller-gtwzh                        1/1     Running     0          89s
ingress          nginx-ingress-controller-mxfj7                        1/1     Running     0          89s
ingress          nginx-ingress-controller-trz76                        1/1     Running     0          89s
ingress          nginx-ingress-default-backend-5b967cf596-f8wwk        1/1     Running     0          89s
kube-system      canal-2rs2t                                           2/2     Running     1          4m41s
kube-system      canal-bqbwp                                           2/2     Running     0          4m41s
kube-system      canal-s9958                                           2/2     Running     0          4m41s
kube-system      coredns-6f68fbf8bd-dfml5                              1/1     Running     0          4m5s
kube-system      coredns-6f68fbf8bd-k98lh                              1/1     Running     0          3m58s
kube-system      coredns-autoscaler-65bfc8d47d-gt8t7                   1/1     Running     0          4m3s
kube-system      metrics-server-6b55c64f86-db95h                       1/1     Running     0          3m40s
kube-system      rke-coredns-addon-deploy-job-8bnfk                    0/1     Completed   0          4m26s
kube-system      rke-metrics-addon-deploy-job-jqgds                    0/1     Completed   0          3m55s
kube-system      rke-network-plugin-deploy-job-ctzps                   0/1     Completed   0          4m50s
nfs-client       nfs-client-nfs-client-provisioner-7f946b7c7-89w9w     1/1     Running     0          2m5s
system-upgrade   system-upgrade-controller-64cf9d785-srpb2             1/1     Running     0          2m52s
weave            weave-scope-agent-5xg9j                               1/1     Running     0          2m52s
weave            weave-scope-agent-l7zrt                               1/1     Running     0          2m52s
weave            weave-scope-agent-xkd5f                               1/1     Running     0          2m52s
weave            weave-scope-app-597f846bbd-cc5lf                      1/1     Running     0          2m52s
weave            weave-scope-cluster-agent-5fd97b4cdb-rc2r8            1/1     Running     0          2m50s
```


Clean up with:

```bash
terraform destroy -auto-approve
```

and follow [this instructions](../github.md) to delete all the left-over Github deploy key.
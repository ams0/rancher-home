# rancher-home
A GitOps repo for my RKE cluster at home


## Prerequisites:

- Map *.stackmasters.com to the home IP
- Map ports 80->31125 and 443->30984 on the router

## Install RKE

```
rke up --config cluster.yml
```

## Install Flux and Helm Operator, pointing to this repo

```
kubectl create ns fluxcd

GHUSER=ams0
GHREPO=rancher-home

helm upgrade -i flux fluxcd/flux --wait \
--namespace fluxcd \
--set git.url="https://github.com/${GHUSER}/${GHREPO}.git" \
--set git.readonly=true \
--set sync.state=secret \
--set git.path=manifests \
--set git.pollInterval=1m

kubectl apply -f https://raw.githubusercontent.com/fluxcd/helm-operator/master/deploy/crds.yaml

helm upgrade -i helm-operator fluxcd/helm-operator --wait \
--namespace fluxcd \
--set git.ssh.secretName=flux-git-deploy \
--set configureRepositories.enable=true \
--set configureRepositories.repositories[0].name=stable \
--set configureRepositories.repositories[0].url=https://kubernetes-charts.storage.googleapis.com \
--set helm.versions=v3
```

The cluster will self-configure from the content of the `manifests/` folder.


Notes:

This PR for cert-manager (https://github.com/jetstack/cert-manager/pull/2775)

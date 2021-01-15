This is how I run a Rancher server on a VM in azure

1. Install docker and certbot-auto

2. Map a public IP to the DNS name

3. Open port 80/443

4. Get Let's Encrypt certs

```
$ sudo rm -R /etc/letsencrypt
$ sudo certbot-auto certonly --standalone -d  rancher.stackmasters.com -d  rancher.stackmasters.com -m alessandro.vozza@microsoft.com --agree-tos -n
```

5. Start rancher with docker compose

```
docker-compose up -d
```

6. Update rancher by bumping the docker image version in the compose file and:

```
docker-compose down ; docker-compose up -d
```

7. Make sure you backup `/root/rancher/data` or mount it off an Azure File for example.

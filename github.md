# Clear your repo from left-over keys

list keys

```bash
curl -s -H "Authorization: token $gh_token" https://api.github.com/repos/${gh_user}/${repo}/keys | jq .[].id
```

delete all keys

```bash
for key in `curl -s -H "Authorization: token $gh_token" https://api.github.com/repos/${gh_user}/${repo}/keys | jq .[].id`; do curl -s -H "Authorization: token $gh_token" -X DELETE https://api.github.com/repos/${gh_user}/${repo}/keys/${key} ; done
```
# helm charts

`helm dependency update`

## Repo
```bash
$ helm package sentry # build the tgz file and copy it here
$ helm repo index . # create or update the index.yaml for repo
```

# How to use it as a helm repo

You might know github has a raw view. So simply use the following:

```bash
$ helm repo add sample 'https://raw.githubusercontent.com/haxqer/charts/master/'
$ helm repo update
$ helm search sentry
```

If your repo is private you can create a "Personal access tokens" and use it like:

```bash
$ helm repo add sample 'https://MY_PRIVATE_TOKEN@raw.githubusercontent.com/haxqer/charts/master/'
```

Note: Becareful who is creating the token and what is its level of access.



## Sentry

`helm package sentry`



`


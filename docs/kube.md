# Kubernetes

## First, let's setup !

To setup `kubectl`, I used a ssh tunnel between my local host (port 6443) and the control plane (port 6443) :

`ssh -L 6443:localhost:6443 epitechusr@kube-control-pane_IP -N`

and set up my kubectl config as such :

`.kube/config`

```
apiVersion: v1
clusters:
  - cluster:
      certificate-authority-data: ****
      server: https://localhost:6443
    name: clo-902
contexts:
  - context:
      cluster: clo-902
      user: kubernetes-admin
    name: clo-902
current-context: clo-902
kind: Config
preferences: {}
users:
  - name: kubernetes-admin
    user:
      client-certificate-data: ****
      client-key-data: ****
```

Then, just switch the context to clo-902 using `kubectl config set-context clo-902` and now you can use `kubectl` to manage the cluster

## Helm

We use Helm repos (constellations) for our apps. To set it up, refer to Helm's install page.
As a rule of thumb, everytime we deploy using Helm, we make a manifest file such as this :

```
helm template ingress-nginx ingress-nginx \
 --repo https://kubernetes.github.io/ingress-nginx \
 --version "4.10.1" \
 --namespace ingress-nginx \
 -f charts/ingress-nginx.yml \
 > manifests/ingress-controller/ingress-nginx.yml
```

### Ingress Nginx

We setup Ingress-Nginx to route our different apps. For all admin tools and utilities, they will be in subdomains, so as to keep the main domain for the deployed production app

I can't seem to get a Public IP from azure since we don't have the rights, so I have port-forwarded the ingress-nginx-controller service instead to get the ingress to work, so as to keep the project going forward.

`kubectl port-forward svc/ingress-nginx-controller 8080:80 8443:443 -n ingress-nginx`

### Gitlab

Wanted to setup Gitlab instead of Kustomize, but I don't think the trouble is worth it.

I seem to be unable to install the gitlab helm chart through the `template` + `kubectl` apply method

I resorted to `helm install gitlab gitlab/gitlab -f charts/gitlab.yml`

Still CrashLooping, moving on...

### Kubernetes-Dashboard

Deployed Kubernetes-Dashboard [through helm](../kubernetes/manifests/kubernetes-dashboard/kubernetes-dashboard.yml), setup its ingress to target dashboard.localhost (will be replaced eventually by a real domain, once Public IP is worked out)

We chose to use [token-based access control](../kubernetes/manifests/kubernetes-dashboard/access-control.yml), leveraging Kubernetes' Service Account api. We created a token for the dashboard-admin user and stored it in a local secret

```
kubectl -n kubernetes-dashboard create token admin-user > token.txt
kubectl create secret generic dashboard-admin --from-file token.txt
```

### Kube-Prometheus

This is a clone of the [kube-prometheus project](https://github.com/prometheus-operator/kube-prometheus). This is loaded as a git submodule, so you need to initialize it with `git submodule init` and `git submodule update`.

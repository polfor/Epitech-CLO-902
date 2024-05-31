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
 > manifests/ingress-nginx.yml
```

### Ingress Nginx

I can't seem to get a Public IP from azure since we don't have the rights, so I have port-forwarded the ingress-nginx-controller service instead to get the ingress to work, so as to keep the project going forward.

`kubectl port-forward svc/ingress-nginx-controller 8080:80 8443:443 -n ingress-nginx`

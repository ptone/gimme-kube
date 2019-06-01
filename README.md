# Gimme Kube

When you don't want to tax your machine with minikube, and just want a quick
legit Kubernetes control plane to do some experiments with.

Create the image in your project:

```
gcloud config set project <whatever>
bash make-image.sh
```

The image creation takes a while, but lets you get your kube on faster from
then on.

To get an instance:

```
bash gimme.sh
```

Then follow the instruction to:

```
export KUBECONFIG=[CWD]/kube-box.conf
```


There is lots that could be turned into a full fledged set of args etc - but
really this is meant to be a hack tool for one to adapt as needed.

Not a Google Product

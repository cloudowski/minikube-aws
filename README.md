# Minikube on AWS EC2 instance

This setup creates ec2 instance that is ready for a single node minikube
installation.

There's a [Minishift](https://github.com/cloudowski/minishift-aws) version
available too if you'd like to install single node OpenShift (OKD actually).

# Quickstart

* Initialize terraform

```
terraform init
```

* Run `create.yaml` playbook (Ansible >= 2.5 required - terraform module is
  used)

```
ansible-playbook create.yaml
```

* Log in to your minikube your ec2 instance - use `kubeconfig.aws` file that's been generated on the server (you can findhostname in `terraform output`) and copied to your host. Now set `KUBECONFIG` and enjoy your minikube!

```
export KUBECONFIG=kubeconfig.aws
kubectl cluster-info
```


# Cleaning up

Just run `destroy.yaml` playbook.


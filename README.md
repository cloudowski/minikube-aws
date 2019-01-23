# Minikube on AWS EC2 instance

This setup creates ec2 instance that is ready for a single node minikube
installation. This can be very handy when checking something and you don't have
much power on your laptop or don't want to spin up the whole cluster.

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

**IMPORTANT**

Currently the first time you launch it abort with timeout when connecting to ec2
instance. It will be fixed later, but now you need to retry it to finish the
installation.

* Log in to your minikube your ec2 instance - use `kubeconfig.aws` file that's been generated on the server (you can findhostname in `terraform output`) and copied to your host. Now set `KUBECONFIG` and enjoy your minikube!

```
export KUBECONFIG=kubeconfig.aws
kubectl cluster-info
```


# Cleaning up

Just run `destroy.yaml` playbook.


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

* Log in to your minikube your ec2 instance - use `kubeconfig.aws` file that's been generated on the server (you can findhostname in `terraform output`) and copied to your host. Now set `KUBECONFIG` and enjoy your minikube!

```
export KUBECONFIG=kubeconfig.aws
kubectl cluster-info
```

# Additional configuration

Adding extra parameters to terraform requires re-apply and potentially will
destroy your instance. It is recommended to do it before creating your minikube
instance.

## Adding more space

### Root device

Just add a variable to terraform, for example to increase it to 20Gi:

```
echo 'root_block_size = "20"' > root-dev-ebs.auto.tfvars
```

# Cleaning up

Just run `destroy.yaml` playbook.


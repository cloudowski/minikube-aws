# Minikube on AWS EC2 instance

This setup creates ec2 instance that is ready for a single node minikube
installation.

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

* Log in to your minikube your ec2 instance - hostname can be found in `terraform output`
installation

# Cleaning up

Just run `destroy.yaml` playbook.


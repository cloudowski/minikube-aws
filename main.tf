provider "aws" {
  region = "eu-west-1"
}

##################################################################
# Data sources to get VPC, subnet, security group and AMI details
##################################################################
data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "all" {
  vpc_id = "${data.aws_vpc.default.id}"
}

data "template_file" "user_data" {
  template = "${file("${path.module}/ec2_user_data.sh")}"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

module "security_group" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "minishift-aws"
  description = "Security group for Minikube on AWS"
  vpc_id      = "${data.aws_vpc.default.id}"

  ingress_cidr_blocks = ["${var.access_ip}"]
  ingress_rules       = ["all-all"]
  egress_rules        = ["all-all"]
}

module "ec2" {
  source = "terraform-aws-modules/ec2-instance/aws"

  instance_count = 1

  name                        = "minikube-aws"
  key_name                    = "minikube-aws"
  ami                         = "${data.aws_ami.ubuntu.id}"
  instance_type               = "${var.instance_type}"
  cpu_credits                 = "unlimited"
  subnet_id                   = "${element(data.aws_subnet_ids.all.ids, 0)}"
  vpc_security_group_ids      = ["${module.security_group.this_security_group_id}"]
  associate_public_ip_address = true
  user_data                   = "${data.template_file.user_data.rendered}"

  root_block_device = [{
    volume_size = "${var.root_block_size}"
  }]
}

resource "aws_key_pair" "ec2_pubkey" {
  key_name   = "minikube-aws"
  public_key = "${file("${var.ssh_pubkey_path}")}"
}

resource "aws_volume_attachment" "this_ec2" {
  count       = "${var.instance_extra_ebs_size > 0 ? 1 : 0}"
  device_name = "/dev/sdh"
  volume_id   = "${aws_ebs_volume.this.id}"
  instance_id = "${module.ec2.id[0]}"
}

resource "aws_ebs_volume" "this" {
  count             = "${var.instance_extra_ebs_size > 0 ? 1 : 0}"
  availability_zone = "${module.ec2.availability_zone[0]}"
  size              = "${var.instance_extra_ebs_size}"
}

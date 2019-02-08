variable "access_ip" {
  description = "IP address to be whitelisted"
}

variable "ssh_pubkey_path" {
  description = "SSH public key path"
  default     = "~/.ssh/id_rsa.pub"
}

variable "instance_type" {
  default = "t3.medium"
}

variable "instance_extra_ebs_size" {
  description = "Extra storage attached to instance"
  default     = "0"
}

variable "root_block_size" {
  description = "Root block device size"
  default     = "10"
}

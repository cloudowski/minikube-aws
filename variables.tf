variable "access_ip" {
  description = "IP address to be whitelisted"
}

variable "key_name" {
  description = "SSH key name"
}

variable "instance_type" {
  default = "t3.medium"
}

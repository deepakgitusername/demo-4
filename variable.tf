variable "my_reg" {
  type = string
  default = "us-east-1"
}

variable "my_vpc" {
  type    = string
  default = "172.26.0.0/16"
}

variable "my_subnet" {
  type    = string
  default = "172.26.1.0/24"
}

variable "dns_hostnames" {
  description = "enable dns resoulution"
  type        = bool
  default     = "true"
}

variable "instance_count" {
  description = "Number of instance which will be launched"
  type        = number
  default     = "1"
}

variable "my_key" {
  type    = string
  default = "aws-terraform-key"
}

variable "my_sg" {
  type    = string
  default = "aws-terraform-sg"
}

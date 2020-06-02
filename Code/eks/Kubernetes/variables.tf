#
# Variables Configuration
#

variable "cluster-name" {
  default = "pk-terraform-eks"
  type    = string
}

variable "aws_region_name" {
  default  = "us-west-2"
  type    = string
}

variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
}

variable "vpc_subnet" {
  type = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

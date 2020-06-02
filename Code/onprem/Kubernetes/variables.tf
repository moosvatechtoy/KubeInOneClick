variable "ssh_pass" {
    type        = string
    default = "vagrant"
}

variable "ssh_user" {
    type        = string
    default = "vagrant"
}
variable "master_node_ip" {
  default = "172.42.42.100"
}
variable "worker_node_ip" {
       type = list(string)
  default = ["172.42.42.101", "172.42.42.102"]
}
variable "pod_network_range" {
  default = "192.168.0.0"
}

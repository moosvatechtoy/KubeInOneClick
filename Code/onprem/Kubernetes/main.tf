resource "null_resource" "master" {
  provisioner "file" {
    source      = "Master"
    destination = "/tmp/Master"
  }

   connection {

      type = "ssh"
      user = var.ssh_user
      host = var.master_node_ip
      password = var.ssh_pass
}
   provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/Master/*.sh",
      "/tmp/Master/setup.sh ${var.ssh_user} ${var.master_node_ip} ${var.pod_network_range}",
    ]
  }
}

resource "null_resource" "worker" {
  count  = length(var.worker_node_ip)
  provisioner "file" {
    source      = "Worker"
    destination = "/tmp/Worker"

}
    connection {
      type = "ssh"
      user = var.ssh_user
      password = var.ssh_pass
      host = element(var.worker_node_ip, count.index)
 }
   provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/Worker/*.sh",
      "/tmp/Worker/setup.sh ${var.master_node_ip} ${var.ssh_pass} ${var.ssh_user}",
    ]
  }
 depends_on = [null_resource.master]
}

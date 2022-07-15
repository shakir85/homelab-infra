resource "proxmox_vm_qemu" "vm_resource" {
  name        = var.vm_name
  desc        = var.vm_description
  target_node = "pve"
  agent       = 1

  clone      = "debian-11-generic-amd64-20220711-1073.qcow2" # to be parameterized for Centos & RHEL
  cores      = var.vm_cores
  sockets    = var.vm_sockets
  memory     = var.vm_memory
  cpu        = "host"
  # full_clone = false
  os_type    = "cloud-init"

  network {
    bridge = "vmbr0"
    model  = "virtio"
  }

  disk {
    type    = "scsi"
    storage = var.storage_pool[2]
    size    = var.disk_size
  }

  tags = "foo,bar,test"

  # Ansible playbooks execution block
  provisioner "remote-exec" {
    inline = ["echo 'Wait for SSH connection...'"]

    connection {
      type        = "ssh"
      user        = "shakir"
      host        = proxmox_vm_qemu.vm_resource.default_ipv4_address
      # private_key = tls_private_key.private_ssh_key.private_key_pem
    }
  }

  provisioner "local-exec" {
    working_dir = "../../ansible"
    interpreter = ["bash", "-c"]
    environment = {
      HOST    = "${proxmox_vm_qemu.vm_resource.default_ipv4_address}"
      # SSH_KEY = "../terraform/main.pem"
    }
    command = <<EOF
              ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ubuntu -i $HOST, docker.yml
              EOF
  }

}

# Print DHCP IP on completion
output "dhcp_ip" {
  value = proxmox_vm_qemu.vm_resource.default_ipv4_address
}

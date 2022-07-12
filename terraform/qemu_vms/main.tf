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

}

# Print DHCP IP on completion
output "dhcp_ip" {
  value = proxmox_vm_qemu.vm_resource.default_ipv4_address
}

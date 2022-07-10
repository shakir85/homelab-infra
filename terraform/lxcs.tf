resource "proxmox_lxc" "basic" {
  target_node  = "pve"
  hostname     = "lxc-basic"
  ostemplate   = "local:vztmpl/ubuntu-20.04-standard_20.04-1_amd64.tar.gz"
  password     = var.container_password
  unprivileged = true

  // Terraform will crash without rootfs defined
  // Let lxc containers use local for storage: "pvesm set local --content backup,images,iso,rootdir,snippets,vztmpl"
  rootfs {
    storage = "local"
    size    = "8G"
  }

  network {
    name   = "eth0"
    bridge = "vmbr0"
    ip     = "dhcp"
  }
}
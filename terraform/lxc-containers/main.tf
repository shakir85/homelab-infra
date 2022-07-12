resource "proxmox_lxc" "basic" {
  target_node  = "pve"
  hostname     = var.container_name
  ostemplate   = "local:vztmpl/ubuntu-20.04-standard_20.04-1_amd64.tar.gz"
  password     = var.container_password
  unprivileged = true

  // Terraform will crash without rootfs defined
  rootfs {
    // To let lxc containers use local for storage run:
    // "pvesm set local --content backup,images,iso,rootdir,snippets,vztmpl"
    storage = var.pxmx_storage
    size    = var.disk_size
  }

  network {
    name   = "eth0"
    bridge = "vmbr0"
    ip     = "dhcp"
  }

    features {
    keyctl    = true
    nesting = true
  }
}

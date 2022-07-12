variable "proxmox_api_url" {
  type = string
}

variable "proxmox_api_token_id" {
  type = string
}

variable "proxmox_api_token_secret" {
  type      = string
  sensitive = true
}

variable "container_password" {
  type      = string
  sensitive = true
}

variable "container_name" {
  type = string
}

variable "disk_size" {
  type = string
  description = "Lxc disk size [e.g. \"8G\"]"
}

variable "pxmx_storage" {
  type = string
  description = "pve storage [local, local-lvm, ssd-r10]"
}

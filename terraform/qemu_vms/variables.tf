# ---------------------------------------
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
# ---------------------------------------
variable "vm_name" {
  type = string
}

variable "vm_description" {
  type = string
}

variable "storage_pool" {
  type    = list(string)
  default = ["local", "local-lvm", "ssd-r10"]
}

variable "disk_size" {
  description = "VM disk size [e.g. \"8G\"]"
}

variable "vm_cores" {
}

variable "vm_sockets" {
}

variable "vm_memory" {
}

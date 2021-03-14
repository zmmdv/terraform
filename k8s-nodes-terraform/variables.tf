### Main nodes Variables ###

variable "vcenter_user" {
  type = string
}

variable "vcenter_password" {
  type = string
}

variable "vcenter_ip" {
  type = string
}

variable "vcenter_datacenter" {
  type = string
}

variable "vcenter_datastore" {
  type = string
}

variable "vcenter_cluster" {
  type = string
}

variable "template" {
  type = string
}

variable "vm_guest_id" {
  type = string
}

variable "vm_network_adapter_type" {
  type = string
}

variable "vm_domain" {
  type = string
}

variable "dns_servers" {
  type = list(string)
}

### Master Nodes Variables ###

variable "master_node_count" {
  type = number
}

variable "masters_vcenter_network" {
  type = string
}

variable "master_node_name" {
  type = string
}

variable "master_nodes_folder" {
  type = string
}

variable "master_node_cpu" {
  type = number
}

variable "master_node_cpu_per_socket" {
  type = number
}

variable "master_node_memory" {
  type = number
}

variable "master_node_memory_limit" {
  type = number
}

variable "masters_disk_label" {
  type = string
}

variable "masters_disk_size" {
  type = number
}

variable "masters_disk_thin_provisioned" {
  type = string
}

variable "master_node_hostname" {
  type = string
}

variable "timezone" {
  type = string
}

variable "master_node_ip" {
  type = string
}

variable "masters_ipv4_netmask" {
  type = number
}

variable "masters_default_gateway" {
  type = string
}


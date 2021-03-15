############################
### Main nodes Variables ###
############################

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

# variable "vcenter_datastore_cluster" {
#   type = string
# }


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

variable "project_folder" {
  type = string
}

variable "masters_folder" {
  type = string
}

variable "workers_folder" {
  type = string
}

variable "etcds_folder" {
  type = string
}

variable "cephs_folder" {
  type = string
}

variable "playbook_yaml" {
  type = string
}

variable "hosts_file" {
  type = string
}

###############################
### Masters Nodes Variables ###
###############################

variable "masters_node_count" {
  type = number
}

variable "masters_vcenter_network" {
  type = string
}

variable "masters_node_name" {
  type = list(string)
}

variable "masters_node_cpu" {
  type = number
}

variable "masters_node_cpu_per_socket" {
  type = number
}

variable "masters_node_memory" {
  type = number
}

variable "masters_node_memory_limit" {
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

variable "masters_node_hostname" {
  type = list(string)
}

variable "timezone" {
  type = string
}

variable "masters_node_ip" {
  type = list(string)
}

variable "masters_ipv4_netmask" {
  type = number
}

variable "masters_default_gateway" {
  type = string
}

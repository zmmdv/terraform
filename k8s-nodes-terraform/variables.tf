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
  type = string
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
  type = string
}

variable "timezone" {
  type = string
}

variable "masters_node_ip" {
  type = string
}

variable "masters_ipv4_netmask" {
  type = number
}

variable "masters_default_gateway" {
  type = string
}


###############################
### Workers Nodes Variables ###
###############################


variable "workers_vcenter_network" {
  type = string
}

variable "workers_node_name" {
  type = string
}


variable "workers_node_cpu" {
  type = number
}

variable "workers_node_cpu_per_socket" {
  type = number
}

variable "workers_node_memory" {
  type = number
}

variable "workers_node_memory_limit" {
  type = number
}

variable "workers_node_count" {
  type = number
}

variable "workers_disk_label" {
  type = string
}

variable "workers_disk_size" {
  type = number
}

variable "workers_disk_thin_provisioned" {
  type = string
}

variable "workers_node_hostname" {
  type = string
}

variable "workers_node_ip" {
  type = string
}

variable "workers_ipv4_netmask" {
  type = string
}

variable "workers_default_gateway" {
  type = string
}


###############################
### Etcd Nodes Variables ###
###############################

variable "etcds_vcenter_network" {
  type = string
}

variable "etcds_node_name" {
  type = string
}

variable "etcds_node_cpu" {
  type = number
}

variable "etcds_node_cpu_per_socket" {
  type = number
}

variable "etcds_node_memory" {
  type = number
}

variable "etcds_node_memory_limit" {
  type = number
}

variable "etcds_node_count" {
  type = number
}

variable "etcds_first_disk_label" {
  type = string
}

variable "etcds_first_disk_size" {
  type = number
}

variable "etcds_second_disk_label" {
  type = string
}

variable "etcds_second_disk_size" {
  type = number
}

variable "etcds_disk_thin_provisioned" {
  type = string
}

variable "etcds_node_hostname" {
  type = string
}

variable "etcds_node_ip" {
  type = string
}

variable "etcds_ipv4_netmask" {
  type = string
}

variable "etcds_default_gateway" {
  type = string
}

############################
### Ceph Nodes Variables ###
############################

variable "cephs_vcenter_network" {
  type = string
}

variable "cephs_node_name" {
  type = string
}

variable "cephs_node_cpu" {
  type = number
}

variable "cephs_node_cpu_per_socket" {
  type = number
}

variable "cephs_node_memory" {
  type = number
}

variable "cephs_node_memory_limit" {
  type = number
}

variable "cephs_node_count" {
  type = number
}

variable "cephs_first_disk_label" {
  type = string
}

variable "cephs_first_disk_size" {
  type = number
}

variable "cephs_second_disk_label" {
  type = string
}

variable "cephs_second_disk_size" {
  type = number
}

variable "cephs_disk_thin_provisioned" {
  type = string
}

variable "cephs_node_hostname" {
  type = string
}

variable "cephs_node_ip" {
  type = string
}

variable "cephs_ipv4_netmask" {
  type = string
}

variable "cephs_default_gateway" {
  type = string
}

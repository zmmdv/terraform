###########################
### Main Customizations ###
###########################

vcenter_user = ""
vcenter_password = ""
vcenter_ip = ""
vcenter_datacenter = ""
vcenter_datastore = ""
vcenter_cluster = ""
template = ""
vm_guest_id = "ubuntu64Guest"
vm_network_adapter_type = "vmxnet3"
vm_domain = "local"
dns_servers = ["8.8.8.8"]
timezone = "Asia/Baku"

###################################
### Workers Nodes Customization ###
###################################

workers_vcenter_network = ""
workers_node_name = "WORKER"
workers_nodes_folder = ""
workers_node_cpu = "4"
workers_node_cpu_per_socket = "2"
workers_node_memory = "4096"
workers_node_memory_limit = "4096"
workers_node_count = "3"
workers_disk_label = "disk0"
workers_disk_size = "60"
workers_disk_thin_provisioned = "true"
workers_node_hostname = "worker"
workers_node_ip = ""
workers_ipv4_netmask = "24"
workers_default_gateway = ""

###################################
### Masters Nodes Customization ###
###################################

masters_node_count = "3"
masters_vcenter_network = ""
masters_node_name = "MASTER"
masters_nodes_folder = ""
masters_node_cpu = "4"
masters_node_cpu_per_socket = "2"
masters_node_memory = "4096"
masters_node_memory_limit = "4096"
masters_disk_label = "disk0"
masters_disk_size = "60"
masters_disk_thin_provisioned = "true"
masters_node_hostname = "master"
masters_node_ip = ""
masters_ipv4_netmask = "24"
masters_default_gateway = ""

################################
### ETCD Nodes Customization ###
################################
etcds_node_count = "5"
etcds_vcenter_network = ""
etcds_node_name = "ETCD"
etcds_nodes_folder = ""
etcds_node_cpu = "4"
etcds_node_cpu_per_socket = "2"
etcds_node_memory = "4096"
etcds_node_memory_limit = "4096"
etcds_first_disk_label = "disk0"
etcds_second_disk_label = "disk1"
etcds_first_disk_size = "60"
etcds_second_disk_size = "40"
etcds_disk_thin_provisioned = "true"
etcds_node_hostname = "etcd"
etcds_node_ip = ""
etcds_ipv4_netmask = "24"
etcds_default_gateway = ""

################################
### Ceph Nodes Customization ###
################################

cephs_node_count = "3"
cephs_vcenter_network = ""
cephs_node_name = "CEPH"
cephs_nodes_folder = ""
cephs_node_cpu = "4"
cephs_node_cpu_per_socket = "2"
cephs_node_memory = "4096"
cephs_node_memory_limit = "4096"
cephs_first_disk_label = "disk0"
cephs_second_disk_label = "disk1"
cephs_first_disk_size = "60"
cephs_second_disk_size = "250"
cephs_disk_thin_provisioned = "true"
cephs_node_hostname = "ceph"
cephs_node_ip = ""
cephs_ipv4_netmask = "24"
cephs_default_gateway = ""
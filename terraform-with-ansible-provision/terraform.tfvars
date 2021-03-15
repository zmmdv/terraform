###########################
### Main Customizations ###
###########################

vcenter_user = ""
vcenter_password = ""
vcenter_ip = ""
vcenter_datacenter = ""
vcenter_datastore = ""
vcenter_cluster = ""

#############################################

project_folder = "TEST/TEST-PROJECT"
masters_folder = "CONTROL-PLANES"
workers_folder = "NODES"
etcds_folder = "ETCDS"
cephs_folder = "CEPHS"

#############################################

template = "UBUNTU-2004-TMP"
vm_guest_id = "ubuntu64Guest"
vm_network_adapter_type = "vmxnet3"
vm_domain = "local"
dns_servers = ["8.8.8.8"]
timezone = "Asia/Baku"

####################
### Ansible spec ###
####################
playbook_yaml = "./k8s.yaml"
hosts_file = "./hosts"

###################################
### Masters Nodes Customization ###
###################################

masters_node_count = "3"
masters_vcenter_network = ""
masters_node_name = ["MASTER"]
masters_node_cpu = "4"
masters_node_cpu_per_socket = "2"
masters_node_memory = "4096"
masters_node_memory_limit = "4096"
masters_disk_label = "disk0"
masters_disk_size = "60"
masters_disk_thin_provisioned = "true"
masters_node_hostname = ["master"]
masters_node_ip = [""]
masters_ipv4_netmask = "24"
masters_default_gateway = ""
#####################
### Main settings ###
#####################

provider "vsphere" {
  user = var.vcenter_user
  password = var.vcenter_password
  vsphere_server = var.vcenter_ip
  allow_unverified_ssl = true
}

data "vsphere_datacenter" "datacenter" {
  name = var.vcenter_datacenter
}

data "vsphere_datastore" "datastore" {
  name          = var.vcenter_datastore
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

# data "vsphere_datastore_cluster" "datastore_cluster" {
#   name          = var.vcenter_datastore_cluster
#   datacenter_id = data.vsphere_datacenter.datacenter.id
# }

data "vsphere_compute_cluster" "cluster" {
  name          = var.vcenter_cluster
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_virtual_machine" "template" {
  name          = var.template
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

####################################
### Separate network for Masters ###
####################################

data "vsphere_network" "masters_network" {
  name          = var.masters_vcenter_network
  datacenter_id = data.vsphere_datacenter.datacenter.id
}


######################################
### Folders for all infrastructure ###
######################################

resource "vsphere_folder" "project" {
  path          = var.project_folder
  type          = "vm"
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

resource "vsphere_folder" "masters" {
  path          = "${vsphere_folder.project.path}/${var.masters_folder}"
  type          = "vm"
  datacenter_id = data.vsphere_datacenter.datacenter.id
  depends_on = [ vsphere_folder.project ]
}


#################################
### Resource for Master Nodes ###
#################################

resource "vsphere_virtual_machine" "masters" {
  name             = var.masters_node_name[count.index]
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  # datastore_cluster_id     = data.vsphere_datastore_cluster.datastore_cluster.id
  datastore_id     = data.vsphere_datastore.datastore.id
  folder = "${vsphere_folder.project.path}/${var.masters_folder}"
  num_cpus = var.masters_node_cpu
  num_cores_per_socket = var.masters_node_cpu_per_socket
  cpu_hot_add_enabled = true
  cpu_hot_remove_enabled = true
  memory_hot_add_enabled = true
  memory   = var.masters_node_memory
  memory_limit = var.masters_node_memory_limit
  guest_id = var.vm_guest_id
  count = var.masters_node_count
  depends_on = [ vsphere_folder.masters ]
  
  provisioner "ansible" {
    plays {
      playbook {
        file_path = var.playbook_yaml
    }
    inventory_file = var.hosts_file
    }
  }
    

  network_interface {
    network_id   = data.vsphere_network.masters_network.id
    adapter_type = var.vm_network_adapter_type
  }

  disk {
    label            = var.masters_disk_label
    size             = var.masters_disk_size
    thin_provisioned = var.masters_disk_thin_provisioned
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id

    customize {
      linux_options {
        host_name = var.masters_node_hostname[count.index]
        domain    = var.vm_domain
        time_zone  = var.timezone
      }

      network_interface {
        ipv4_address = var.masters_node_ip[count.index]
        ipv4_netmask = var.masters_ipv4_netmask
      }

      dns_server_list = var.dns_servers
      ipv4_gateway = var.masters_default_gateway      

    }
  }
}

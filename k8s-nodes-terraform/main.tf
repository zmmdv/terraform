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

####################################
### Separate network for Workers ###
####################################

data "vsphere_network" "workers_network" {
  name          = var.workers_vcenter_network
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

resource "vsphere_folder" "workers" {
  path          = "${vsphere_folder.project.path}/${var.workers_folder}"
  type          = "vm"
  datacenter_id = data.vsphere_datacenter.datacenter.id
  depends_on = [ vsphere_folder.project ]
}

resource "vsphere_folder" "etcds" {
  path          = "${vsphere_folder.project.path}/${var.etcds_folder}"
  type          = "vm"
  datacenter_id = data.vsphere_datacenter.datacenter.id
  depends_on = [ vsphere_folder.project ]
}

resource "vsphere_folder" "cephs" {
  path          = "${vsphere_folder.project.path}/${var.cephs_folder}"
  type          = "vm"
  datacenter_id = data.vsphere_datacenter.datacenter.id
  depends_on = [ vsphere_folder.project ]
}

##################################
### Separate network for Etcds ###
##################################

data "vsphere_network" "etcds_network" {
  name          = var.etcds_vcenter_network
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

##################################
### Separate network for Cephs ###
##################################

data "vsphere_network" "cephs_network" {
  name          = var.cephs_vcenter_network
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

#################################
### Resource for Master Nodes ###
#################################

resource "vsphere_virtual_machine" "masters" {
  name             = "${var.masters_node_name}${count.index + 1}"
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
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
        host_name = "${var.masters_node_hostname}${count.index + 1}"
        domain    = var.vm_domain
        time_zone  = var.timezone
      }

      network_interface {
        ipv4_address = "${var.masters_node_ip}${count.index + 1}"
        ipv4_netmask = var.masters_ipv4_netmask
      }

      dns_server_list = var.dns_servers
      ipv4_gateway = var.masters_default_gateway      

    }
  }
}

#################################
### Resource for Worker Nodes ###
#################################

resource "vsphere_virtual_machine" "workers" {
  name             = "${var.workers_node_name}${count.index + 1}"
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id
  folder = "${vsphere_folder.project.path}/${var.workers_folder}"
  num_cpus = var.workers_node_cpu
  num_cores_per_socket = var.workers_node_cpu_per_socket
  cpu_hot_add_enabled = true
  cpu_hot_remove_enabled = true
  memory_hot_add_enabled = true
  memory   = var.workers_node_memory
  memory_limit = var.workers_node_memory_limit
  guest_id = var.vm_guest_id
  count = var.workers_node_count
  depends_on = [ vsphere_folder.workers ]

  network_interface {
    network_id   = data.vsphere_network.workers_network.id
    adapter_type = var.vm_network_adapter_type
  }

  disk {
    label            = var.workers_disk_label
    size             = var.workers_disk_size
    thin_provisioned = var.workers_disk_thin_provisioned
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id

    customize {
      linux_options {
        host_name = "${var.workers_node_hostname}${count.index + 1}"
        domain    = var.vm_domain
        time_zone  = var.timezone
      }

      network_interface {
        ipv4_address = "${var.workers_node_ip}${count.index + 1}"
        ipv4_netmask = var.workers_ipv4_netmask
      }

      dns_server_list = var.dns_servers
      ipv4_gateway = var.workers_default_gateway      

    }
  }
}

#################################
### Resource for Etcd Nodes ###
#################################

resource "vsphere_virtual_machine" "etcds" {
  name             = "${var.etcds_node_name}${count.index + 1}"
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id
  folder = "${vsphere_folder.project.path}/${var.etcds_folder}"
  num_cpus = var.etcds_node_cpu
  num_cores_per_socket = var.etcds_node_cpu_per_socket
  cpu_hot_add_enabled = true
  cpu_hot_remove_enabled = true
  memory_hot_add_enabled = true
  memory   = var.etcds_node_memory
  memory_limit = var.etcds_node_memory_limit
  guest_id = var.vm_guest_id
  count = var.etcds_node_count
  depends_on = [ vsphere_folder.etcds ]

  network_interface {
    network_id   = data.vsphere_network.etcds_network.id
    adapter_type = var.vm_network_adapter_type
  }

  disk {
    label            = var.etcds_first_disk_label
    size             = var.etcds_first_disk_size
    thin_provisioned = var.etcds_disk_thin_provisioned
  }

  disk {
    label            = var.etcds_second_disk_label
    size             = var.etcds_second_disk_size
    thin_provisioned = var.etcds_disk_thin_provisioned
    unit_number      = "1"
  }  

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id

    customize {
      linux_options {
        host_name = "${var.etcds_node_hostname}${count.index + 1}"
        domain    = var.vm_domain
        time_zone  = var.timezone
      }

      network_interface {
        ipv4_address = "${var.etcds_node_ip}${count.index + 1}"
        ipv4_netmask = var.etcds_ipv4_netmask
      }

      dns_server_list = var.dns_servers
      ipv4_gateway = var.etcds_default_gateway      

    }
  }
}

###############################
### Resource for Ceph Nodes ###
###############################

resource "vsphere_virtual_machine" "cephs" {
  name             = "${var.cephs_node_name}${count.index + 1}"
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id
  folder = "${vsphere_folder.project.path}/${var.cephs_folder}"
  num_cpus = var.cephs_node_cpu
  num_cores_per_socket = var.cephs_node_cpu_per_socket
  cpu_hot_add_enabled = true
  cpu_hot_remove_enabled = true
  memory_hot_add_enabled = true  
  memory   = var.cephs_node_memory
  memory_limit = var.cephs_node_memory_limit
  guest_id = var.vm_guest_id
  count = var.cephs_node_count
  depends_on = [ vsphere_folder.cephs ]

  network_interface {
    network_id   = data.vsphere_network.cephs_network.id
    adapter_type = var.vm_network_adapter_type
  }

  disk {
    label            = var.cephs_first_disk_label
    size             = var.cephs_first_disk_size
    thin_provisioned = var.cephs_disk_thin_provisioned
  }

  disk {
    label            = var.cephs_second_disk_label
    size             = var.cephs_second_disk_size
    thin_provisioned = var.cephs_disk_thin_provisioned
    unit_number      = "1"
  } 

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id

    customize {
      linux_options {
        host_name = "${var.cephs_node_hostname}${count.index + 1}"
        domain    = var.vm_domain
        time_zone  = var.timezone
      }

      network_interface {
        ipv4_address = "${var.cephs_node_ip}${count.index + 1}"
        ipv4_netmask = var.cephs_ipv4_netmask
      }

      dns_server_list = var.dns_servers
      ipv4_gateway = var.cephs_default_gateway      

    }
  }
}
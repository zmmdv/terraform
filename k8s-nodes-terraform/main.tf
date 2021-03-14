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

data "vsphere_network" "masters_network" {
  name          = var.masters_vcenter_network
  datacenter_id = data.vsphere_datacenter.datacenter.id
}


data "vsphere_virtual_machine" "template" {
  name          = var.template
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

resource "vsphere_virtual_machine" "master" {
  name             = "${var.master_node_name}${count.index + 1}"
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id
  folder = var.master_nodes_folder
  num_cpus = var.master_node_cpu
  num_cores_per_socket = var.master_node_cpu_per_socket
  memory   = var.master_node_memory
  memory_limit = var.master_node_memory_limit
  guest_id = var.vm_guest_id
  count = var.master_node_count


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
        host_name = "${var.master_node_hostname}${count.index + 1}"
        domain    = var.vm_domain
        time_zone  = var.timezone
      }

      network_interface {
        ipv4_address = "${var.master_node_ip}${count.index + 1}"
        ipv4_netmask = var.masters_ipv4_netmask
      }

      dns_server_list = var.dns_servers
      ipv4_gateway = var.masters_default_gateway      

    }
  }
}

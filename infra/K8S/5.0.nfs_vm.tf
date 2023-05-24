module "nfs_vm" {
  source = "./modules/freeVM"

  instance_os           = var.instance_os
  linux_os_version      = var.linux_os_version
  compartment_id        = local.compartment_id
  public_keys           = var.public_keys
  instance_display_name = "nfs"
  subnet_id             = oci_core_subnet.nfs_subnet.id
  availability_domain   = local.availability_domain
  assign_public_ip      = false
  private_ip            = "10.0.100.100"
  nsg_id                = oci_core_network_security_group.nfs_nsg.id
}


# NSG
resource "oci_core_network_security_group" "nfs_nsg" {
  compartment_id = local.compartment_id
  vcn_id         = module.vcn.vcn_id

  display_name = "For_nfs"
}

# Ingress
## SSH
resource "oci_core_network_security_group_security_rule" "nfs_22" {
  network_security_group_id = oci_core_network_security_group.nfs_nsg.id
  direction                 = "INGRESS"
  protocol                  = 6

  source_type = "CIDR_BLOCK"
  source      = "10.0.10.0/24"
  #    stateless = var.network_security_group_security_rule_stateless
  tcp_options {
    destination_port_range {
      #Required
      max = 22
      min = 22
    }
  }
}

## NFS
resource "oci_core_network_security_group_security_rule" "nfs_2049" {
  network_security_group_id = oci_core_network_security_group.nfs_nsg.id
  direction                 = "INGRESS"
  protocol                  = 6

  source_type = "CIDR_BLOCK"
  source      = "10.0.0.0/8"
  #    stateless = var.network_security_group_security_rule_stateless
  tcp_options {
    destination_port_range {
      #Required
      max = 2049
      min = 2049
    }
  }
}


resource "oci_core_network_security_group_security_rule" "nfs_icmp" {
  network_security_group_id = oci_core_network_security_group.nfs_nsg.id
  direction                 = "INGRESS"
  protocol                  = 1

  icmp_options {
    #Required
    type = "0"
  }
  source_type = "CIDR_BLOCK"
  source      = "10.0.0.0/8"
}

# Egress
resource "oci_core_network_security_group_security_rule" "nfs_egress_all" {
  network_security_group_id = oci_core_network_security_group.nfs_nsg.id
  direction                 = "EGRESS"
  protocol                  = "all"

  destination      = "0.0.0.0/0"
  destination_type = "CIDR_BLOCK"
}


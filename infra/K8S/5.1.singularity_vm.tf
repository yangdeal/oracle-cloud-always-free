module "singularity_vm" {
  source = "./modules/freeVM"

  instance_os           = var.instance_os
  linux_os_version      = var.linux_os_version
  compartment_id        = local.compartment_id
  public_keys           = var.public_keys
  instance_display_name = "singularity"
  subnet_id             = oci_core_subnet.vcn_singularity_subnet.id
  availability_domain   = local.availability_domain
  assign_public_ip      = true
  nsg_id                = oci_core_network_security_group.singularity_network_security_group.id
}

output "singularity_ip" {
  value = module.singularity_vm.public_ip
}

resource "oci_core_network_security_group" "singularity_network_security_group" {
  compartment_id = local.compartment_id
  vcn_id         = module.vcn.vcn_id

  display_name = "For_singularity"
}

# Ingress
resource "oci_core_network_security_group_security_rule" "singularity_22" {
  network_security_group_id = oci_core_network_security_group.singularity_network_security_group.id
  direction                 = "INGRESS"
  protocol                  = 6

  source_type = "CIDR_BLOCK"
  source      = "0.0.0.0/0"
  #    stateless = var.network_security_group_security_rule_stateless
  tcp_options {
    destination_port_range {
      #Required
      max = 22
      min = 22
    }
  }
}

resource "oci_core_network_security_group_security_rule" "singularity_61022" {
  network_security_group_id = oci_core_network_security_group.singularity_network_security_group.id
  direction                 = "INGRESS"
  protocol                  = 6
  #
  #    icmp_options {
  #        #Required
  #        type = "0"
  #    }
  source_type = "CIDR_BLOCK"
  source      = "0.0.0.0/0"
  #    stateless = var.network_security_group_security_rule_stateless
  tcp_options {
    destination_port_range {
      #Required
      max = 61022
      min = 61022
    }
  }
}

resource "oci_core_network_security_group_security_rule" "singularity_icmp" {
  network_security_group_id = oci_core_network_security_group.singularity_network_security_group.id
  direction                 = "INGRESS"
  protocol                  = 1

  icmp_options {
    #Required
    type = "0"
  }
  source_type = "CIDR_BLOCK"
  source      = "0.0.0.0/0"
}

# Egress
resource "oci_core_network_security_group_security_rule" "singularity_egress_all" {
  network_security_group_id = oci_core_network_security_group.singularity_network_security_group.id
  direction                 = "EGRESS"
  protocol                  = "all"

  destination      = "0.0.0.0/0"
  destination_type = "CIDR_BLOCK"
}


# Public subnet
resource "oci_core_subnet" "protected_subnet" {
  #Required
  cidr_block                 = "172.16.1.0/24"
  compartment_id             = var.compartment_id
  vcn_id                     = oci_core_vcn.my_vcn.id
  display_name               = "protected_subnet"
  route_table_id             = oci_core_route_table.my_RT.id
  prohibit_public_ip_on_vnic = false

  security_list_ids = [
    oci_core_security_list.protected_subnet_security_list.id,
  ]
}


resource oci_core_security_list protected_subnet_security_list {
  compartment_id = var.compartment_id

  display_name = "protected_subnet_security_list"
  freeform_tags = {
  }
  ingress_security_rules {
    description = "Allow "
    protocol    = "6"
    source      = "172.16.0.0/16"
    source_type = "CIDR_BLOCK"
    stateless   = "false"
    tcp_options {
      max = "22"
      min = "22"
    }
  }

  ingress_security_rules {
    # ICMP
    description = "Allow "
    protocol    = "1"
    source      = "172.16.0.0/16"
    source_type = "CIDR_BLOCK"
    stateless   = "false"
  }

  egress_security_rules {
    destination = "0.0.0.0/0"
    protocol = "all"
  }
  vcn_id = oci_core_vcn.my_vcn.id
}
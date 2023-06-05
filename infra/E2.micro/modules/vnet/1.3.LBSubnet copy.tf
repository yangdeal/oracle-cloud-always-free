# Public subnet
resource "oci_core_subnet" "loadbalancer_subnet" {
  #Required
  cidr_block                 = "172.16.2.0/24"
  compartment_id             = var.compartment_id
  vcn_id                     = oci_core_vcn.my_vcn.id
  display_name               = "loadbalancer_subnet"
  route_table_id             = oci_core_route_table.my_RT.id
  prohibit_public_ip_on_vnic = false

  security_list_ids = [
    oci_core_security_list.loadbalancer_subnet_security_list.id,
  ]
}


resource "oci_core_security_list" "loadbalancer_subnet_security_list" {
  compartment_id = var.compartment_id

  display_name = "loadbalancer_subnet_security_list"
  freeform_tags = {
  }
  ingress_security_rules {
    description = "Allow "
    protocol    = "6"
    source      = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    stateless   = "false"
    tcp_options {
      max = "80"
      min = "80"
    }
  }

  ingress_security_rules {
    description = "Allow "
    protocol    = "6"
    source      = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    stateless   = "false"
    tcp_options {
      max = "443"
      min = "443"
    }
  }

  egress_security_rules {
    destination      = "172.16.0.0/16"
    protocol         = "6"
    destination_type = "CIDR_BLOCK"
    stateless        = "false"
    tcp_options {
      max = "80"
      min = "80"
    }
  }

  egress_security_rules {
    destination      = "172.16.0.0/16"
    protocol         = "6"
    destination_type = "CIDR_BLOCK"
    stateless        = "false"
    tcp_options {
      max = "443"
      min = "443"
    }
  }

  vcn_id = oci_core_vcn.my_vcn.id
}
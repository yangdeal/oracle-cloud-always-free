resource "oci_core_security_list" "private_subnet_sl" {
  compartment_id = local.compartment_id
  vcn_id         = module.vcn.vcn_id

  display_name = "free-k8s-private-subnet-sl"

  egress_security_rules {
    stateless        = false
    destination      = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
    protocol         = "all"
  }

  ingress_security_rules {
    stateless   = false
    source      = "10.0.0.0/16"
    source_type = "CIDR_BLOCK"
    protocol    = "all"
  }

}

resource "oci_core_subnet" "vcn_private_subnet" {
  compartment_id = local.compartment_id
  vcn_id         = module.vcn.vcn_id
  cidr_block     = "10.0.1.0/24"

  route_table_id             = module.vcn.nat_route_id
  security_list_ids          = [oci_core_security_list.private_subnet_sl.id]
  display_name               = "free-k8s-private-subnet"
  prohibit_public_ip_on_vnic = true
}

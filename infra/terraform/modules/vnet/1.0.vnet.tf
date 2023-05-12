# VCN and Internet Gateway
resource "oci_core_vcn" "my_vcn" {
  cidr_block     = "172.16.0.0/22"
  compartment_id = var.compartment_id
  display_name   = "free-vcn"
  dns_label      = var.compartment_name
}

resource "oci_core_internet_gateway" "my_IG" {
  compartment_id = var.compartment_id
  display_name   = "my_IG"
  vcn_id         = oci_core_vcn.my_vcn.id
}

resource "oci_core_route_table" "my_RT" {
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.my_vcn.id
  display_name   = "MyRouteTable"
  route_rules {
    destination       = "0.0.0.0/0"
    network_entity_id = oci_core_internet_gateway.my_IG.id
  }
}

resource "oci_core_subnet" "vcn_singularity_subnet" {
  compartment_id = local.compartment_id
  vcn_id         = module.vcn.vcn_id
  cidr_block     = "10.0.10.0/24"

  route_table_id = module.vcn.ig_route_id
  display_name   = "singularity-subnet"
}

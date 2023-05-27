resource "oci_core_subnet" "nfs_subnet" {
  compartment_id = local.compartment_id
  vcn_id         = module.vcn.vcn_id
  cidr_block     = "10.0.100.0/24"

  route_table_id = module.vcn.nat_route_id
  display_name   = "nfs-subnet"
}

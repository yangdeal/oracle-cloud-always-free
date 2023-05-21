resource "oci_load_balancer_load_balancer" "k8s_alb" {
  compartment_id = local.compartment_id
  display_name   = "k8s_alb"
  freeform_tags = {
  }
  ip_mode    = "IPV4"
  is_private = "false"
  network_security_group_ids = [
  ]
  shape = "flexible"
  shape_details {
    maximum_bandwidth_in_mbps = "10"
    minimum_bandwidth_in_mbps = "10"
  }
  subnet_ids = [
    oci_core_subnet.vcn_public_subnet.id
  ]
}

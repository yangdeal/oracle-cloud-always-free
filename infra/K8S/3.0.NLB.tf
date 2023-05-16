#resource "oci_network_load_balancer_network_load_balancer" "free_nlb" {
#  compartment_id = local.compartment_id
#  display_name   = "free-k8s-nlb"
#  subnet_id      = oci_core_subnet.vcn_public_subnet.id
#
#  is_private                     = false
#  is_preserve_source_destination = false
#  nlb_ip_version                 = "IPV4"
#}
#
#resource "oci_network_load_balancer_backend_set" "free_nlb_backend_set" {
#  health_checker {
#    protocol = "TCP"
#    port     = 10256
#  }
#  name                     = "free-k8s-backend-set"
#  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.free_nlb.id
#  policy                   = "FIVE_TUPLE"
#  is_preserve_source       = false
#}
#
#resource "oci_network_load_balancer_backend" "free_nlb_backend" {
#  count                    = length(local.active_nodes)
#  backend_set_name         = oci_network_load_balancer_backend_set.free_nlb_backend_set.name
#  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.free_nlb.id
#  port                     = 31600
#  target_id                = local.active_nodes[count.index].id
#}
#
#resource "oci_network_load_balancer_listener" "free_nlb_listener" {
#  default_backend_set_name = oci_network_load_balancer_backend_set.free_nlb_backend_set.name
#  name                     = "free-k8s-nlb-listener"
#  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.free_nlb.id
#  port                     = "80"
#  protocol                 = "TCP"
#}
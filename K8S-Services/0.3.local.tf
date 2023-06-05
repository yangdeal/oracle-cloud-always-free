locals {
  compartment_id      = data.oci_identity_availability_domains.ads.compartment_id
#  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
  k8s_backend_node_ips = [
    data.oci_containerengine_node_pool.k8s_node_pool.nodes[0].private_ip,
    data.oci_containerengine_node_pool.k8s_node_pool.nodes[1].private_ip
  ]

  node_pool_id=data.oci_containerengine_node_pools.k8s_node_pools.node_pools[0]["id"]

  name_space_lower_case = lower(var.name_space)
  services_yaml         = yamldecode(file("../01-configure/services.yaml"))
}

data "oci_load_balancer_load_balancers" "k8s_load_balancers" {
    #Required
    compartment_id = local.compartment_id

#    #Optional
    display_name = "k8s_alb"
}

output "ips" {
  value = local.k8s_backend_node_ips
}
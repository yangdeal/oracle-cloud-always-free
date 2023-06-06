locals {
  compartment_id      = data.oci_identity_availability_domains.ads.compartment_id
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
  k8s_backend_node_ips = [
    oci_containerengine_node_pool.k8s_node_pool.nodes[0].private_ip,
    oci_containerengine_node_pool.k8s_node_pool.nodes[1].private_ip
  ]

  name_space_lower_case = lower(var.name_space)
}

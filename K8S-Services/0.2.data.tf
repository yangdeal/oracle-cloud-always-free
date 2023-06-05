data "oci_identity_availability_domains" "ads" {
  compartment_id = var.tenancy_ocid
}

data "oci_containerengine_node_pool" "k8s_node_pool" {
    #Required
    node_pool_id = local.node_pool_id
}

data "oci_containerengine_node_pools" "k8s_node_pools" {
    #Required
    compartment_id = local.compartment_id
    name = var.node_pool_name
}


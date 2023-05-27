# data "oci_identity_availability_domains" "ads" {
#   compartment_id = local.compartment_id
# }

resource "oci_containerengine_node_pool" "k8s_node_pool" {
  cluster_id         = oci_containerengine_cluster.k8s_cluster.id
  compartment_id     = local.compartment_id
  kubernetes_version = "v1.26.2"
  name               = "free-k8s-node-pool"
  node_config_details {
    placement_configs {
      availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
      subnet_id           = oci_core_subnet.vcn_private_subnet.id
    }
    #     placement_configs {
    #       availability_domain = data.oci_identity_availability_domains.ads.availability_domains[1].name
    #       subnet_id           = oci_core_subnet.vcn_private_subnet.id
    #     }
    #     placement_configs {
    #       availability_domain = data.oci_identity_availability_domains.ads.availability_domains[2].name
    #       subnet_id           = oci_core_subnet.vcn_private_subnet.id
    #     }
    size = 2


  }
  node_shape = "VM.Standard.A1.Flex"

  node_shape_config {
    memory_in_gbs = 12
    ocpus         = 2
  }

  node_source_details {
    image_id    = "ocid1.image.oc1.ap-melbourne-1.aaaaaaaaq35ek7jz3blxzemznhp3m3spsjkyzcudhjkq3xd3iyrt2yyvopra"
    source_type = "image"
  }

  initial_node_labels {
    key   = "name"
    value = "free-k8s-cluster"
  }

  ssh_public_key = var.public_keys
}

locals {
  active_nodes = [for node in oci_containerengine_node_pool.k8s_node_pool.nodes : node if node.state == "ACTIVE"]
}

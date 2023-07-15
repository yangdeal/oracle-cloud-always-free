resource "oci_core_security_list" "public_subnet_sl" {
  compartment_id = local.compartment_id
  vcn_id         = module.vcn.vcn_id

  display_name = "free-k8s-public-subnet-sl"

  # Egress
  egress_security_rules {
    description      = "Allow all traffic out"
    stateless        = false
    destination      = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
    protocol         = "all"
  }

  #Ingress
  ingress_security_rules {
    description = "All internal traffic"
    stateless   = false
    source      = "10.0.0.0/16"
    source_type = "CIDR_BLOCK"
    protocol    = "all"
  }

  ingress_security_rules {
    description = "From NLB port 443"
    protocol    = "6"
    source      = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    stateless   = false

    tcp_options {
      max = 443
      min = 443
    }
  }

  ingress_security_rules {
    description = "To singularity"
    protocol    = "6"
    source      = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    stateless   = false

    tcp_options {
      max = 61022
      min = 61022
    }
  }

  ingress_security_rules {
    description = "K8S control plan from Internet"
    protocol    = "6"
    source      = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    stateless   = false

    tcp_options {
      max = 6443
      min = 6443
    }
  }
}

resource "oci_core_subnet" "vcn_public_subnet" {
  compartment_id = local.compartment_id
  vcn_id         = module.vcn.vcn_id
  cidr_block     = "10.0.0.0/24"

  route_table_id    = module.vcn.ig_route_id
  security_list_ids = [oci_core_security_list.public_subnet_sl.id]
  display_name      = "free-k8s-public-subnet"
}

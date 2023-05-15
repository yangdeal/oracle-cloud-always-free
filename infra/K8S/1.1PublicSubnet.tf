 resource "oci_core_security_list" "public_subnet_sl" {
   compartment_id = local.compartment_id
   vcn_id         = module.vcn.vcn_id

   display_name = "free-k8s-public-subnet-sl"

   egress_security_rules {
     stateless        = false
     destination      = "0.0.0.0/0"
     destination_type = "CIDR_BLOCK"
     protocol         = "all"
   }

   ingress_security_rules {
     stateless   = false
     source      = "10.0.0.0/16"
     source_type = "CIDR_BLOCK"
     protocol    = "all"
   }

   ingress_security_rules {
     stateless   = false
     source      = "0.0.0.0/0"
     source_type = "CIDR_BLOCK"
     protocol    = "6"
     tcp_options {
       min = 6443
       max = 6443
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

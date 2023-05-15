 resource "oci_containerengine_cluster" "k8s_cluster" {
   compartment_id     = local.compartment_id
   kubernetes_version = "v1.26.2"
   name               = "free-k8s-cluster"
   vcn_id             = module.vcn.vcn_id
   type = "BASIC_CLUSTER"

   endpoint_config {
     is_public_ip_enabled = true
     subnet_id            = oci_core_subnet.vcn_public_subnet.id
   }

   options {
     add_ons {
       is_kubernetes_dashboard_enabled = true
       is_tiller_enabled               = false
     }
     kubernetes_network_config {
       pods_cidr     = "10.244.0.0/16"
       services_cidr = "10.96.0.0/16"
     }
     service_lb_subnet_ids = [oci_core_subnet.vcn_public_subnet.id]
   }
 }

data "oci_identity_availability_domains" "ads" {
  compartment_id = var.tenancy_ocid
}

# output "root_compartment_id" {
#   value = data.oci_identity_availability_domains.ads
# }

data "oci_identity_compartments" "my_compartment" {
  #Required
  compartment_id = data.oci_identity_availability_domains.ads.compartment_id
  name           = var.compartment_name
}

# output "compartment" {
#   value = data.oci_identity_compartments.my_compartment
# }

# data "oci_identity_fault_domains" "ad_fault_domains" {
#   availability_domain = local.availability_domain
#   compartment_id      = local.compartment_id
# }

# # output "fault_domains" {
# #   value = data.oci_identity_fault_domains.ad_fault_domains.fault_domains
# # }

# data "oci_core_images" "InstanceImageOCID" {
#   compartment_id           = local.compartment_id
#   operating_system         = var.instance_os
#   operating_system_version = var.linux_os_version
#   sort_by                  = "TIMECREATED"
#   sort_order               = "DESC"

#   filter {
#     name   = "display_name"
#     values = ["^Canonical-Ubuntu-${var.linux_os_version}-([\\.0-9-]+)$"]
#     regex  = true
#   }
# }

# # output "os_image" {
# #   value = data.oci_core_images.InstanceImageOCID.images[0].id
# # }
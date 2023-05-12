data "oci_core_images" "InstanceImageOCID" {
  compartment_id           = var.compartment_id
  operating_system         = var.instance_os
  operating_system_version = var.linux_os_version
  sort_by                  = "TIMECREATED"
  sort_order               = "DESC"

  filter {
    name   = "display_name"
    values = ["^Canonical-Ubuntu-${var.linux_os_version}-([\\.0-9-]+)$"]
    regex  = true
  }
}

# output "os_image" {
#   value = data.oci_core_images.InstanceImageOCID.images[0].id
# }
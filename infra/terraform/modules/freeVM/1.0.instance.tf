resource "oci_core_instance" "free-instance" {
  availability_domain = var.availability_domain

  compartment_id = var.compartment_id
  create_vnic_details {
    assign_public_ip = var.assign_public_ip
    display_name     = "ssv-decymber-instance"
    freeform_tags = {
    }
    nsg_ids = [
    ]
    skip_source_dest_check = "false"
    subnet_id              = var.subnet_id
  }
  #dedicated_vm_host_id = <<Optional value not found in discovery>>
  display_name = var.instance_display_name
  extended_metadata = {
  }
  fault_domain = "FAULT-DOMAIN-1"
  freeform_tags = {
  }
  instance_options {
    are_legacy_imds_endpoints_disabled = "false"
  }

  metadata = {
    "ssh_authorized_keys" = var.public_keys
    "user_data"           = base64encode(file("${path.module}/initial.sh"))
  }
  #preserve_boot_volume = <<Optional value not found in discovery>>
  shape = var.instance_shape

  source_details {
    boot_volume_size_in_gbs = var.boot_volume_size_in_gbs
    source_id               = data.oci_core_images.InstanceImageOCID.images[0].id
    source_type             = "image"
  }
  state = "RUNNING"
}
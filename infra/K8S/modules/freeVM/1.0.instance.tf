
resource "oci_core_instance" "free-instance" {
  availability_domain = var.availability_domain

  compartment_id = var.compartment_id
  create_vnic_details {
    assign_public_ip       = var.assign_public_ip
    display_name           = "${var.instance_display_name}_interface"
    freeform_tags          = {}
    nsg_ids                = var.nsg_id == "" ? [] : [var.nsg_id]
    skip_source_dest_check = "false"
    subnet_id              = var.subnet_id
    private_ip             = var.private_ip == "" ? null : var.private_ip
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
    # TODO: use base64encode
    # base64encode changes even the file does not change, and result the instance replaced.
    # hardcode the user_data for now
    #    "user_data"           = base64encode(file("${path.module}/initial.sh"))
    "user_data" = "IyEvYmluL2Jhc2gKIyByZWRpcmVjdCBzdGRvdXQvc3RkZXJyIHRvIGEgZmlsZQpleGVjID4gL3RtcC9zdGFydC11cC5sb2cgMj4mMQoKIyBzdGFydCB0aW1lc3RhbXAKZGF0ZQplY2hvICJ0aGlzIGlzIHN0YXJ0IHVwIHNjcmlwdCIKCmFwdCBpbnN0YWxsIC15IG5ldC10b29scyBodG9wIHZpbSBjYS1jZXJ0aWZpY2F0ZXMgY3VybCBnbnVwZyB0bXV4IHpzaAo="
  }
  #preserve_boot_volume = <<Optional value not found in discovery>>
  shape = var.instance_shape

  source_details {
    boot_volume_size_in_gbs = var.boot_volume_size_in_gbs
#    source_id               = data.oci_core_images.InstanceImageOCID.images[0].id
    source_id               = var.instance_image_id
    source_type             = "image"
  }
  state = "RUNNING"
}
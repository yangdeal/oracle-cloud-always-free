module "gateway_vm" {
  source = "./modules/freeVM"

  instance_os           = var.instance_os
  linux_os_version      = var.linux_os_version
  compartment_id        = local.compartment_id
  public_keys           = var.public_keys
  instance_display_name = "gateway"
  subnet_id             = oci_core_subnet.vcn_public_subnet.id
  availability_domain   = local.availability_domain
  assign_public_ip      = true
}

output "gateway_ip" {
  value = module.gateway_vm.public_ip
}
module "worker_vm" {
  source = "./modules/freeVM"

  instance_os           = var.instance_os
  linux_os_version      = var.linux_os_version
  compartment_id        = local.compartment_id
  public_keys           = var.public_keys
  instance_display_name = "worker"
  subnet_id             = module.vnet.protected_subnet_id
  availability_domain   = local.availability_domain
  assign_public_ip      = true
}

output "worker_ip" {
  value = module.worker_vm.private_ip
}
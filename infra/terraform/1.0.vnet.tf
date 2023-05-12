module "vnet" {
  source = "./modules/vnet"

  availability_domain = local.availability_domain
  compartment_id      = local.compartment_id
  compartment_name    = var.compartment_name
}
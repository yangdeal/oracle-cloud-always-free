module "alb" {
  source = "./modules/loadBalancer"

  display_name   = "free_alb"
  compartment_id = local.compartment_id
  subnet_id      = module.vnet.load_balancer_subnet_id
  worker_ip      = module.worker_vm.private_ip
}

output "alb_public_ip" {
  value = module.alb.public_ip
}
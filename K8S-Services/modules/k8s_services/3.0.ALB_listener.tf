module "alb" {
  count = var.alb_enable ? 1 : 0
  source = "../../../infra/K8S/modules/alb_website"

  backend_node_ip    = var.k8s_backend_node_ips
  load_balancer_id   = var.alb_id
  listener_name      = local.service_name
  dns_name           = local.service_dns
  k8s_service_port   = random_integer.node_port.result
  health_check_url   = var.health_check_url
  health_return_code = var.health_return_code
}
module "jenkins_web" {
  source = "../../modules/alb_website"

  backend_node_ip  = var.k8s_backend_node_ips
  load_balancer_id = var.alb_id
  listener_name    = var.name
  dns_name         = ["${var.name}.mytoybox.win"]
  k8s_service_port = random_integer.node_port.result
  health_check_url = var.health_check_url
}
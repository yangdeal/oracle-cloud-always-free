module "springboot_web" {
  source = "./modules/alb_website"

  backend_node_ip  = local.k8s_backend_node_ip
  load_balancer_id = oci_load_balancer_load_balancer.k8s_alb.id
  listener_name    = "spring_boot"
  dns_name         = ["mytoybox.win", "www.mytoybox.win"]
  k8s_service_port = 30080
}
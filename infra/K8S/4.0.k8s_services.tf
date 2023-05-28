module "k8s_services" {
  for_each = local.services_yaml["Services"]
  source = "./modules/k8s_services"

  name = each.key
  image = each.value["image"]
  alb_id = oci_load_balancer_load_balancer.k8s_alb.id
  k8s_backend_node_ips = local.k8s_backend_node_ips
  replicas = contains(keys(each.value), "replicas") ? each.value["replicas"] : 1
  mount_path = each.value["persistent_volume_mount"]
  container_port = each.value["container_port"]
  health_check_url = contains(keys(each.value), "health_check_url") ? each.value["health_check_url"] : "/"
}

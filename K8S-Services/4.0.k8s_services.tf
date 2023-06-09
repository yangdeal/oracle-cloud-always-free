module "k8s_services" {
  for_each = local.services_yaml["Services"]
  source   = "./modules/k8s_services"

  name                 = each.key
  name_space           = local.name_space_lower_case
  image                = each.value["image"]
  alb_id               = local.lb_id
  k8s_backend_node_ips = local.k8s_backend_node_ips
  replicas             = contains(keys(each.value), "replicas") ? each.value["replicas"] : 1
  mount_path           = each.value["persistent_volume_mount"]
  container_port       = each.value["container_port"]
  health_check_url     = contains(keys(each.value), "health_check_url") ? each.value["health_check_url"] : "/"
  health_return_code   = contains(keys(each.value), "health_return_code") ? each.value["health_return_code"] : 200
  dns_domain           = var.dns_domain
  alb_enable           = contains(keys(each.value), "alb") ? each.value["alb"] : true
  env_map              = contains(keys(local.env_yaml), each.key) ? local.env_yaml[each.key] : {}
}

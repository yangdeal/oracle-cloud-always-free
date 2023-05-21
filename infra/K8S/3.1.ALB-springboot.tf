resource "oci_load_balancer_backend_set" "spring_boot_service" {
  health_checker {
    interval_ms = "10000"
    #is_force_plain_text = <<Optional value not found in discovery>>
    port                = "30080"
    protocol            = "HTTP"
    response_body_regex = ""
    retries             = "3"
    return_code         = "200"
    timeout_in_millis   = "3000"
    url_path            = "/"
  }
  load_balancer_id = oci_load_balancer_load_balancer.k8s_alb.id
  name             = "spring_boot_service"
  policy           = "ROUND_ROBIN"
}

# Backend
resource "oci_load_balancer_backend" "spring_boot_service_backend_1" {
  backendset_name  = oci_load_balancer_backend_set.spring_boot_service.name
  backup           = "false"
  drain            = "false"
  ip_address       = oci_containerengine_node_pool.k8s_node_pool.nodes[0].private_ip
  load_balancer_id = oci_load_balancer_load_balancer.k8s_alb.id
  offline          = "false"
  port             = "30080"
  weight           = "1"
}

resource "oci_load_balancer_backend" "spring_boot_service_backend_2" {
  backendset_name  = oci_load_balancer_backend_set.spring_boot_service.name
  backup           = "false"
  drain            = "false"
  ip_address       = oci_containerengine_node_pool.k8s_node_pool.nodes[1].private_ip
  load_balancer_id = oci_load_balancer_load_balancer.k8s_alb.id
  offline          = "false"
  port             = "30080"
  weight           = "1"
}

#L Listener
resource "oci_load_balancer_listener" "spring_boot_listener" {
  connection_configuration {
    backend_tcp_proxy_protocol_version = "0"
    idle_timeout_in_seconds            = "60"
  }
  default_backend_set_name = oci_load_balancer_backend_set.spring_boot_service.name
  hostname_names = [
    "mytoybox.win",
    "www.mytoybox.win",
  ]
  load_balancer_id = oci_load_balancer_load_balancer.k8s_alb.id
  name             = "spring_boot_listener"
  #path_route_set_name = <<Optional value not found in discovery>>
  port     = "80"
  protocol = "HTTP"
  #routing_policy_name = <<Optional value not found in discovery>>
  rule_set_names = [
  ]
}

# DNS name
resource "oci_load_balancer_hostname" "export_mytoybox-win" {
  hostname         = "mytoybox.win"
  load_balancer_id = oci_load_balancer_load_balancer.k8s_alb.id
  name             = "mytoybox.win"
}

resource "oci_load_balancer_hostname" "export_www-mytoybox-win" {
  hostname         = "www.mytoybox.win"
  load_balancer_id = oci_load_balancer_load_balancer.k8s_alb.id
  name             = "www.mytoybox.win"
}

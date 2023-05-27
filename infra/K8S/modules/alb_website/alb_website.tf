# Listener
resource "oci_load_balancer_listener" "http_listener" {
  depends_on = [oci_load_balancer_hostname.hostname]
  connection_configuration {
    backend_tcp_proxy_protocol_version = "0"
    idle_timeout_in_seconds            = "60"
  }
  default_backend_set_name = oci_load_balancer_backend_set.backend_set.name
  hostname_names           = var.dns_name
  load_balancer_id         = var.load_balancer_id
  name                     = var.listener_name
  #path_route_set_name = <<Optional value not found in discovery>>
  port     = "80"
  protocol = "HTTP"
  #routing_policy_name = <<Optional value not found in discovery>>
  rule_set_names = [
  ]
}

resource "oci_load_balancer_backend_set" "backend_set" {
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
  load_balancer_id = var.load_balancer_id
  name             = var.listener_name
  policy           = "ROUND_ROBIN"
}


resource "oci_load_balancer_backend" "backend" {
  for_each = toset(var.backend_node_ip)

  backendset_name  = oci_load_balancer_backend_set.backend_set.name
  backup           = "false"
  drain            = "false"
  ip_address       = each.key
  load_balancer_id = var.load_balancer_id
  offline          = "false"
  port             = var.k8s_service_port
  weight           = "1"
}

# DNS name
resource "oci_load_balancer_hostname" "hostname" {
  for_each = toset(var.dns_name)

  load_balancer_id = var.load_balancer_id
  hostname         = each.key
  name             = each.key
}

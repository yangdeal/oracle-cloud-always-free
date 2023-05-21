
resource "oci_load_balancer_backend_set" "export_null_backend" {
  health_checker {
    interval_ms = "10000"
    #is_force_plain_text = <<Optional value not found in discovery>>
    port                = "0"
    protocol            = "HTTP"
    response_body_regex = ""
    retries             = "3"
    return_code         = "200"
    timeout_in_millis   = "3000"
    url_path            = "/"
  }
  load_balancer_id = oci_load_balancer_load_balancer.k8s_alb.id
  name             = "null_backend"
  policy           = "ROUND_ROBIN"
}

resource "oci_load_balancer_listener" "k8s_alb_Default" {
  connection_configuration {
    backend_tcp_proxy_protocol_version = "0"
    idle_timeout_in_seconds            = "60"
  }
  default_backend_set_name = oci_load_balancer_backend_set.export_null_backend.name
  hostname_names = [
  ]
  load_balancer_id = oci_load_balancer_load_balancer.k8s_alb.id

  name     = "Default"
  port     = "80"
  protocol = "HTTP"

  rule_set_names = [
  ]
}
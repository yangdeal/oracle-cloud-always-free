resource oci_load_balancer_load_balancer load_balancer {
  compartment_id = var.compartment_id
  display_name = var.display_name
  ip_mode    = "IPV4"
  is_private = "false"
  network_security_group_ids = []
  #reserved_ips = <<Optional value not found in discovery>>
  shape = "flexible"
  shape_details {
    maximum_bandwidth_in_mbps = "10"
    minimum_bandwidth_in_mbps = "10"
  }
  subnet_ids = [
    var.subnet_id,
  ]
}

resource oci_load_balancer_backend_set backend_set {
  health_checker {
    interval_ms = "10000"
    port                = "80"
    protocol            = "HTTP"
    response_body_regex = ""
    retries             = "3"
    return_code         = "200"
    timeout_in_millis   = "3000"
    url_path            = "/"
  }
  load_balancer_id = oci_load_balancer_load_balancer.load_balancer.id
  name             = "load_balancer_backend_set"
  policy           = "ROUND_ROBIN"
}

resource oci_load_balancer_backend backend {
  backendset_name  = oci_load_balancer_backend_set.backend_set.name
  backup           = "false"
  drain            = "false"
  ip_address       = var.worker_ip
  load_balancer_id = oci_load_balancer_load_balancer.load_balancer.id
  offline          = "false"
  port             = "80"
  weight           = "1"
}

resource oci_load_balancer_listener listener {
  connection_configuration {
    backend_tcp_proxy_protocol_version = "0"
    idle_timeout_in_seconds            = "60"
  }
  default_backend_set_name = oci_load_balancer_backend_set.backend_set.name
  hostname_names = [
  ]
  load_balancer_id = oci_load_balancer_load_balancer.load_balancer.id
  name             = "listener"
  #path_route_set_name = <<Optional value not found in discovery>>
  port     = "80"
  protocol = "HTTP"
  #routing_policy_name = <<Optional value not found in discovery>>
  rule_set_names = [
  ]
}


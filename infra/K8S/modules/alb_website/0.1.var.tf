variable "listener_name" {}

variable "dns_name" { type = list(string) }

variable "backend_node_ip" { type = list(string) }

variable "k8s_service_port" {}

variable "load_balancer_id" {}
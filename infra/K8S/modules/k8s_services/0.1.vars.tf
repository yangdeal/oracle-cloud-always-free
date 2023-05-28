variable "name" {}

variable "replicas" {
  default = 1
}
variable "image" {}

variable "container_port" {
  default = 80
}

variable "k8s_backend_node_ips" {}
variable "alb_id" {}

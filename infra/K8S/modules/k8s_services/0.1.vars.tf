variable "name" {}

variable "replicas" {
  default = 1
}
variable "image" {}

variable "container_port" {}

variable "k8s_backend_node_ips" {}
variable "alb_id" {}
variable "mount_path" {
  default = ""
}

variable "nfs_server" {
  default = "10.0.100.100"
}

variable "health_check_url" {
  default = "/"
}

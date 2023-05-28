variable "name" {}

variable "replicas" {
  default = 1
}
variable "image" {}

variable "container_port" {
  default = 80
}

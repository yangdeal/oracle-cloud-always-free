locals {
  service_name = var.name_space == "main" ? var.name : "${var.name_space}-${var.name}"
  service_dns  = ["${local.service_name}.${var.dns_domain}"]
}
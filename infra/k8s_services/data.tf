locals {
  services_yaml= yamldecode(file("../../01-configure/services.yaml"))
}

output "services_yaml" {
  value = local.services_yaml
}


output "public_subnet_id" {
  value = oci_core_subnet.public_subnet.id
}

output "protected_subnet_id" {
  value = oci_core_subnet.protected_subnet.id
}

output "load_balancer_subnet_id" {
  value = oci_core_subnet.loadbalancer_subnet.id
}
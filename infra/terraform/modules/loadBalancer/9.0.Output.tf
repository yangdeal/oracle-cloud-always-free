output "public_ip" {
  value = oci_load_balancer_load_balancer.load_balancer.ip_addresses[0]
}
output "public_ip" {
  value = keys(oci_load_balancer_load_balancer.load_balancer.ip_address_details[0])[0]
}
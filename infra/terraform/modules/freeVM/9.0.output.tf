output "public_ip" {
  value = oci_core_instance.free-instance.public_ip
}

output "private_ip" {
  value = oci_core_instance.free-instance.private_ip
}
resource "random_integer" "node_port" {
  min = 30000
  max = 32767
}

output "node_port" {
  value = random_integer.node_port.result
}


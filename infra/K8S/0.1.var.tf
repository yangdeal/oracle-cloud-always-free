# Common var

variable "tenancy_ocid" {}

variable "user_ocid" {}

variable "fingerprint" {}

variable "private_key_path" {}

variable "region" { default = "ap-melbourne-1" }

variable "compartment_name" { default = "yangdeal" }

variable "availability_domain_index" { default = "1" }

### Var for VM
# OS Images
variable "instance_os" {
  description = "Operating system for compute instances"
  default     = "Canonical Ubuntu"
}

variable "linux_os_version" {
  description = "Operating system version for all Linux instances"
  default     = "22.04"
}
variable "public_keys" {
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDHjLVkj96Fm3452O0nMKslNTNS8XUrUgEzuRasSNVI6bpcuOjhXzdElmyBUu5SI6wAVvTzKOD1f+wFIVtSjTI4Th3/v54PECcXaIzxv3RuuE10i/HzettDzLqZd22o6rvaQU3R7Wdl7uKza92eUhNQHhDxWEmM4TkFy8a2ZUYZiEl5sIbqgWFPf5zUyyrz7hHholn8X6WwN6INzk8mVtC/BpLWC3rFOu6hf4xeH25nnhxEgWGXnpfv2zPCWsp3Dfdc+UW0U+EaCT66bg4T2KY/DtB71rfgK7bezWy7S7rdvLDIe2kjUJECEhmNJy6l0AxjGDKhtRDBglNAzNWTK+vq3S1+X78XdjFwzRooWReYwVZV4EzH3KalPcs+7sc7Nn1otppF/0miIrIULtcVbl5CO03VBeIanlWdcUtQlWwBDmphXOS+q0RerYWXxBqBxkYJG9vGJxT2557NDd+fy+g5/sa3JRMmB/iM6ZAVhRL+olxlcUwCJwIkwS6FH7CZhnxGobEYC39n1DwQICEXMRn8OqPiJxXwbEjcZesT8tJzEVNKn1nZyapHHCCGfw7NSymH2OwcXBMI13Ca7ATSXwCbiG5VSDBf4TXLMjTimfC0HkRVrp6JSmaoEvPKQNMkwSWaJGhJAQVK4d9rPyyYeAd+WuHoun/KLIN3AV8TR0WRcw=="
}

variable "dns_domain" {
  default = "mytoybox.win"
}

variable "name_space" {}

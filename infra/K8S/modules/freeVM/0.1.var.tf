variable "instance_shape" {
  default = "VM.Standard.E2.1.Micro"
}

variable "boot_volume_size_in_gbs" {
  default = 50
}

# variable "compartment_name" {}

variable "compartment_id" {}

variable "availability_domain" {}

variable "instance_display_name" {}

# OS Images
variable "instance_os" {}

variable "linux_os_version" {}

variable "public_keys" {}

variable "subnet_id" {}

variable "assign_public_ip" {}

variable "nsg_id" {
  default = ""
}

variable "private_ip" {
  default = ""
}

variable "instance_image_id" {
  # Ubuntu 22
  default = "ocid1.image.oc1.ap-melbourne-1.aaaaaaaapm2ba66pbwc3muls4m6oetdbbrydmjtvnyyqqb35acdjs57fdalq"
}
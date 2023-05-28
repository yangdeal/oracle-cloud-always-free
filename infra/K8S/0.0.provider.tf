provider "oci" {
  tenancy_ocid     = var.tenancy_ocid
  user_ocid        = var.user_ocid
  fingerprint      = var.fingerprint
  private_key_path = var.private_key_path
  region           = var.region
}

terraform {
  backend "http" {
    update_method = "PUT"
  }
}

provider "kubernetes" {
  config_path    = "~/.kube/config"
#  config_context = "my-context"
}

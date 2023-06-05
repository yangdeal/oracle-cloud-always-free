terraform {
  backend "s3" {
    bucket = "k8s-services-terraform"
    key    = "tfstate"
    region = "ap-melbourne-1"
    #    Endpoint to be passed from terraform init cli
    #    endpoint = ""
    shared_credentials_file     = "~/.aws/credentials"
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    force_path_style            = true
  }
}

provider "oci" {
  tenancy_ocid     = var.tenancy_ocid
  user_ocid        = var.user_ocid
  fingerprint      = var.fingerprint
  private_key_path = var.private_key_path
  region           = var.region
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

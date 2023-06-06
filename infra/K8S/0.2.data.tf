data "oci_identity_availability_domains" "ads" {
  compartment_id = var.tenancy_ocid
}

data "oci_identity_compartments" "my_compartment" {
  #Required
  compartment_id = data.oci_identity_availability_domains.ads.compartment_id
  name           = var.compartment_name
}


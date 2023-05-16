locals {
  compartment_id      = data.oci_identity_availability_domains.ads.compartment_id
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
}

resource "kubernetes_namespace" "this" {
  metadata {
    annotations = {
      name = local.name_space_lower_case
    }

    labels = {
      mylabel = local.name_space_lower_case
    }

    name = local.name_space_lower_case
  }
}
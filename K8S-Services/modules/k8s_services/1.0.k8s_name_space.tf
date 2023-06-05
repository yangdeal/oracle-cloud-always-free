resource "kubernetes_namespace" "this" {
  metadata {
    annotations = {
      name = var.name_space
    }

    labels = {
      mylabel = var.name_space
    }

    name = var.name_space
  }
}
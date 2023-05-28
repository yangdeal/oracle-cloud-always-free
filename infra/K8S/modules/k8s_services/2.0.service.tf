resource "kubernetes_service" "this" {
  metadata {
    name = var.name
  }
  spec {
    selector = {
      App = kubernetes_deployment.this.spec.0.template.0.metadata[0].labels.App
    }
    port {
      node_port   = random_integer.node_port.result
      port        = var.container_port
    }

    type = "NodePort"
  }
}

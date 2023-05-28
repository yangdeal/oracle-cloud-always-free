
resource "random_integer" "node_port" {
  min = 30000
  max = 32767
}


resource "kubernetes_deployment" "this" {
  metadata {
    name = var.name
    labels = {
      App = var.name
    }
  }

  spec {
    replicas = var.replicas
    selector {
      match_labels = {
        App = var.name
      }
    }
    template {
      metadata {
        labels = {
          App = var.name
        }
      }
      spec {
        container {
          image = var.image
          name  = var.name

          port {
            container_port = var.container_port
          }

#          resources {
#            limits = {
#              cpu    = "0.5"
#              memory = "512Mi"
#            }
#            requests = {
#              cpu    = "250m"
#              memory = "50Mi"
#            }
#          }
        }
      }
    }
  }
}


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

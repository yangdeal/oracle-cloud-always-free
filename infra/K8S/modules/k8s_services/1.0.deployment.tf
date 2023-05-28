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



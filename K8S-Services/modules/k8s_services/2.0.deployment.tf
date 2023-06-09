resource "random_integer" "node_port" {
  min = 30000
  max = 32767
}

resource "kubernetes_deployment" "this" {
  wait_for_rollout = false
  metadata {
    namespace = var.name_space
    name      = var.name
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
        volume {
          name = "nfs-volume"
          nfs {
            path   = "/var/nfs/general/${var.name_space}/${var.name}"
            server = var.nfs_server
          }
        }
        container {
          image = var.image
          name  = var.name

          dynamic "env" {
            for_each = var.env_map != "" ? var.env_map : {}
            content {
              name  = env.key
              value = env.value
            }
          }

          port {
            container_port = var.container_port
          }

          volume_mount {
            mount_path = var.mount_path
            name       = "nfs-volume"
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



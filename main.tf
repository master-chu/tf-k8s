provider "kubernetes" {
  config_path = "~/.kube/config"
}

resource "kubernetes_namespace" "tf-k8s-namespace" {
  metadata {
    name = "tf-k8s-namespace"
  }
}

resource "kubernetes_deployment" "tf-k8s-deployment" {
  metadata {
    name = "tf-k8s-deployment"
    namespace = kubernetes_namespace.tf-k8s-namespace.metadata.0.name
  }
  spec {
    replicas = 2
    selector {
      match_labels = {
        app = "tf-k8s-app"
      }
    }
    template {
      metadata {
        labels = {
          app = "tf-k8s-app"
        }
      }
      spec {
        container {
          image = "tf-k8s-app"
          image_pull_policy = "IfNotPresent"
          name = "tf-k8s-app-container"
          port {
            container_port = 6969
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "tf-k8s-service" {
  metadata {
    name = "tf-k8s-service"
    namespace = kubernetes_namespace.tf-k8s-namespace.metadata.0.name
  }
  spec {
    selector = {
      app = kubernetes_deployment.tf-k8s-deployment.spec.0.template.0.metadata.0.labels.app
    }
    type = "NodePort"
    port {
      node_port = 31000
      port = 6969
      target_port = 6969
    }
  }
}
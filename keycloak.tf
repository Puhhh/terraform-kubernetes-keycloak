resource "kubernetes_namespace" "keycloak-namespace" {
  metadata {
    name = var.keycloak-namespace
  }
}

resource "argocd_application" "keycloak" {
  count = lower(var.deploy-method) == "argocd" ? 1 : 0

  metadata {
    name      = var.keycloak-name
    namespace = var.argocd-namespace
  }

  spec {
    destination {
      server    = var.cluster-url
      namespace = kubernetes_namespace.keycloak-namespace.metadata[0].name
    }

    sync_policy {
      automated {}
    }

    source {
      repo_url        = var.helm-chart-repo
      chart           = var.helm-chart-name
      target_revision = var.helm-chart-version

      helm {
        values = var.helm-custom-values ? templatefile(var.helm-custom-values-path, {
          admin-username                  = var.admin-username,
          admin-password                  = var.admin-password,
          proxy-type                      = var.proxy-type,
          configmap-name                  = var.configmap-name,
          custom-certificates-secret-name = var.custom-certificates-secret ? var.custom-certificates-secret-name : ""
        }) : ""
      }
    }
  }
}

resource "helm_release" "keycloak" {
  count = lower(var.deploy-method) == "helm" ? 1 : 0

  namespace  = kubernetes_namespace.keycloak-namespace.metadata[0].name
  name       = var.helm-name
  chart      = var.helm-chart-name
  repository = var.helm-chart-repo
  version    = var.helm-chart-version

  values = var.helm-custom-values ? [
    templatefile(var.helm-custom-values-path, {
      admin-username                  = var.admin-username,
      admin-password                  = var.admin-password,
      proxy-type                      = var.proxy-type,
      configmap-name                  = var.configmap-name,
      custom-certificates-secret-name = var.custom-certificates-secret ? var.custom-certificates-secret-name : ""
    })
  ] : []
}

resource "kubernetes_manifest" "custom-certificates-secret" {
  count = var.custom-certificates-secret == true ? 1 : 0

  manifest = {
    "apiVersion" = "v1"
    "kind"       = "Secret"
    "data" = {
      "${var.custom-certificates-secret-name}.pem" = var.custom-certificates
    }
    "metadata" = {
      "name" : var.custom-certificates-secret-name
      "namespace" : kubernetes_namespace.keycloak-namespace.metadata[0].name
    }
  }
}

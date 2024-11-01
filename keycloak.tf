resource "kubernetes_namespace" "keycloak_namespace" {
  metadata {
    name = var.keycloak_namespace
  }
}

locals {
  use_custom_values = var.helm_custom_values ? templatefile(var.helm_custom_values_path, {
    admin_username                  = var.admin_username,
    admin_password                  = var.admin_password,
    proxy_type                      = var.proxy_type,
    configmap_name                  = var.configmap_name,
    default_postgresql              = var.default_postgresql,
    host                            = var.db_credentials["host"],
    port                            = var.db_credentials["port"],
    database                        = var.db_credentials["dbname"],
    user                            = var.db_credentials["username"],
    password                        = var.db_credentials["password"],
    db_credentials_secret           = var.db_credentials_secret,
    existing_secret                 = var.db_credentials_secret["secret_name"],
    existing_secret_host_key        = var.db_credentials_secret["host_key"],
    existing_secret_port_key        = var.db_credentials_secret["port_key"],
    existing_secret_user_key        = var.db_credentials_secret["username_key"],
    existing_secret_database_key    = var.db_credentials_secret["dbname_key"],
    existing_secret_password_key    = var.db_credentials_secret["password_key"],
    production_mode                 = var.production_mode,
    custom_certificates_secret_name = var.custom_certificates_secret ? var.custom_certificates_secret_name : ""
  }) : ""
}

resource "argocd_application" "keycloak" {
  count = lower(var.deploy_method) == "argocd" ? 1 : 0

  metadata {
    name      = var.helm_chart_name
    namespace = var.argocd_namespace
  }

  spec {
    destination {
      server    = var.cluster_url
      namespace = kubernetes_namespace.keycloak_namespace.metadata[0].name
    }

    sync_policy {
      automated {}
    }

    source {
      repo_url        = var.helm_chart_repo
      chart           = var.helm_chart_name
      target_revision = var.helm_chart_version

      helm {
        values = local.use_custom_values
      }
    }
  }
}

resource "helm_release" "keycloak" {
  count = lower(var.deploy_method) == "helm" ? 1 : 0

  namespace  = kubernetes_namespace.keycloak_namespace.metadata[0].name
  name       = var.helm_chart_name
  chart      = var.helm_chart_name
  repository = var.helm_chart_repo
  version    = var.helm_chart_version

  values = var.helm_custom_values ? [local.use_custom_values] : []
}

resource "kubernetes_manifest" "custom_certificates_secret" {
  count = var.custom_certificates_secret == true ? 1 : 0

  manifest = {
    "apiVersion" = "v1"
    "kind"       = "Secret"
    "data" = {
      "${var.custom_certificates_secret_name}.pem" = base64encode(var.custom_certificates)
    }
    "metadata" = {
      "name" : var.custom_certificates_secret_name
      "namespace" : kubernetes_namespace.keycloak_namespace.metadata[0].name
    }
  }
}

resource "kubernetes_manifest" "keycloak_cloudnativepg_database_cluster" {
  count = var.cloudnativepg_database == true ? 1 : 0

  manifest = {
    "apiVersion" = "postgresql.cnpg.io/v1"
    "kind"       = "Cluster"
    "metadata" = {
      "name"      = "${var.helm_chart_name}-pg-cluster"
      "namespace" = kubernetes_namespace.keycloak_namespace.metadata[0].name
    }
    "spec" = {
      "bootstrap" = {
        "initdb" = {
          "database" = var.helm_chart_name
          "owner"    = var.helm_chart_name
          "secret" = {
            "name" = "${var.helm_chart_name}-pg-secret"
          }
        }
      }
      "instances" = var.cloudnativepg_instances_replicas
      "storage" = {
        "size" = var.cloudnativepg_storage_size
      }
    }
  }
}

resource "kubernetes_manifest" "keycloak_cloudnativepg_database_secret" {
  count = var.cloudnativepg_database == true ? 1 : 0

  manifest = {
    "apiVersion" = "v1"
    "data" = {
      "db-host"  = base64encode("${var.helm_chart_name}-pg-cluster-rw.${kubernetes_namespace.keycloak_namespace.metadata[0].name}.svc.cluster.local")
      "db-port"  = base64encode(var.cloudnativepg_database_port)
      "db-name"  = base64encode(var.helm_chart_name)
      "username" = base64encode(var.helm_chart_name)
      "password" = base64encode(var.cloudnativepg_database_password)
    }
    "kind" = "Secret"
    "metadata" = {
      "name"      = "${var.helm_chart_name}-pg-secret"
      "namespace" = kubernetes_namespace.keycloak_namespace.metadata[0].name
    }
    "type" = "Opaque"
  }
}

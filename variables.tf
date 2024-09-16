variable "kubeconfig_path" {
  description = "Kubeconfig Path"
  type        = string
  default     = "~/.kube/config"
}

variable "kube_context" {
  description = "Kubernetes Context to Use"
  type        = string
  default     = ""
}

variable "deploy_method" {
  description = "Choose Deploy Method ArgpCD or Helm"
  type        = string
}

variable "argocd_server" {
  description = "ArgoCD Server URL"
  type        = string
  default     = ""

  validation {
    condition     = !(lower(var.deploy_method) == "argocd" && var.argocd_server == "")
    error_message = "ArgoCD Server URL Must Not be NULL When Deploy Method is ArgoCD."
  }
}

variable "argocd_token" {
  description = "ArgoCD Token"
  type        = string
  sensitive   = true
  default     = ""

  validation {
    condition     = !(lower(var.deploy_method) == "argocd" && var.argocd_token == "")
    error_message = "ArgoCD Token Must Not be NULL When Deploy Method is ArgoCD."
  }
}

variable "tls_verify_skip" {
  description = "Skip SelfSigned Certificates Validate"
  type        = bool
  default     = false
}

variable "keycloak_namespace" {
  description = "Keycloak Namespace"
  type        = string
  default     = "keycloak"
}

variable "keycloak_name" {
  description = "Keycloak Name"
  type        = string
  default     = "keycloak"
}

variable "argocd_namespace" {
  description = "ArgoCD Namespace"
  type        = string
  default     = "argocd"
}

variable "cluster_url" {
  description = "Cluster URL"
  type        = string
  default     = "https://kubernetes.default.svc"
}

variable "helm_name" {
  description = "Helm Release Name"
  type        = string
  default     = "keycloak"
}

variable "helm_chart_name" {
  description = "Helm Chart Name"
  type        = string
  default     = "keycloak"
}

variable "helm_chart_repo" {
  description = "Helm Chart Repo"
  type        = string
  default     = "oci://registry-1.docker.io/bitnamicharts/"
}

variable "helm_chart_version" {
  description = "Helm Chart Version"
  type        = string
  default     = "22.1.0"
}

variable "helm_custom_values" {
  description = "Use Helm Custom Values"
  type        = bool
  default     = false
}

variable "helm_custom_values_path" {
  description = "Helm Custom Values Path"
  type        = string
  default     = ""

  validation {
    condition     = !(var.helm_custom_values && var.helm_custom_values_path == "")
    error_message = "helm_custom_values_path must not be null when helm_custom_values is true."
  }
}

variable "admin_username" {
  description = "Admin Username"
  type        = string
  default     = "user"
}

variable "admin_password" {
  description = "Admin Password"
  type        = string
  sensitive   = true
  default     = ""
}

variable "proxy_type" {
  description = "Proxy Type"
  type        = string
  default     = ""
}

variable "configmap_name" {
  description = "Config Map with CA Certificates Bundle Name"
  type        = string
  default     = ""
}

variable "custom_certificates_secret" {
  description = "Use Keycloak custom CA certificates Secret. The secret will be mounted as a directory and configured using KC_TRUSTSTORE_PATHS"
  type        = bool
  default     = false
}

variable "custom_certificates_secret_name" {
  description = "Custom Certificates Secret Name"
  type        = string
  default     = ""

  validation {
    condition     = !(var.custom_certificates_secret && var.custom_certificates_secret_name == "")
    error_message = "custom_certificates_secret_name must not be null when custom_certificates_secret is true."
  }
}

variable "custom_certificates" {
  description = "Custom Certificates in Base64"
  type        = string
  default     = ""

  validation {
    condition     = !(var.custom_certificates_secret && var.custom_certificates == "")
    error_message = "custom_certificates must not be null when custom_certificates_secret is true."
  }
}

variable "default_postgresql" {
  description = "Default PostgreSQL"
  type        = bool
  default     = true
}

variable "use_db_credentials" {
  description = "Use database credentials"
  type        = bool
  default     = false
}

variable "db_credentials" {
  description = "DB Credentials"
  sensitive   = true
  type        = map(string)
  default = {
    host     = ""
    port     = ""
    dbname   = ""
    username = ""
    password = ""
  }

  validation {
    condition     = !(var.use_db_credentials && (var.db_credentials.host == "" || var.db_credentials.port == "" || var.db_credentials.dbname == "" || var.db_credentials.username == "" || var.db_credentials.password == ""))
    error_message = "All database credentials fields must be populated when 'use_db_credentials' is true."
  }
}

variable "use_db_credentials_secret" {
  description = "Use existing secret resource containing the database credentials"
  type        = bool
  default     = false
}

variable "db_credentials_secret" {
  description = "DB Credentials Secret"
  #  sensitive   = true
  type = map(string)
  default = {
    secret_name  = ""
    host_key     = ""
    port_key     = ""
    dbname_key   = ""
    username_key = ""
    password_key = ""
  }

  validation {
    condition     = !(var.use_db_credentials_secret && (var.db_credentials_secret.secret_name == "" || var.db_credentials_secret.host_key == "" || var.db_credentials_secret.port_key == "" || var.db_credentials_secret.dbname_key == "" || var.db_credentials_secret.username_key == "" || var.db_credentials_secret.password_key == ""))
    error_message = "All database credentials secret fields must be populated when 'use_db_credentials_secret' is true."
  }
}

variable "cloudnativepg_database" {
  description = "Use CloudNative PG Database as External Database"
  type        = bool
  default     = false
}

variable "cloudnativepg_database_port" {
  description = "CloudNative PG Database Port"
  type        = number
  default     = 5432
}

variable "cloudnativepg_database_password" {
  description = "CloudNative PG Database Password"
  type        = string
  default     = ""

  validation {
    condition     = !(var.cloudnativepg_database && var.cloudnativepg_database_password == "")
    error_message = "cloudnativepg_database_password must not be null when cloudnativepg_database is true."
  }
}

variable "cloudnativepg_instances_replicas" {
  description = "CloudNative PG Instances Replicas"
  type        = number
  default     = 1
}

variable "cloudnativepg_storage_size" {
  description = "CloudNative PG Storage Size"
  type        = string
  default     = "10Gi"
}

variable "production_mode" {
  description = "Run Keycloak in production mode"
  type        = bool
  default     = false
}

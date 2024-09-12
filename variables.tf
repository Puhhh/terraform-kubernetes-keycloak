variable "kubeconfig-path" {
  description = "Kubeconfig Path"
  type        = string
  default     = "~/.kube/config"
}

variable "kube-context" {
  description = "Kubernetes Context to Use"
  type        = string
  default     = ""
}

variable "deploy-method" {
  description = "Choose Deploy Method ArgpCD or Helm"
  type        = string
}

variable "argocd-server" {
  description = "ArgoCD Server URL"
  type        = string
  default     = ""

  validation {
    condition     = !(lower(var.deploy-method) == "argocd" && var.argocd-server == "")
    error_message = "ArgoCD Server URL Must Not be NULL When Deploy Method is ArgoCD."
  }
}

variable "argocd-token" {
  description = "ArgoCD Token"
  type        = string
  sensitive   = true
  default     = ""

  validation {
    condition     = !(lower(var.deploy-method) == "argocd" && var.argocd-token == "")
    error_message = "ArgoCD Token Must Not be NULL When Deploy Method is ArgoCD."
  }
}

variable "tls-verify-skip" {
  description = "Skip SelfSigned Certificates Validate"
  type        = bool
  default     = false
}

variable "keycloak-namespace" {
  description = "Keycloak Namespace"
  type        = string
  default     = "keycloak"
}

variable "keycloak-name" {
  description = "Keycloak Name"
  type        = string
  default     = "keycloak"
}

variable "argocd-namespace" {
  description = "ArgoCD Namespace"
  type        = string
  default     = "argocd"
}

variable "cluster-url" {
  description = "Cluster URL"
  type        = string
  default     = "https://kubernetes.default.svc"
}

variable "helm-name" {
  description = "Helm Release Name"
  type        = string
  default     = "keycloak"
}

variable "helm-chart-name" {
  description = "Helm Chart Name"
  type        = string
  default     = "keycloak"
}

variable "helm-chart-repo" {
  description = "Helm Chart Repo"
  type        = string
  default     = "oci://registry-1.docker.io/bitnamicharts/"
}

variable "helm-chart-version" {
  description = "Helm Chart Version"
  type        = string
  default     = "22.1.0"
}

variable "helm-custom-values" {
  description = "Use Helm Custom Values"
  type        = bool
  default     = false
}

variable "helm-custom-values-path" {
  description = "Helm Custom Values Path"
  type        = string
  default     = ""

  validation {
    condition     = !(var.helm-custom-values && var.helm-custom-values-path == "")
    error_message = "helm-custom-values-path must not be null when helm-custom-values is true."
  }
}

variable "admin-username" {
  description = "Admin Username"
  type        = string
  default     = "user"
}

variable "admin-password" {
  description = "Admin Password"
  type        = string
  sensitive   = true
  default     = ""
}

variable "proxy-type" {
  description = "Proxy Type"
  type        = string
  default     = ""
}

variable "configmap-name" {
  description = "Config Map with CA Certificates Bundle Name"
  type        = string
  default     = ""
}

variable "custom-certificates-secret" {
  description = "Use Keycloak custom CA certificates Secret. The secret will be mounted as a directory and configured using KC_TRUSTSTORE_PATHS"
  type        = bool
  default     = false
}

variable "custom-certificates-secret-name" {
  description = "Custom Certificates Secret Name"
  type        = string
  default     = ""

  validation {
    condition     = !(var.custom-certificates-secret && var.custom-certificates-secret-name == "")
    error_message = "custom-certificates-secret-name must not be null when custom-certificates-secret is true."
  }
}

variable "custom-certificates" {
  description = "Custom Certificates in Base64"
  type        = string
  default     = ""

  validation {
    condition     = !(var.custom-certificates-secret && var.custom-certificates == "")
    error_message = "custom-certificates must not be null when custom-certificates-secret is true."
  }
}

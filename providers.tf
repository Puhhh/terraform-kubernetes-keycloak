terraform {
  required_version = ">= 0.13"

  required_providers {

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }

    argocd = {
      source  = "oboukili/argocd"
      version = ">= 1.7.0"
    }

    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.0"
    }
  }
}

provider "kubernetes" {
  config_path    = var.kubeconfig_path
  config_context = var.kube_context
}

provider "argocd" {
  server_addr = var.argocd_server
  auth_token  = var.argocd_token
  insecure    = var.tls_verify_skip
}

provider "helm" {
  kubernetes {
    config_path    = var.kubeconfig_path
    config_context = var.kube_context
  }
}

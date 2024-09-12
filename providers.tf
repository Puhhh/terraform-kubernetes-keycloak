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
  config_path    = var.kubeconfig-path
  config_context = var.kube-context
}

provider "argocd" {
  server_addr = var.argocd-server
  auth_token  = var.argocd-token
  insecure    = var.tls-verify-skip
}

provider "helm" {
  kubernetes {
    config_path    = var.kubeconfig-path
    config_context = var.kube-context
  }
}

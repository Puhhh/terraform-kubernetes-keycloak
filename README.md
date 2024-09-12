<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_argocd"></a> [argocd](#requirement\_argocd) | >= 1.7.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | ~> 2.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | ~> 2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_argocd"></a> [argocd](#provider\_argocd) | 6.1.1 |
| <a name="provider_helm"></a> [helm](#provider\_helm) | 2.15.0 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | 2.32.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [argocd_application.keycloak](https://registry.terraform.io/providers/oboukili/argocd/latest/docs/resources/application) | resource |
| [helm_release.keycloak](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubernetes_manifest.custom-certificates-secret](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |
| [kubernetes_namespace.keycloak-namespace](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin-password"></a> [admin-password](#input\_admin-password) | Admin Password | `string` | `""` | no |
| <a name="input_admin-username"></a> [admin-username](#input\_admin-username) | Admin Username | `string` | `"user"` | no |
| <a name="input_argocd-namespace"></a> [argocd-namespace](#input\_argocd-namespace) | ArgoCD Namespace | `string` | `"argocd"` | no |
| <a name="input_argocd-server"></a> [argocd-server](#input\_argocd-server) | ArgoCD Server URL | `string` | `""` | no |
| <a name="input_argocd-token"></a> [argocd-token](#input\_argocd-token) | ArgoCD Token | `string` | `""` | no |
| <a name="input_cluster-url"></a> [cluster-url](#input\_cluster-url) | Cluster URL | `string` | `"https://kubernetes.default.svc"` | no |
| <a name="input_configmap-name"></a> [configmap-name](#input\_configmap-name) | Config Map with CA Certificates Bundle Name | `string` | `""` | no |
| <a name="input_custom-certificates"></a> [custom-certificates](#input\_custom-certificates) | Custom Certificates in Base64 | `string` | `""` | no |
| <a name="input_custom-certificates-secret"></a> [custom-certificates-secret](#input\_custom-certificates-secret) | Use Keycloak custom CA certificates Secret. The secret will be mounted as a directory and configured using KC\_TRUSTSTORE\_PATHS | `bool` | `false` | no |
| <a name="input_custom-certificates-secret-name"></a> [custom-certificates-secret-name](#input\_custom-certificates-secret-name) | Custom Certificates Secret Name | `string` | `""` | no |
| <a name="input_deploy-method"></a> [deploy-method](#input\_deploy-method) | Choose Deploy Method ArgpCD or Helm | `string` | n/a | yes |
| <a name="input_helm-chart-name"></a> [helm-chart-name](#input\_helm-chart-name) | Helm Chart Name | `string` | `"keycloak"` | no |
| <a name="input_helm-chart-repo"></a> [helm-chart-repo](#input\_helm-chart-repo) | Helm Chart Repo | `string` | `"oci://registry-1.docker.io/bitnamicharts/"` | no |
| <a name="input_helm-chart-version"></a> [helm-chart-version](#input\_helm-chart-version) | Helm Chart Version | `string` | `"22.1.0"` | no |
| <a name="input_helm-custom-values"></a> [helm-custom-values](#input\_helm-custom-values) | Use Helm Custom Values | `bool` | `false` | no |
| <a name="input_helm-custom-values-path"></a> [helm-custom-values-path](#input\_helm-custom-values-path) | Helm Custom Values Path | `string` | `""` | no |
| <a name="input_helm-name"></a> [helm-name](#input\_helm-name) | Helm Release Name | `string` | `"keycloak"` | no |
| <a name="input_keycloak-name"></a> [keycloak-name](#input\_keycloak-name) | Keycloak Name | `string` | `"keycloak"` | no |
| <a name="input_keycloak-namespace"></a> [keycloak-namespace](#input\_keycloak-namespace) | Keycloak Namespace | `string` | `"keycloak"` | no |
| <a name="input_kube-context"></a> [kube-context](#input\_kube-context) | Kubernetes Context to Use | `string` | `""` | no |
| <a name="input_kubeconfig-path"></a> [kubeconfig-path](#input\_kubeconfig-path) | Kubeconfig Path | `string` | `"~/.kube/config"` | no |
| <a name="input_proxy-type"></a> [proxy-type](#input\_proxy-type) | Proxy Type | `string` | `""` | no |
| <a name="input_tls-verify-skip"></a> [tls-verify-skip](#input\_tls-verify-skip) | Skip SelfSigned Certificates Validate | `bool` | `false` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->

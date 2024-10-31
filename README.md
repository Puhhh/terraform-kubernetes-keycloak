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
| <a name="provider_argocd"></a> [argocd](#provider\_argocd) | 7.0.3 |
| <a name="provider_helm"></a> [helm](#provider\_helm) | 2.16.1 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | 2.33.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [argocd_application.keycloak](https://registry.terraform.io/providers/argoproj-labs/argocd/latest/docs/resources/application) | resource |
| [helm_release.keycloak](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubernetes_manifest.custom_certificates_secret](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |
| [kubernetes_manifest.keycloak_cloudnativepg_database_cluster](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |
| [kubernetes_manifest.keycloak_cloudnativepg_database_secret](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |
| [kubernetes_namespace.keycloak_namespace](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_password"></a> [admin\_password](#input\_admin\_password) | Admin Password | `string` | `""` | no |
| <a name="input_admin_username"></a> [admin\_username](#input\_admin\_username) | Admin Username | `string` | `"user"` | no |
| <a name="input_argocd_namespace"></a> [argocd\_namespace](#input\_argocd\_namespace) | ArgoCD Namespace | `string` | `"argocd"` | no |
| <a name="input_argocd_server"></a> [argocd\_server](#input\_argocd\_server) | ArgoCD Server URL | `string` | `""` | no |
| <a name="input_argocd_token"></a> [argocd\_token](#input\_argocd\_token) | ArgoCD Token | `string` | `""` | no |
| <a name="input_cloudnativepg_database"></a> [cloudnativepg\_database](#input\_cloudnativepg\_database) | Use CloudNative PG Database as External Database | `bool` | `false` | no |
| <a name="input_cloudnativepg_database_password"></a> [cloudnativepg\_database\_password](#input\_cloudnativepg\_database\_password) | CloudNative PG Database Password | `string` | `""` | no |
| <a name="input_cloudnativepg_database_port"></a> [cloudnativepg\_database\_port](#input\_cloudnativepg\_database\_port) | CloudNative PG Database Port | `number` | `5432` | no |
| <a name="input_cloudnativepg_instances_replicas"></a> [cloudnativepg\_instances\_replicas](#input\_cloudnativepg\_instances\_replicas) | CloudNative PG Instances Replicas | `number` | `1` | no |
| <a name="input_cloudnativepg_storage_size"></a> [cloudnativepg\_storage\_size](#input\_cloudnativepg\_storage\_size) | CloudNative PG Storage Size | `string` | `"10Gi"` | no |
| <a name="input_cluster_url"></a> [cluster\_url](#input\_cluster\_url) | Cluster URL | `string` | `"https://kubernetes.default.svc"` | no |
| <a name="input_configmap_name"></a> [configmap\_name](#input\_configmap\_name) | Config Map with CA Certificates Bundle Name | `string` | `""` | no |
| <a name="input_custom_certificates"></a> [custom\_certificates](#input\_custom\_certificates) | Custom Certificates in Base64 | `string` | `""` | no |
| <a name="input_custom_certificates_secret"></a> [custom\_certificates\_secret](#input\_custom\_certificates\_secret) | Use Keycloak custom CA certificates Secret. The secret will be mounted as a directory and configured using KC\_TRUSTSTORE\_PATHS | `bool` | `false` | no |
| <a name="input_custom_certificates_secret_name"></a> [custom\_certificates\_secret\_name](#input\_custom\_certificates\_secret\_name) | Custom Certificates Secret Name | `string` | `""` | no |
| <a name="input_db_credentials"></a> [db\_credentials](#input\_db\_credentials) | DB Credentials | `map(string)` | <pre>{<br/>  "dbname": "",<br/>  "host": "",<br/>  "password": "",<br/>  "port": "",<br/>  "username": ""<br/>}</pre> | no |
| <a name="input_db_credentials_secret"></a> [db\_credentials\_secret](#input\_db\_credentials\_secret) | DB Credentials Secret | `map(string)` | <pre>{<br/>  "dbname_key": "",<br/>  "host_key": "",<br/>  "password_key": "",<br/>  "port_key": "",<br/>  "secret_name": "",<br/>  "username_key": ""<br/>}</pre> | no |
| <a name="input_default_postgresql"></a> [default\_postgresql](#input\_default\_postgresql) | Default PostgreSQL | `bool` | `true` | no |
| <a name="input_deploy_method"></a> [deploy\_method](#input\_deploy\_method) | Choose Deploy Method ArgpCD or Helm | `string` | n/a | yes |
| <a name="input_helm_chart_name"></a> [helm\_chart\_name](#input\_helm\_chart\_name) | Helm Chart Name | `string` | `"keycloak"` | no |
| <a name="input_helm_chart_repo"></a> [helm\_chart\_repo](#input\_helm\_chart\_repo) | Helm Chart Repo | `string` | `"oci://registry-1.docker.io/bitnamicharts/"` | no |
| <a name="input_helm_chart_version"></a> [helm\_chart\_version](#input\_helm\_chart\_version) | Helm Chart Version | `string` | `"22.1.0"` | no |
| <a name="input_helm_custom_values"></a> [helm\_custom\_values](#input\_helm\_custom\_values) | Use Helm Custom Values | `bool` | `false` | no |
| <a name="input_helm_custom_values_path"></a> [helm\_custom\_values\_path](#input\_helm\_custom\_values\_path) | Helm Custom Values Path | `string` | `""` | no |
| <a name="input_keycloak_namespace"></a> [keycloak\_namespace](#input\_keycloak\_namespace) | Keycloak Namespace | `string` | `"keycloak"` | no |
| <a name="input_kube_context"></a> [kube\_context](#input\_kube\_context) | Kubernetes Context to Use | `string` | `""` | no |
| <a name="input_kubeconfig_path"></a> [kubeconfig\_path](#input\_kubeconfig\_path) | Kubeconfig Path | `string` | `"~/.kube/config"` | no |
| <a name="input_production_mode"></a> [production\_mode](#input\_production\_mode) | Run Keycloak in production mode | `bool` | `false` | no |
| <a name="input_proxy_type"></a> [proxy\_type](#input\_proxy\_type) | Proxy Type | `string` | `""` | no |
| <a name="input_tls_verify_skip"></a> [tls\_verify\_skip](#input\_tls\_verify\_skip) | Skip SelfSigned Certificates Validate | `bool` | `false` | no |
| <a name="input_use_db_credentials"></a> [use\_db\_credentials](#input\_use\_db\_credentials) | Use database credentials | `bool` | `false` | no |
| <a name="input_use_db_credentials_secret"></a> [use\_db\_credentials\_secret](#input\_use\_db\_credentials\_secret) | Use existing secret resource containing the database credentials | `bool` | `false` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->

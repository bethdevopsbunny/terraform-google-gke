# terraform-google-gke

light kubernetes cluster for gke testing

- single zone 
- single node
- non default pool
- e2-micro
- small node storage disk

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> v1.10.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | ~> 6.12.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.6.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | ~> 6.12.0 |
| <a name="provider_random"></a> [random](#provider\_random) | ~> 3.6.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_container_cluster.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_cluster) | resource |
| [google_container_node_pool.primary_nodes](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_node_pool) | resource |
| [google_project_service.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service) | resource |
| [random_string.default](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_prefix"></a> [cluster\_prefix](#input\_cluster\_prefix) | cluster prefix set before a random string for the clusters name | `string` | `"cluster"` | no |
| <a name="input_gke_nodes"></a> [gke\_nodes](#input\_gke\_nodes) | number of gke nodes | `number` | `1` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | A map of labels to apply to contained resources. | `map(string)` | `{}` | no |
| <a name="input_node_machine_type"></a> [node\_machine\_type](#input\_node\_machine\_type) | Primary nodes machine type | `string` | `"e2-micro"` | no |
| <a name="input_node_tags"></a> [node\_tags](#input\_node\_tags) | A list of node tags | `list(string)` | `[]` | no |
| <a name="input_preemptible"></a> [preemptible](#input\_preemptible) | A boolean that represents whether or not the underlying node VMs are preemptible. | `bool` | `true` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"europe-west1"` | no |
| <a name="input_zone"></a> [zone](#input\_zone) | n/a | `string` | `"europe-west1-a"` | no |

## Outputs

No outputs.

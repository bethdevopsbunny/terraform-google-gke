
variable "region" {
  type    = string
  default = "europe-west1"
}

variable "zone" {
  type    = string
  default = "europe-west1-a"
}

variable "cluster_name" {
  description = "gke cluster name"
  type        = string
  default     = "cluster"
}
f
variable "gke_nodes" {
  default     = 1
  description = "number of gke nodes"
}

variable "preemptible" {
  type        = bool
  default     = true
  description = "A boolean that represents whether or not the underlying node VMs are preemptible."
}

variable "labels" {
  description = "A map of labels to apply to contained resources."
  default     = {}
  type        = map(string)
}

variable "node_tags" {
  description = "A list of node tags"
  default     = []
  type        = list(string)
}

variable "node_machine_type" {
  description = "Primary nodes machine type"
  default     = "e2-micro"
  type        = string
}
variable "project_id" {
  type    = string
  default = ""
}

variable "key_stuff_name" {
  type    = string
  default = ""
}

variable "region" {
  type    = string
  default = "europe-west1"
}

variable "zone" {
  type    = string
  default = "europe-west1-a"
}

variable "gke_username" {
  default     = ""
  description = "gke username"
}

variable "gke_password" {
  default     = ""
  description = "gke password"
}

variable "gke_nodes" {
  default     = 1
  description = "number of gke nodes"
}

variable "enable_binary_authorization" {
  type =      bool
  default     = false
  description = "turn on binary authorization"
}

variable "enable_shielded_nodes" {
  type = bool
  default = true
  description = "turn off for testing only"
}

variable "master_auth_cidr_blocks" {
  type  = list(string)
  default = ["0.0.0.0/0"]
  description = " External network that can access Kubernetes master through HTTPS"
}

variable "preemptible" {
  type = bool
  default = false
  description = "A boolean that represents whether or not the underlying node VMs are preemptible."
}

resource "google_container_cluster" "default" {
  name     = "${var.project_id}-gke"
  location = var.region

  remove_default_node_pool = true
  initial_node_count       = 1

  network    = google_compute_network.vpc.name
  subnetwork = google_compute_subnetwork.subnet.name

  ## Security Configuration

  # restricts the allowed container image repositories/pgp signatures
  # https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_cluster#enable_binary_authorization
  #
  enable_binary_authorization = var.enable_binary_authorization

  # disables client certificate authentication
  # https://snyk.io/security-rules/SNYK-CC-TF-87
  # https://cloud.google.com/kubernetes-engine/docs/how-to/api-server-authentication#legacy-auth
  master_auth {
    client_certificate_config {
      issue_client_certificate = false
    }
  }

  # restricts the ip cidr ranges that can access the cluster master.
  # https://aquasecurity.github.io/tfsec/v1.28.1/checks/google/gke/enable-master-networks/
  # https://aquasecurity.github.io/tfsec/v1.28.1/checks/google/gke/enable-master-networks/
  master_authorized_networks_config {
    cidr_blocks = var.master_auth_cidr_blocks
  }

  # provide strong verifiable node identity and intergirty to increase the security of gke nodes
  # https://aquasecurity.github.io/tfsec/v1.28.1/checks/google/gke/node-shielding-enabled/
  # https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_cluster#enable_shielded_nodes
  enable_shielded_nodes = var.enable_shielded_nodes

}


resource "google_container_node_pool" "primary_nodes" {
  name       = "${google_container_cluster.default.name}-node-pool"
  location   = var.region
  cluster    = google_container_cluster.default.name
  node_count = var.gke_nodes

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    labels = {
      env = var.project_id
    }

    preemptible  = var.preemptible
    machine_type = "n1-standard-1"
    tags         = ["gke-node", "${var.project_id}-gke"]

    metadata = {
      disable-legacy-endpoints = true
    }
  }
}

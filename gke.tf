
resource "google_container_cluster" "default" {
  name                     = var.cluster_name
  remove_default_node_pool = true
  initial_node_count       = 1
  # by specifying a zone for location, only one 1 node is used
  location = var.zone

  master_auth {
    client_certificate_config {
      issue_client_certificate = false
    }
  }
}

resource "google_container_node_pool" "primary_nodes" {
  name       = "${google_container_cluster.default.name}-pool"
  cluster    = google_container_cluster.default.name
  node_count = var.gke_nodes
  location   = var.zone
  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
    labels       = var.labels
    preemptible  = var.preemptible
    machine_type = var.node_machine_type
    tags         = concat(["gke-node"], var.node_tags)
    disk_type    = "pd-standard"
    disk_size_gb = "30"
    metadata = {
      disable-legacy-endpoints = true
    }
  }
  lifecycle {
    prevent_destroy = false
  }
}
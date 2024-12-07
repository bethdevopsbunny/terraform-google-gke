resource "google_project_service" "default" {
  service            = "container.googleapis.com"
  disable_on_destroy = false
}
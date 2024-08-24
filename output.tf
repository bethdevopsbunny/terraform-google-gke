
output "region" {
  value = google_container_cluster.default.location
}

output "project" {
  value = google_container_cluster.default.project
}
output "binary" {
  value = local.binaryauthorizationcount
}
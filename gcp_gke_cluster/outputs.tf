
output "gke_endpoint" {
  value = google_container_cluster.primary.endpoint
}

output "gke_cluster_name" {
  description = "Name of GKE cluster"
  value = google_container_cluster.primary.name
}

output "cluster_username" {
  value = google_container_cluster.primary.master_auth.0.username
}

output "cluster_password" {
  value = google_container_cluster.primary.master_auth.0.password
}
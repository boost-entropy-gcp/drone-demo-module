terraform {
  # This module has been updated with 0.12 syntax, which means it is no longer compatible with any versions below 0.12.
  required_version = ">= 0.12"
}

#  Manage node pool in the GKE cluster separately from the cluster control plane.

resource "google_container_node_pool" "primary_nodes" {
  name       = "${var.name_prefix}-primary-nodes"
  location   = var.zone
  cluster    = var.cluster_name
  node_count = var.primary_node_count

  management {
    auto_repair = true
  }

  node_config {
    preemptible  = true
    machine_type = var.gke_instance_type

    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
}


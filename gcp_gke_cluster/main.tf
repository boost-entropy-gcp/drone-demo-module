# Configure the Google Cloud provider
provider "google" {
  project     = var.project
  region      = var.region
}

terraform {
  # This module has been updated with 0.12 syntax, which means it is no longer compatible with any versions below 0.12.
  required_version = ">= 0.12"
}

resource "google_container_cluster" "primary" {
  name               = "${var.name_prefix}-gke-cluster"
  location           = var.zone
  initial_node_count = 1
 
  network    = var.network
  subnetwork = var.subnetwork

  master_auth {
    username = var.gke_username
    password = var.gke_password

    client_certificate_config {
      issue_client_certificate = true
    }
  }
  
  node_config {
      tags = var.tag
  }
}


# Setup data resource

# data "google_container_cluster" "primary" {
#   name       = "primary"
#   location   = var.zone
# }

# Setup data resource for project

data "google_project" "project" {}

# Setup kubeconfig

resource "local_file" "kubeconfig" {
  content  = templatefile("${path.module}/templates/kubeconfig-template.yaml", {
    project_name    = data.google_project.project.project_id
    zone            = var.zone
    cluster_name    = google_container_cluster.primary.name
    user_name       = google_container_cluster.primary.master_auth[0].username
    user_password   = google_container_cluster.primary.master_auth[0].password
    endpoint        = google_container_cluster.primary.endpoint
    cluster_ca      = google_container_cluster.primary.master_auth[0].cluster_ca_certificate
    client_cert     = google_container_cluster.primary.master_auth[0].client_certificate
    client_cert_key = google_container_cluster.primary.master_auth[0].client_key
  })
  filename = "/drone/src/kubeconfig"
}

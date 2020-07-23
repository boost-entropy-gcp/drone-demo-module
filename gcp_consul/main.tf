# Configure the Google Cloud provider
provider "google" {
  project     = var.project
  region      = var.region
}

terraform {
  # The configuration for this backend will be filled in by Terragrunt
  backend "gcs" {}

  # This module has been updated with 0.12 syntax, which means it is no longer compatible with any versions below 0.12.
  required_version = ">= 0.12"
}


# -------------------------
# Create Consul instance 
# -------------------------

resource "google_compute_instance" "consul" {
  project      = var.project
  name         = "${var.name_prefix}-consul"
  machine_type = var.consul_instance_type
  zone         = var.zone
  # tag to use for applying firewall rules 
  tags = var.tag
  
  boot_disk {
    initialize_params {
      image = var.source_image
    }
  }
  
  metadata = {
    enable-oslogin = "FALSE"
  }

  network_interface {
    subnetwork = var.subnetwork

    # If var.static_ip is set use that IP, otherwise this will generate an ephemeral IP
    access_config {
      nat_ip = var.static_ip
    }
  }

  metadata_startup_script = templatefile("${path.module}/templates/consul_onboard.tpl", {
    CONSUL_VERSION  = var.consul_version
    PROJECT_NAME    = var.project
  })
}
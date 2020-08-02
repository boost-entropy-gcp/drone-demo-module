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

# Define tags as locals 
locals {
  public              = "public"
  public_restricted   = "public-restricted"
  private             = "private"
  private_persistence = "private-persistence"
}

# -------------------------
# public - allow ingress from anywhere for specified ports
# -------------------------

resource "google_compute_firewall" "public_allow_all_inbound" {
  name = "${var.name_prefix}-public-allow-ingress"

  project = var.project
  network = var.network

  target_tags   = [local.public]
  direction     = "INGRESS"
  source_ranges = ["0.0.0.0/0"]

  priority = "1000"

  allow {
    protocol = "tcp"
    ports    = ["22", "8443", "8500", "443"]
  }
}

# -------------------------
# public - allow ingress from specific sources
# -------------------------

resource "google_compute_firewall" "public_restricted_allow_inbound" {

  count = "${length(var.allowed_networks) > 0 ? 1 : 0}"

  name = "${var.name_prefix}-public-restricted-allow-ingress"

  project = var.project
  network = var.network

  target_tags   = [local.public_restricted]
  direction     = "INGRESS"
  source_ranges = var.allowed_networks

  priority = "1000"

  allow {
    protocol = "all"
  }
}


# -------------------------
# private - allow ingress from within this network
# -------------------------

resource "google_compute_firewall" "private_allow_all_network_inbound" {
  name = "${var.name_prefix}-private-allow-ingress"

  project = var.project
  network = var.network

  target_tags = [local.private]
  direction   = "INGRESS"

  source_ranges = [
    var.pub_subnw_range,
    var.pub_subnw_range_scndry,
    var.priv_subnw_range,
    var.priv_subnw_range_scndry,
    "10.127.0.0/20",
  ]

  priority = "1000"

  allow {
    protocol = "all"
  }
}

# -------------------------
# private-persistence - allow ingress from `private` and `private-persistence` instances in this network
# -------------------------

resource "google_compute_firewall" "private_allow_restricted_network_inbound" {
  name = "${var.name_prefix}-allow-restricted-inbound"

  project = var.project
  network = var.network

  target_tags = [local.private_persistence]
  direction   = "INGRESS"

  # source_tags is implicitly within this network; tags are only applied to instances that rest within the same network
  source_tags = [local.private, local.private_persistence]

  priority = "1000"

  allow {
    protocol = "all"
  }
}
# -------------------------
# REQUIRED PARAMETERS
# These variables are expected to be passed in by the operator
# -------------------------

variable "name_prefix" {
  description = "A name prefix used in resource names to ensure uniqueness across a project."
  type        = string
}

variable "network" {
  description = "A reference (self_link) to the network to place the gke cluster in"
  type        = string
}

variable "subnetwork" {
  description = "A reference (self_link) to the subnetwork to place the gke cluster in"
  type        = string
}

variable "zone" {
  description = "The zone to create the gke cluster in. Must be within the subnetwork region."
  type        = string
}

variable "gke_username" {
  description = "The username for gke cluster basic auth."
  type        = string
}

variable "gke_password" {
  description = "The password for gke cluster basic auth."
  type        = string
}

variable "project" {
  description = "The project to create the firewall rules in. Must match the network project."
  type        = string
}

variable "region" {
  description = "The region for provider"
  type        = string
}

# -------------------------
# OPTIONAL PARAMETERS
# Generally, these values won't need to be changed.
# -------------------------

variable "tag" {
  description = "The GCP network tag to apply to the F5 for firewall rules. Defaults to 'public-restricted'"
  type        = list
  default     = ["public", "public-restricted", "private"]
}


# -------------------------
# REQUIRED PARAMETERS
# These variables are expected to be passed in by the operator
# -------------------------

variable "name_prefix" {
  description = "A name prefix used in resource names to ensure uniqueness across a project."
  type        = string
}


variable "primary_node_count" {
  description = "The number of nodes per instance group."
  type        = number
  default     = 1
}

variable "gke_instance_type" {
  description = "The machine type for the gke nodes."
  type        = string
  default     = "n1-standard-1"
}

variable "cluster_name" {
  description = "The name of a GKE Cluster."
  type        = string
}

variable "zone" {
  description = "The zone to create the gke cluster in. Must be within the subnetwork region."
  type        = string
}
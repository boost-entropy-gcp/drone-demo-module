# -------------------------
# REQUIRED PARAMETERS
# These variables are expected to be passed in by the operator
# -------------------------


variable "terragrunt_path" {
  description = "Path to the terragrunt working directory."
  type        = string
}

variable "zone" {
  description = "The zone to create the F5 in. Must be within the subnetwork region."
  type        = string
}

variable "project" {
  description = "The project to create the F5 in. Must match the subnetwork project."
  type        = string
}

variable "region" {
  description = "The region for provider"
  type        = string
}

variable "f5_public_ip" {
  description = "The public IP the F5 VM instance."
  type        = string
  default     = "10.10.10.10"
}

variable "f5_private_ip" {
  description = "The private IP the F5 VM instance."
  type        = string
  default     = "10.10.10.10"
}

variable "nginx_public_ip" {
  description = "The public IP the NGINX VM instance."
  type        = string
  default     = "10.10.10.10"
}

variable "nginx_private_ip" {
  description = "The private IP the NGINX VM instance."
  type        = string
  default     = "10.10.10.10"
}

 variable "nginx_controller_public_ip" {
  description = "The private IP the NGINX Controller VM instance."
  type        = string
  default     = "10.10.10.10"
}

variable "gke_cluster_name" {
  description = "Name of GKE cluster"
  type        = string
}

variable "gke_endpoint" {
  description = "IP of the gke cluster"
  type        = string
  default     = "10.10.10.10"
}

variable "app_tag_value" {
  description = "Value for compute instance label."
  type        = string
}

variable "cluster_username" {
  description = "username of GKE cluster"
  type        = string
}

variable "cluster_password" {
  description = "password of GKE cluster"
  type        = string
}
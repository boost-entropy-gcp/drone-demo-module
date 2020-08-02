# -------------------------
# REQUIRED PARAMETERS
# These variables are expected to be passed in by the operator
# -------------------------

# variable "instance_name" {
#   description = "The name of the VM instance"
#   type        = string
# }

variable "name_prefix" {
  description = "A name prefix used in resource names to ensure uniqueness across a project."
  type        = string
}

variable "subnetwork" {
  description = "A reference (self_link) to the subnetwork to place the nginx in"
  type        = string
}

variable "region" {
  description = "The region for provider"
  type        = string
}

variable "zone" {
  description = "The zone to create the nginx in. Must be within the subnetwork region."
  type        = string
}

variable "nginx_instance_type" {
  description = "The machine type of the instance."
  type        = string
}

variable "project" {
  description = "The project to create the nginx in. Must match the subnetwork project."
  type        = string
}

variable "app_tag_value" {
  description = "Value for compute instance label."
  type        = string
}

variable consul_version {
  description = "The version of consul"
  type = "string"
}

variable vault_addr {
  description = "The vault address"
  type = "string"
}

variable vault_role_dev {
  description = "The vault role used to login (dev)"
  type = "string"
}

variable vault_ruleset_path {
  description = "The vault gcp ruleset used when getting creds"
  type = "string"
}

# -------------------------
# OPTIONAL PARAMETERS
# Generally, these values won't need to be changed.
# -------------------------

variable "tag" {
  description = "The GCP network tags to apply to the F5 for firewall rules."
  type        = list
  default     = ["public", "public-restricted", "private", "consul"]
}

#Using regular ubuntu here, and spinning up containers nginxdemos/hello/
variable "source_image" {
  description = "The source image to build the VM using. Enter in the self link here."
  type        = string
  default     = "https://www.googleapis.com/compute/v1/projects/ubuntu-os-cloud/global/images/ubuntu-1804-bionic-v20200716"
  #default     = "https://www.googleapis.com/compute/v1/projects/nginx-public/global/images/nginx-plus-ubuntu1804-v2019070118"
}

variable "startup_script" {
  description = "The script to be executed when the nginx starts. It can be used to install additional software and/or configure the host."
  type        = string
  default     = ""
}

variable "static_ip" {
  description = "A static IP address to attach to the instance. The default will allocate an ephemeral IP."
  type        = string
  default     = null
}
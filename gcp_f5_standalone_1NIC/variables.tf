# -------------------------
# REQUIRED PARAMETERS
# These variables are expected to be passed in by the operator
# -------------------------


variable "name_prefix" {
  description = "A name prefix used in resource names to ensure uniqueness across a project."
  type        = string
}

variable "subnetwork" {
  description = "A reference (self_link) to the subnetwork to place the F5 in."
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

variable "f5_instance_type" {
  description = "The machine type of the instance."
  type        = string
}

variable AS3_URL {
  type = "string"
}

variable DO_URL {
  type = "string"
}

variable TS_URL {
  type = "string"
}

# -------------------------
# OPTIONAL PARAMETERS
# Generally, these values won't need to be changed.
# -------------------------

variable "tag" {
  description = "The GCP network tags to apply to the F5 for firewall rules."
  type        = list
  default     = ["public", "public-restricted", "private"]
}

variable "source_image" {
  description = "The source image to build the VM using. Enter in the self link here."
  type        = string
  default     = "https://www.googleapis.com/compute/v1/projects/f5-7626-networks-public/global/images/f5-hourly-bigip-14-1-0-1-0-0-7-best-200mbps"
}

variable libs_dir { 
  description = "The full path on F5 where onboarding files will be saved."
  default     = "/config/cloud/google" 
}

variable onboard_log { 
  description = "The log file used by onboarding scripts."
  default     = "/var/log/startup-script.log" 
}

variable "static_ip" {
  description = "A static IP address to attach to the instance. The default will allocate an ephemeral IP."
  type        = string
  default     = null
}
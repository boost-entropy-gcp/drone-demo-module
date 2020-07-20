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
# Setup variables for the Ansible inventory
# -------------------------
resource "local_file" "ansible_inventory_file" {
  content  = templatefile("./templates/ansible_inventory.tpl", {
    gcp_F5_public_ip                = var.f5_public_ip
    gcp_F5_private_ip               = var.f5_private_ip
    gcp_nginx_ig_self_link          = var.nginx_instancegroup_self_link
    gcp_nginx_public_ip             = var.nginx_public_ip
    gcp_nginx_private_ip            = var.nginx_private_ip
    gcp_nginx_controller_public_ip  = var.nginx_controller_public_ip
    gcp_nginx_controller_private_ip = var.nginx_controller_private_ip
    gcp_consul_public_ip            = var.consul_public_ip
    gcp_consul_private_ip           = var.consul_private_ip
    gcp_gke_cluster_name            = var.gke_cluster_name
    gcp_gke_endpoint                = var.gke_endpoint
  })
  filename = "${var.terragrunt_path}/../../ansible/playbooks/inventory/hosts"
}

resource "local_file" "ansible_f5_vars_file" {
  content  = templatefile("./templates/ansible_f5_vars.tpl", {
    gcp_tag_value         = var.app_tag_value
    #use below var for multiple nginx deployements
    #gcp_f5_pool_members  = join("','", dependency.nginx.outputs.nginx_private_ip)
    gcp_f5_pool_members   = var.nginx_private_ip
    gcp_gke_username      = var.cluster_username
    gcp_gke_password      = var.cluster_password
  })
  filename = "${var.terragrunt_path}/../../ansible/playbooks/group_vars/F5_systems/vars"
}

resource "local_file" "ansible_nginx_controller_vars_file" {
  content  = templatefile("./templates/ansible_nginx_controller_vars.tpl", {})
  filename = "${var.terragrunt_path}/../../ansible/playbooks/group_vars/gcp_nginx_controller_systems/vars"
}
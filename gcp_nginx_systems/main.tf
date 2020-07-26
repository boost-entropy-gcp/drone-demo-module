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
# Create NGINX instance in instance group manager
# -------------------------

#Remove health checks since consul will do it, and also Health check probes come from addresses in the ranges 
#130.211.0.0/22 and 35.191.0.0/16, so make sure your network firewall rules allow the health check to connect. 
// resource "google_compute_health_check" "autohealing" {
//   name                = "${var.name_prefix}-healthcheck1"
//   check_interval_sec  = 5
//   timeout_sec         = 5
//   healthy_threshold   = 2
//   unhealthy_threshold = 10 # 50 seconds

//   http_health_check {
//     request_path = "/"
//     port         = "80"
//   }
// }

resource "google_compute_instance_group_manager" "nginx_group_manager" {
  name = "${var.name_prefix}-nginx-igm"

  base_instance_name = "${var.name_prefix}-nginx"
  zone               = var.zone

  version {
    instance_template  = google_compute_instance_template.nginx_template.self_link
  }

  target_size  = 2

  auto_healing_policies {
    health_check      = google_compute_health_check.autohealing.id
    initial_delay_sec = 300
  }
}

resource "google_compute_instance_template" "nginx_template" {
  # Must be a match of regex '(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?)'
  name           = "${var.name_prefix}-instance-template-nginx1"
  #name_prefix  = "${var.application}-instance-template-"
  machine_type   = var.nginx_instance_type
  can_ip_forward = false

  # Network tags. Must be a match of regex '(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?)'
  tags = var.tag

  disk {
    source_image = var.source_image
  }

  metadata = {
    enable-oslogin = "FALSE"
  }

  network_interface {
    #network = "${var.network}"
    subnetwork = var.subnetwork

    # Add Public IP to instances
    access_config {
      nat_ip = var.static_ip
    }

  }

  metadata_startup_script = templatefile("${path.module}/templates/nginx_onboard.tpl", {
    CONSUL_VERSION  = var.consul_version
    PROJECT_NAME    = var.project
  })
}
# Below used to spin up one NGINX plus instance
// resource "google_compute_instance" "nginx1" {
//   project             = var.project
//   name                = "${var.name_prefix}-nginx"
//   machine_type        = var.nginx_instance_type
//   zone                = var.zone
//   # Instance labels to apply to the instance
//   labels = {
//     app = var.app_tag_value
//   }
//   # tag to use for applying firewall rules 
//   tags = var.tag

//   boot_disk {
//     initialize_params {
//       image = var.source_image
//     }
//   }
  
//   metadata = {
//     enable-oslogin = "FALSE"
//   }

//   network_interface {
//     subnetwork = var.subnetwork

//     # If var.static_ip is set use that IP, otherwise this will generate an ephemeral IP
//     access_config {
//       nat_ip = var.static_ip
//     }
//   }

//   metadata_startup_script  = var.startup_script
     
// }
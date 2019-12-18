terraform {
  # This module has been updated with 0.12 syntax, which means it is no longer compatible with any versions below 0.12.
  required_version = ">= 0.12"
}

# -------------------------
# Data resource to create the user_data script
# -------------------------

data "template_file" "f5_bigip_onboard" {
  template = file("./templates/f5_onboard.tpl")

  vars = {
    DO_URL          = var.DO_URL
    AS3_URL		      = var.AS3_URL
    libs_dir		    = var.libs_dir
    onboard_log		  = var.onboard_log
  }
}

# -------------------------
# Create F5 instance 
# -------------------------


resource "google_compute_instance" "f5_bigip1" {
  project      = var.project
  name         = "${var.name_prefix}-bigip"
  machine_type = var.f5_instance_type
  zone         = var.zone
  # tag to use for applying firewall rules 
  tags = var.tag

  boot_disk {
    initialize_params {
      image = var.source_image
    }
  }

  network_interface {
    subnetwork = var.subnetwork

    # If var.static_ip is set use that IP, otherwise this will generate an ephemeral IP
    access_config {
      nat_ip = var.static_ip
    }
  }

  metadata_startup_script = "${data.template_file.f5_bigip_onboard.rendered}"
}
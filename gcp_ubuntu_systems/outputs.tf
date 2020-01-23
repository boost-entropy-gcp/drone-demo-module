output "ubuntu_instance" {
  description = "A reference (self_link) to the ubuntu host's VM instance"
  value       = google_compute_instance.ubuntu.self_link
}

output "ubuntu_public_ip" {
  description = "The public IP of the ubuntu instance."
  value       = google_compute_instance.ubuntu.network_interface[0].access_config[0].nat_ip
}

output "ubuntu_private_ip" {
  description = "The private IP of the ubuntu instance."
  value       = google_compute_instance.ubuntu.network_interface[0].network_ip
}

output "app_tag_value" {
  description = "The tag of the ubuntu instance."
  value       = google_compute_instance.ubuntu.tags
}
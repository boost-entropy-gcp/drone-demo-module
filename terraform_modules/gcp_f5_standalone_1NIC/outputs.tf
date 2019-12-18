output "instance" {
  description = "A reference (self_link) to the F5 VM instance."
  value       = google_compute_instance.f5_bigip1.self_link
}

output "f5_private_ip" {
  description = "The private IP of the F5 VM instance."
  value       = google_compute_instance.f5_bigip1.network_interface[0].network_ip
}

output "f5_public_ip" {
  description = "The public IP the F5 VM instance."
  value       = google_compute_instance.f5_bigip1.network_interface[0].access_config[0].nat_ip
}
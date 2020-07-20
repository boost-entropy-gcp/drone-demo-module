output "instance" {
  description = "A reference (self_link) to the consul VM instance."
  value       = google_compute_instance.consul.self_link
}

output "consul_private_ip" {
  description = "The private IP of the consul VM instance."
  value       = google_compute_instance.consul.network_interface[0].network_ip
}

output "consul_public_ip" {
  description = "The public IP the consul VM instance."
  value       = google_compute_instance.consul.network_interface[0].access_config[0].nat_ip
}
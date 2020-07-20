// output "nginx_instance" {
//   description = "A reference (self_link) to the nginx host's VM instance"
//   value       = google_compute_instance.nginx1.self_link
// }

// output "nginx_public_ip" {
//   description = "The public IP of the nginx instance."
//   value       = google_compute_instance.nginx1.network_interface[0].access_config[0].nat_ip
// }

// output "nginx_private_ip" {
//   description = "The private IP of the nginx instance."
//   value       = google_compute_instance.nginx1.network_interface[0].network_ip
// }

// output "app_tag_value" {
//   description = "The tag of the nginx instance."
//   value       = google_compute_instance.nginx1.tags
// }

output "nginx_instancegroup_self_link" {
  description = "The tag of the nginx instance."
  value       = google_compute_instance_template.nginx_group_manager.self_link
}
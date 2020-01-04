[gcp_nginx_systems]
${gcp_nginx_data}

[gke_systems]
# Must be in the form of <gke public IP> gke_url=<https URL of the endpoint>
${gcp_gke_endpoint}  gke_url=https://${gcp_gke_endpoint}

[gke_name]
${gcp_gke_cluster_name}

[F5_systems]
# Must be in the form of <public IP> vs_ip=<private ip of the F5>
${gcp_F5_public_ip} vs_ip=${gcp_F5_private_ip}

[gcp_nginx_systems:vars]
ansible_python_interpreter=/usr/bin/python3
# Enter in the user associated with the instance ssh key registered in GCP
ansible_user=f5user
# The location of the instance ssh key.
ansible_ssh_private_key_file=/drone/src/gcp/gcp_ssh_key

[gke_systems:vars]

[F5_systems:vars]
ansible_user=admin
ansible_ssh_private_key_file=/drone/src/gcp/gcp_ssh_key

[all:vars]
# ep_list is used for defining the upstreams in the NGINX configuration. It can be given a default value and can be overriden later using set_fact in a role i.e. NGINX endpoints creation role
ep_list=default('undefined')

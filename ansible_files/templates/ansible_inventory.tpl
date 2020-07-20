[gcp_nginx_systems]
#${gcp_nginx_public_ip} private_ip=${gcp_nginx_private_ip}
${gcp_nginx_ig_self_link}

[gcp_nginx_controller_systems]
${gcp_nginx_controller_public_ip} private_ip=${gcp_nginx_controller_private_ip}

[gke_systems]
# Must be in the form of <gke public IP> gke_url=<https URL of the endpoint>
${gcp_gke_endpoint}  gke_url=https://${gcp_gke_endpoint}

[gke_name]
${gcp_gke_cluster_name}

[F5_systems]
# Must be in the form of <public IP> vs_ip=<private ip of the F5>
${gcp_F5_public_ip} vs_ip=${gcp_F5_private_ip}

[consul_systems]
${gcp_consul_public_ip} private_ip=${gcp_consul_private_ip}

[gcp_nginx_systems:vars]
ansible_python_interpreter=/usr/bin/python3
# Enter in the user associated with the instance ssh key registered in GCP
ansible_user=f5user
# The location of the instance ssh key.
ansible_ssh_private_key_file=/drone/src/gcp/gcp_ssh_key

[gcp_nginx_controller_systems:vars]
ansible_python_interpreter=/usr/bin/python3
# Enter in the user associated with the instance ssh key registered in GCP
ansible_user=f5user
# The location of the instance ssh key.
ansible_ssh_private_key_file=/drone/src/gcp/gcp_ssh_key
# The location of python
ansible_python_interpreter: /usr/bin/python

[gke_systems:vars]

[F5_systems:vars]
ansible_user=admin
ansible_ssh_private_key_file=/drone/src/gcp/gcp_ssh_key

[all:vars]
# ep_list is used for defining the upstreams in the NGINX configuration. It can be given a default value and can be overriden later using set_fact in a role i.e. NGINX endpoints creation role
ep_list=default('undefined')

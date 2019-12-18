Terraform and Ansible deployment templates
==========================================

This repo contains some generic templates to deploy systems using Terraform and Ansible.

Terraform is used to deploy the systems while Ansible will take care of the configuration of those systems.

Remarks - Terraform
-------------------

* Make sure you set the GOOGLE_CREDENTIALS environment variable to point to your GCP service account key (JSON file) in the host running terraform. 
* If using the tkam8/tfansible container on docker hub, make sure that you mount your GCP service account key credentials (JSON file) to /tmp/gcp_creds.json on the container. Terraform is configured to look here for GCP credentials via the GOOGLE_CREDENTIALS environment variable set in the dockerfile of the tfansible container. 
* Update terraform/terraform.tfvars to deploy the infrastructure components acordingly (specifically the AllowedIPs to allow access from your public IP to your env). If you want more customization, you may check terraform/variables.tf 
* Update terraform/templates/ansible_inventory.tpl file so that you specify the right ansible_python_interpreter for your local environment 
* Do *terraform init* / *terraform get* / *terraform plan* / *terraform apply* to deploy your infrastructure
* *terraform output* will give you the relevant public IPs related to your infrastructure.

Remarks - Ansible
-----------------

* ansible/inventory/hosts will be created automatically by Terraform. *vs_ip* in the hosts file is the PRIVATE IP of your BIG-IP.
* Playbooks/group_vars/F5_systems/vars will list the tags to look for to identify the AWS instances to define as pool members. This file is created automatically by Terraform
* Ansible and Terraform are configured to pass IP addresses of upstream endpoints to the AS3 declaration for automating the population of pool member IPs. 
* The AS3 declaration can be setup to do *Service Discovery* (OFF by default) to identify the NGINX instances deployed. To do so, AS3 needs to have access to your GCP infrastructure: It needs the base64 encoded private key. Ansible playbook is setup to look for 1 environment variable1: GCP_CREDS_RO. Make sure to setup this environment variables on the device triggering the ansible playbook
* Optionally, you can update ansible/playbooks/group_vars/all file with the location of your private key

  + Once it's done, encrypt the file with the command *ansible-vault encrypt ansible/playbooks/group_vars/F5_systems/f5_vault*
  + Update your ansible roles accordingly if needed.
* You can run *ansible-playbook -i inventory/hosts site.yml --ask-vault-pass*
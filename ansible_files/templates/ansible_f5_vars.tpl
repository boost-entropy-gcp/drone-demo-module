---

ADMIN_PASSWORD: "{{ lookup('env', 'BIGIP_PASS') }}"
ADMIN_HTTPS_PORT: "8443"
ADMIN_USER: "admin"
APP_TAG_KEY: "Application"
APP_TAG_VALUE: "${gcp_tag_value}"
K8S_AUTH_USERNAME: "['${gcp_gke_username}']"
K8S_AUTH_PASSWORD: "['${gcp_gke_password}']"
LIST_AS3_POOL_SERVERS: "['${gcp_f5_pool_members}']"
POSTGRESQL_PASSWORD: "{{ lookup('env', 'POSTGRESQL_PASS') }}"
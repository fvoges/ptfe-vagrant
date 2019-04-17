#!/bin/bash
set -e

fqdn=ptfe.$1

apt-get update
apt-get install -y jq

# Application Settings for PTFE
jq --arg fqdn $fqdn '.hostname.value = $fqdn' /vagrant/files/ptfe_settings.json > /tmp/ptfe_settings.json

# Create SSL Cert and Key
openssl req -new -days 365 -nodes -x509 -subj "/C=US/ST=Oregon/L=Portland/O=Hashicorp/CN=$fqdn" -keyout "/etc/ptfe_server.key" -out "/etc/ptfe_server.crt"

# Copy over the license file
cp /vagrant/files/license.rli /tmp/license.rli

#Copy over the replicated.conf file
jq --arg fqdn $fqdn '.TlsBootstrapHostname |= $fqdn' /vagrant/files/replicated.conf > /etc/replicated.conf

#Run the PTFE Installer
curl -o /tmp/install.sh https://install.terraform.io/ptfe/stable
bash /tmp/install.sh \
    no-proxy \
    private-address=$2 \
    public-address=$2

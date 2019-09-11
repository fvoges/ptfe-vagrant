#!/bin/bash
set -e

fqdn=ptfe.$1

apt-get update
apt-get install -y jq

# Application Settings for PTFE
jq --arg fqdn $fqdn '.hostname.value = $fqdn' /vagrant/files/ptfe_settings.json > /tmp/ptfe_settings.json

# Copy SSL cert and key
cp /vagrant/files/ptfe_server.* /etc
chmod 0600 /etc/ptfe_server.key

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

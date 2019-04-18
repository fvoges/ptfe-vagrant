#!/bin/bash

domain=$1

apt-get update
apt-get install -y curl openssh-server ca-certificates
# apt-get install -y postfix
curl https://packages.gitlab.com/install/repositories/gitlab/gitlab-ee/script.deb.sh | sudo bash
sudo EXTERNAL_URL="http://gitlab.$domain" apt-get install gitlab-ee

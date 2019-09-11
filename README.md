# ptfe-vagrant

Vagrant Environment for auto install pTFE including GitLab VCS

## Overview

This vagrant environment will provision two Ubuntu VirtualBox machines:

- Private Terraform Enterprise Server
- GitLab EE Server

## Requirements

BYOL (Bring your own license) installation requires you have a `.rli` license file

## Instructions

1. Copy your `.rli` file into the `/files` directory as `license.rli`
2. Update the `config.yaml` with any custom settings (domain/ip addresses)
3. Generate SSL certificate and import to MacOS Keychain

   ```shell
   DOMAIN='local' # get this value from config.yaml
   openssl req -new -days 365 -nodes -x509 -subj "/C=US/ST=California/L=San Francisco/O=HashiCorp/CN=ptfe.${DOMAIN}" -keyout "./files/ptfe_server.key" -out "./files/ptfe_server.crt"

   open "./files/ptfe_server.crt"
   ```

4. Run `vagrant up`
5. Set your hosts file to resolve the domains/ip addresses

   ```shell
   #/etc/hosts

   10.0.0.50 ptfe.local
   10.0.0.51 gitlab.local

   # Hack-y, but works..
   10.0.0.50 archivist.ptfe
   10.0.0.50 atlas.ptfe
   10.0.0.50 influxdb.ptfe
   10.0.0.50 nginx.ptfe
   10.0.0.50 nomad.ptfe
   10.0.0.50 postgres
   10.0.0.50 rabbitmq
   10.0.0.50 redis
   10.0.0.50 slug-ingress.ptfe
   10.0.0.50 telegraf.ptfe
   10.0.0.50 terraform-state-parser.ptfe
   10.0.0.50 vault.ptfe
   ```

6. Finish pTFE setup at <http://ptfe.local:8800>
     - Login with [unlock password](https://github.com/sshastri/ptfe-vagrant/blob/master/files/replicated.conf#L3)
     - Create admin account/password
     - Create user token
     - Rename `./modules/variables.auto.tfvars.example` -> `./modules/variables.auto.tfvars`
     - Set token in `./modules/variables.auto.tfvars`
7. Finish GitLab server setup at http://gitlab.local
     - Set the root password
     - Login
     - Create a token (<http://gitlab.local/profile/personal_access_tokens>)
     - Set token in `./modules/variables.auto.tfvars`
8. Run Terraform

   ```shell
   cd ./modules
   terraform init
   terraform plan
   terraform apply
   ```

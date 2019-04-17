# ptfe-vagrant
Vagrant Environment for auto install pTFE including Gitlab VCS

### Overview

This vagrant environment will provision two Ubuntu VirtualBox machines:
 - Private Terraform Enterprise Server
 - Gitlab EE Server

 *Important:* BYOL (Bring your own license) Installation requires you have a .rli license file

### Instructions

- Step 1: Copy the .rli file into the /files directory as license.rli

- Step 2: Update the config.yaml with any custom settings (domain/ipaddresses)

- Step 3: `vagrant up`

- Step 4: Set your hosts file to resolve the domains/ipaddrs

```
#/etc/hosts

10.0.0.50 ptfe.local
10.0.0.51 gitlab.local

# Hack-y, but works..
10.0.0.50	archivist.ptfe
10.0.0.50	atlas.ptfe
10.0.0.50	influxdb.ptfe
10.0.0.50	nginx.ptfe
10.0.0.50	nomad.ptfe
10.0.0.50	postgres
10.0.0.50	rabbitmq
10.0.0.50	redis
10.0.0.50	slug-ingress.ptfe
10.0.0.50	telegraf.ptfe
10.0.0.50	terraform-state-parser.ptfe
10.0.0.50	vault.ptfe

```


- Finish ptfe setup at http://ptfe.local:8800
- The gitlab server is available at http://gitlab.local

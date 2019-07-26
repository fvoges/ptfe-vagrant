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

- Step 5: Finish ptfe setup at http://ptfe.local:8800
  - Login with [unlock password](https://github.com/sshastri/ptfe-vagrant/blob/master/files/replicated.conf#L3) 
  - Create admin account/password
  - Create user token
  - Rename /modules/variables.auto.tfvars.example -> /modules/variables.auto.tfvars. Set token

- Step 6: Finish gitlab server setup at http://gitlab.local
  - Set the root password
  - Login
  - Create a token (http://gitlab.local/profile/personal_access_tokens). Set token in variables.auto.tfvars

- Step 7: Run Terraform
```
  cd ./modules
  terraform init
  terraform plan
  terraform apply
```

If you get this error:
 ```
 Error: Error running plan: 1 error(s) occurred:

* provider.tfe: Failed to request discovery document: Get https://ptfe.local/.well-known/terraform.json: x509: certificate signed by unknown authority
````

_Workaround_ The certificate at /etc/ptfe_server.crt on the ptfe box needs to be added to the Mac OS Keychain. Copy the cert from the vagrant box and File -> Import Items... to select the certificate.
TODO: Figure out a way to automate this.

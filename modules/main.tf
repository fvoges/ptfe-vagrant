# Configure the Terraform Enterprise Provider
provider "tfe" {
  hostname = "${var.hostname}"
  token    = "${var.token}"
}

# Create an organization
resource "tfe_organization" "org" {
  name  = "${var.org_name}"
  email = "tfeadmin@hashicorp.com"
}

# Create a team
resource "tfe_team" "team" {
  name         = "${var.team_name}"
  organization = "${tfe_organization.org.name}"
}

# Create a workspace
resource "tfe_workspace" "workspace" {
  name         = "${var.workspace_name}"
  organization = "${tfe_organization.org.name}"
}


resource "tfe_oauth_client" "gitlab" {
  organization     = "${var.org_name}"
  api_url          = "http://gitlab.local/api/v4"
  http_url         = "https://gitlab.local"
  oauth_token      = "${var.gitlab_oauth}"
  service_provider = "gitlab_community_edition"
}

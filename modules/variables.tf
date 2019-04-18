
variable "hostname" {
  description = "Hostname of the pTFE server"
  type        = "string"
}

variable "token" {
  description = "OAuth Token for connectivity to pTFE"
  type        = "string"
}

variable "org_name" {
  description  = "Name of Organization"
  type         = "string"
}

variable "team_name" {
  description  = "Team Name"
  type         = "string"
}

variable "workspace_name" {
  description  = "Workspace name"
  type         = "string"
}

variable "gitlab_oauth" {
  description = "Personal access token in GitLab"
  type        = "string"
}

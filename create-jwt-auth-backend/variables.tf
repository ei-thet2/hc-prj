variable "jwt_backend_path" {
  type        = string
  default     = "jwt"
  description = "The path at which you'd like to mount the jwt auth backend in Vault"
}

variable "tfc_vault_audience" {
  type        = string
  default     = "vault.workload.identity"
  description = "The audience value to use in run identity tokens"
}

variable "tfc_hostname" {
  type        = string
  default     = "app.terraform.io"
  description = "The hostname of the TFC or TFE instance you'd like to use with Vault"
}

variable "tfc_role_name" {
  type        = string
  default     = "tfc-kv-secret-role"
  description = "This role is to test to create KV Secret with this jwt secret backend with tfc"
}

variable "tfc_organization_name" {
  type        = string
  description = "The name of your Terraform Cloud organization"
  default     = "hc-tfc"
}

variable "tfc_project_name" {
  type        = string
  description = "The project under which a workspace will be created"
  default = "Default Project"
}

variable "tfc_workspace_name" {
  type        = string
  default     = "*"
  description = "The name of the workspace that you'd like to create and connect to Vault"
}

variable "aws-secret-role" {
  type        = string
  default     = "aws-secret-role"
  description = "This role is to test to create KV Secret with this jwt secret backend with tfc"
}

variable "admin-role" {
  type        = string
  default     = "admin-role"
  description = "This role is to test to create KV Secret with this jwt secret backend with tfc"
}
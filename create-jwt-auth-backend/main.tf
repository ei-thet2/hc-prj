resource "vault_jwt_auth_backend" "tfc_jwt" {
  path               = var.jwt_backend_path
  type               = "jwt"
  oidc_discovery_url = "https://${var.tfc_hostname}"
  bound_issuer       = "https://${var.tfc_hostname}"
}

resource "vault_policy" "tfc_policy" {
  name = "tfc-policy"

  policy = <<EOT
# Allow tokens to query themselves
path "auth/token/lookup-self" {
  capabilities = ["read"]
}

# Allow tokens to renew themselves
path "auth/token/renew-self" {
    capabilities = ["update"]
}

# Allow tokens to revoke themselves
path "auth/token/revoke-self" {
    capabilities = ["update"]
}

path "sys/mounts" {
  capabilities = ["list", "read"]
}

path "sys/mounts/example" {
  capabilities = ["create", "read", "update", "patch", "delete", "list"]
}

path "example/*" {
  capabilities = ["create", "read", "update", "patch", "delete", "list"]
}
EOT
}

resource "vault_jwt_auth_backend_role" "tfc_role" {
  backend = vault_jwt_auth_backend.tfc_jwt.path
  role_name = var.tfc_role_name
  token_policies = [vault_policy.tfc_policy.name]

  bound_audiences = [var.tfc_vault_audience]

  bound_claims_type = "glob"
  bound_claims = {
    sub = "organization:${var.tfc_organization_name}:project:${var.tfc_project_name}:workspace:${var.tfc_workspace_name}:run_phase:*"
  }

  user_claim = "terraform_full_workspace"
  role_type  = "jwt"
  token_ttl  = 1200 
}

### aws-secret-role

resource "vault_policy" "aws-secret-policy" {
  name = "aws-secret-policy"

  policy = <<EOT
# Allow tokens to query themselves
path "auth/token/lookup-self" {
  capabilities = ["read"]
}

# Allow tokens to renew themselves
path "auth/token/renew-self" {
    capabilities = ["update"]
}

# Allow tokens to revoke themselves
path "auth/token/revoke-self" {
    capabilities = ["update"]
}

path "sys/mounts" {
  capabilities = ["list", "read"]
}

path "aws-master-account/" {
  capabilities = ["read","list"]
}
path "aws-master-account/*" {
  capabilities = ["read","list"]
}
EOT
}

resource "vault_jwt_auth_backend_role" "aws-secret-role" {
  backend = vault_jwt_auth_backend.tfc_jwt.path
  role_name = var.aws-secret-role
  token_policies = [vault_policy.aws-secret-policy.name]

  bound_audiences = [var.tfc_vault_audience]

  bound_claims_type = "glob"
  bound_claims = {
    sub = "organization:${var.tfc_organization_name}:project:${var.tfc_project_name}:workspace:${var.tfc_workspace_name}:run_phase:*"
  }

  user_claim = "terraform_full_workspace"
  role_type  = "jwt"
  token_ttl  = 1200 
}

### admin-role

resource "vault_policy" "admin-policy" {
  name = "admin-policy"

  policy = <<EOT
path "auth/*"
{
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}
# Create, update, and delete auth methods
path "sys/auth/*"
{
  capabilities = ["create", "update", "delete", "sudo"]
}
# List auth methods
path "sys/auth"
{
  capabilities = ["read"]
}
# Enable and manage the key/value secrets engine at `secret/` path
# List, create, update, and delete key/value secrets
path "secret/*"
{
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}
# Manage secrets engines
path "sys/mounts/*"
{
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}
# List existing secrets engines.
path "sys/mounts"
{
  capabilities = ["read"]
}
path "aws-master-account/" {
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}
path "aws-master-account/*" {
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}
path "sys/policy/*" {
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}
path "sys/policy/" {
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}
EOT
}

resource "vault_jwt_auth_backend_role" "admin-role" {
  backend = vault_jwt_auth_backend.tfc_jwt.path
  role_name = var.admin-role
  token_policies = [vault_policy.admin-policy.name]

  bound_audiences = [var.tfc_vault_audience]

  bound_claims_type = "glob"
  bound_claims = {
    sub = "organization:${var.tfc_organization_name}:project:${var.tfc_project_name}:workspace:${var.tfc_workspace_name}:run_phase:*"
  }

  user_claim = "terraform_full_workspace"
  role_type  = "jwt"
  token_ttl  = 1200 
}
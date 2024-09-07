data "hcp_hvn" "hcp_vault" {
  hvn_id = var.hvn_id
}

data "vault_aws_access_credentials" "master_netadmin_creds" {
  backend = var.backend_path
  role    = var.backend_role
}
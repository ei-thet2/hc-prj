#################################################################################
### TFC WorkSpace Variable
#################################################################################
variable "workspace_name" {
  description = "Workspace Name"
  type = string
  default = "create_rds_ec2"
}
variable "org_name" {
  description = "Organization Name"
  type = string
  default = "hc-tfc"
}
variable "vault_url" {
  description = "The address of the Vault instance runs will access."
  type = string
  default = "https://aws-hcp-vault-cluster-public-vault-62fead3d.1abe51a4.z1.hashicorp.cloud:8200"
}
variable "run_role" {
  description = "TFC_VAULT_RUN_ROLE"
  type = string
  default = "admin-role"
}
variable "vault_namespace" {
  description = "TFC_VAULT_NAMESPACE"
  type = string
  default = "admin"
}
variable "aws_mount_path" {
  description = "TFC_VAULT_BACKED_AWS_MOUNT_PATH"
  type = string
  default = "aws-master-account"
}
variable "aws_auth_type" {
  description = "TFC_VAULT_BACKED_AWS_AUTH_TYPE"
  type = string
  default = "iam_user"
}
variable "aws_secret_role" {
  description = "TFC_VAULT_BACKED_AWS_RUN_VAULT_ROLE"
  type = string
  default = "master-iamadmin-role"
}
variable "aws_region" {
  description = "AWS_REGION"
  type = string
  default = "ap-southeast-1"
}







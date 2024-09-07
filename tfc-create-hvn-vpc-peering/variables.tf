variable "hvn_id" {
  description = "The ID of the HashiCorp Virtual Network (HVN)."
  type = string
  default = "aws-hcp-vault-hvn"
}

variable "hvn_to_vpc" {
  description = "The ID of the network peering."
  type = string
  default = "hvn-to-vpc-peering"
}

variable "vpc_id" {
  description = "The ID of the peer VPC in AWS."
  type = string
  default = "vpc-0e88cbad1d0ab4ac6"
}

variable "vpc_owner_id" {
  description = "The account ID of the peer VPC in AWS."
  type = string
  default = "533267411943"
}

variable "vpc_region" {
  description = "The region of the peer VPC in AWS."
  type = string
  default = "ap-southeast-1"
}

variable "private_routetable_id" {
  description = "private routetable id"
  type = string
  default = "rtb-0c2f955c88a9f1c4c"
}

variable "db_routetable_id" {
  description = "db routetable id"
  type = string
  default = "rtb-0efef34d4b0c8bafd"
}

# Vault Read Secret
variable "backend_path" {
    description = "Vault AWS Secret Path"
    type = string
    default = "aws-master-account"
}

variable "backend_role" {
    description = "Vault AWS Secret Role"
    type = string
    default = "master-iamadmin-role"
}

variable "aws_region" {
    description = "AWS Region for Vault AWS Secret Role"
    default = "ap-southeast-1"
}
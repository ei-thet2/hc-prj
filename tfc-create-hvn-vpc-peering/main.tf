resource "hcp_aws_network_peering" "dev" {
  hvn_id          = var.hvn_id
  peering_id      = var.hvn_to_vpc
  peer_vpc_id     = var.vpc_id
  peer_account_id = var.vpc_owner_id
  peer_vpc_region = var.vpc_region
}

resource "aws_vpc_peering_connection_accepter" "peer" {
  vpc_peering_connection_id = hcp_aws_network_peering.dev.provider_peering_id
  auto_accept               = true
}

resource "hcp_hvn_route" "main-to-dev" {
  hvn_link         = data.hcp_hvn.hcp_vault.self_link
  hvn_route_id     = "main-to-aws"
  destination_cidr = "10.10.0.0/16"
  target_link      = hcp_aws_network_peering.dev.self_link
}

resource "aws_route" "route_for_private" {
  route_table_id            = var.private_routetable_id
  destination_cidr_block    = data.hcp_hvn.hcp_vault.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection_accepter.peer.id
}

resource "aws_route" "route_for_db" {
  route_table_id            = var.db_routetable_id
  destination_cidr_block    = data.hcp_hvn.hcp_vault.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection_accepter.peer.id
}
# Routes from HQ region start here
# Route from HQ to DR
resource "aws_route" "route_hq_to_dr" {
  provider = aws.hq_provider

  route_table_id = data.aws_route_table.route_table_id_hq_region.route_table_id

  destination_cidr_block    = var.clusters.eu.vpc_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.peering_source_to_dr.id

  depends_on = [aws_vpc_peering_connection.peering_source_to_dr, aws_vpc_peering_connection_accepter.peer_dr]
}

# Route from HQ to PR
resource "aws_route" "route_hq_to_pr" {
  provider = aws.hq_provider

  route_table_id = data.aws_route_table.route_table_id_hq_region.route_table_id

  destination_cidr_block    = var.clusters.ap.vpc_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.peering_source_to_pr.id

  depends_on = [aws_vpc_peering_connection.peering_source_to_pr, aws_vpc_peering_connection_accepter.peer_pr]
}

# Routes for DR region start here
# Route from DR to HQ
resource "aws_route" "route_dr_to_hq" {

  provider = aws.dr_provider

  route_table_id = data.aws_route_table.route_table_id_dr_region.route_table_id

  destination_cidr_block    = var.clusters.us.vpc_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.peering_source_to_dr.id

  depends_on = [aws_vpc_peering_connection.peering_source_to_dr, aws_vpc_peering_connection_accepter.peer_dr]
}

# Route from DR to PR
resource "aws_route" "route_dr_to_pr" {

  provider = aws.dr_provider

  route_table_id = data.aws_route_table.route_table_id_dr_region.route_table_id

  destination_cidr_block    = var.clusters.ap.vpc_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.peering_dr_to_pr.id

  depends_on = [aws_vpc_peering_connection.peering_dr_to_pr, aws_vpc_peering_connection_accepter.peer_dr_pr]
}

# Routes for PR start here
# Route from PR to HQ 
resource "aws_route" "route_pr_to_hq" {

  provider = aws.pr_provider

  route_table_id = data.aws_route_table.route_table_id_pr_region.route_table_id

  destination_cidr_block    = var.clusters.us.vpc_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.peering_source_to_pr.id

  depends_on = [aws_vpc_peering_connection.peering_source_to_pr, aws_vpc_peering_connection_accepter.peer_pr]
}

# Route from PR to DR
resource "aws_route" "route_pr_to_dr" {

  provider = aws.pr_provider

  route_table_id = data.aws_route_table.route_table_id_pr_region.route_table_id

  destination_cidr_block    = var.clusters.eu.vpc_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.peering_dr_to_pr.id

  depends_on = [aws_vpc_peering_connection.peering_dr_to_pr, aws_vpc_peering_connection_accepter.peer_dr_pr]
}
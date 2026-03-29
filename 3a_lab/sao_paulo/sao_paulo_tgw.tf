# Explanation: Liberdade is São Paulo's Japanese town—local doctors, local compute, remote data.
resource "aws_ec2_transit_gateway" "liberdade_tgw01" {
  provider    = aws.saopaulo
  description = "liberdade-tgw01 (Sao Paulo spoke)"

  tags = { Name = "liberdade-tgw01" }
}

# Explanation: Liberdade attaches its TGW to the São Paulo VPC—compute can now reach Tokyo legally.
resource "aws_ec2_transit_gateway_vpc_attachment" "liberdade_attach_sp_vpc01" {
  provider           = aws.saopaulo
  transit_gateway_id = aws_ec2_transit_gateway.liberdade_tgw01.id
  vpc_id             = aws_vpc.liberdade_011826-vpc01.id
  subnet_ids         = aws_subnet.liberdade_private_subnets[*].id

  tags = { Name = "liberdade-attach-sp-vpc01" }
}

# Explanation: Liberdade accepts the handshake from Shinjuku—the corridor is now open, controlled, and auditable.
resource "aws_ec2_transit_gateway_peering_attachment_accepter" "liberdade_accept_peer01" {
  provider                      = aws.saopaulo
  transit_gateway_attachment_id = var.shinjuku_peering_attachment_id # supplied from Tokyo outputs

  tags = { Name = "liberdade-accept-peer01" }
}

# Explanation: São Paulo TGW needs a static route back to Tokyo through the peering attachment.
resource "aws_ec2_transit_gateway_route" "liberdade_tgw_to_tokyo_route01" {
  provider                       = aws.saopaulo
  transit_gateway_route_table_id = aws_ec2_transit_gateway.liberdade_tgw01.association_default_route_table_id
  destination_cidr_block         = var.tokyo_vpc_cidr
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_peering_attachment_accepter.liberdade_accept_peer01.id

  depends_on = [aws_ec2_transit_gateway_peering_attachment_accepter.liberdade_accept_peer01]
}

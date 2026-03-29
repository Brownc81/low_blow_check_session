# Explanation: Shinjuku Station is the hub—Tokyo is the data authority, all roads lead here.
resource "aws_ec2_transit_gateway" "shinjuku_tgw01" {
  description = "shinjuku-tgw01 (Tokyo hub)"

  tags = { Name = "shinjuku-tgw01" }
}

# Explanation: Shinjuku connects its TGW to the Tokyo VPC—this is the gate to the medical records vault.
resource "aws_ec2_transit_gateway_vpc_attachment" "shinjuku_attach_tokyo_vpc01" {
  transit_gateway_id = aws_ec2_transit_gateway.shinjuku_tgw01.id
  vpc_id             = aws_vpc.shinjuku_011826-vpc01.id
  subnet_ids         = aws_subnet.shinjuku_private_subnets[*].id

  tags = { Name = "shinjuku-attach-tokyo-vpc01" }
}

# Explanation: Shinjuku opens the corridor request to Liberdade—compute may travel, PHI may not.
# NOTE: peer_transit_gateway_id comes from São Paulo outputs. Apply São Paulo TGW first.
resource "aws_ec2_transit_gateway_peering_attachment" "shinjuku_to_liberdade_peer01" {
  transit_gateway_id      = aws_ec2_transit_gateway.shinjuku_tgw01.id
  peer_region             = "sa-east-1"
  peer_transit_gateway_id = var.saopaulo_tgw_id

  tags = { Name = "shinjuku-to-liberdade-peer01" }
}

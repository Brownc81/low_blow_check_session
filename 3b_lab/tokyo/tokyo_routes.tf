# Explanation: Shinjuku returns traffic to Liberdade—because doctors need answers, not one-way tunnels.
resource "aws_route" "shinjuku_to_sp_route01" {
  route_table_id         = aws_route_table.shinjuku_private_rt01.id
  destination_cidr_block = var.saopaulo_vpc_cidr
  transit_gateway_id     = aws_ec2_transit_gateway.shinjuku_tgw01.id

  depends_on = [aws_ec2_transit_gateway_vpc_attachment.shinjuku_attach_tokyo_vpc01]
}

# Explanation: Tokyo TGW also needs a static route in its own route table pointing to the peering attachment.
resource "aws_ec2_transit_gateway_route" "shinjuku_tgw_to_sp_route01" {
  transit_gateway_route_table_id = aws_ec2_transit_gateway.shinjuku_tgw01.association_default_route_table_id
  destination_cidr_block         = var.saopaulo_vpc_cidr
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_peering_attachment.shinjuku_to_liberdade_peer01.id

  depends_on = [aws_ec2_transit_gateway_peering_attachment.shinjuku_to_liberdade_peer01]
}

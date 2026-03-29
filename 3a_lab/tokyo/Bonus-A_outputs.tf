#Bonus-A outputs (append to outputs.tf)

# Explanation: These outputs prove shinjuku built private hyperspace lanes (endpoints) instead of public chaos.
output "shinjuku_vpce_ssm_id" {
  value = aws_vpc_endpoint.shinjuku_vpce_ssm01.id
}

output "shinjuku_vpce_logs_id" {
  value = aws_vpc_endpoint.shinjuku_vpce_logs01.id
}

output "shinjuku_vpce_secrets_id" {
  value = aws_vpc_endpoint.shinjuku_vpce_secrets01.id
}

output "shinjuku_vpce_s3_id" {
  value = aws_vpc_endpoint.shinjuku_vpce_s3_gw01.id
}

output "shinjuku_private_ec2_instance_id_bonus" {
  value = aws_instance.shinjuku_ec201_private_bonus.id
}



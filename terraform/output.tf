output "ec2_id" {
  value = aws_instance.this_ec2.id
}

output "ec2_private_ip" {
  value = aws_instance.this_ec2.private_ip
}

output "ec2_public_ip" {
  value = aws_instance.this_ec2.public_ip
}
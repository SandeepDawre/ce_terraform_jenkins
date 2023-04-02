resource "aws_instance" "this_ec2" {
  ami           = var.ami_id 
  instance_type = var.instance_type 
}
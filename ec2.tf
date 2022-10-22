# Search for AMI
data "aws_ami" "ami-image" {
  most_recent = true
  name_regex  = "amzn2-ami-hvm-2.0.20210427.0-x86_64-gp2"
  owners      = ["amazon"]
}

# Create EC2
resource "aws_instance" "instance" {
  count                       = var.instance_count
  ami                         = data.aws_ami.ami-image.id
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  key_name                    = aws_key_pair.my-key.key_name
  vpc_security_group_ids      = [aws_security_group.my-sg.id]
  subnet_id                   = aws_subnet.my-subnet1.id

  tags = {
    Name = "linux2cloud-ec2-${count.index}"
  }

}

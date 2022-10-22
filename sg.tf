# Create SG in vpc
resource "aws_security_group" "my-sg" {
  description = "Allow TCP"
  egress      = []
  ingress = [
    {
      cidr_blocks = [
        "0.0.0.0/0",
      ]
      description      = "Allow SSH traffic"
      from_port        = 22
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 22
    },
  ]
  name     = var.my_sg
  tags     = {}
  tags_all = {}
  vpc_id   = aws_vpc.my-vpc.id

  timeouts {}
}

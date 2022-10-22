#Create key-pair for logging into EC2
resource "aws_key_pair" "my-key" {
  key_name   = var.my_key
  public_key = file("~/.ssh/id_rsa.pub")
}

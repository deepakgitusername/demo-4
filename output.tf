# Print Output
output "instance_public_ip" {
  description = "Login to instance using ec2-user@<public IP of EC instance>"
  value = {
    for server_info in aws_instance.instance[*] :
    server_info.tags.Name => server_info.public_ip
  }
}

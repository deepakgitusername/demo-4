## Creating VPC
resource "aws_vpc" "my-vpc" {
  assign_generated_ipv6_cidr_block = false
  cidr_block                       = var.my_vpc
  enable_classiclink               = false
  enable_classiclink_dns_support   = false
  enable_dns_hostnames             = var.dns_hostnames
  enable_dns_support               = true
  instance_tenancy                 = "default"
  tags = {
    "Name" = "linux2cloud-vpc"
  }
}

data "aws_availability_zones" "my_az" {
  state = "available"
}

# Creating Subnet in the vpc
resource "aws_subnet" "my-subnet1" {
  assign_ipv6_address_on_creation = false
  availability_zone               = data.aws_availability_zones.my_az.names[0]
  cidr_block                      = var.my_subnet
  tags = {
    "Name" = "linux2cloud-subnet1"
  }
  vpc_id = aws_vpc.my-vpc.id
}

# Creating gateway and attached with vpc
resource "aws_internet_gateway" "my-igw" {
  tags = {
    "Name" = "linux2cloud-gw"
  }
  vpc_id = aws_vpc.my-vpc.id
}

# Creating route table, add internet gateway and attach vpc
resource "aws_route_table" "my-route-table" {
  vpc_id = aws_vpc.my-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my-igw.id
  }

  tags = {
    "Name" = "linux2cloud-route-table"
  }
}

# Associate subnet and route with table
resource "aws_route_table_association" "my-route-association" {
  subnet_id      = aws_subnet.my-subnet1.id
  route_table_id = aws_route_table.my-route-table.id
}
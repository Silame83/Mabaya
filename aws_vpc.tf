provider "aws" {
  profile = "default"
  region = "us-east-2"
}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_vpc" "mabaya_vpc" {
  cidr_block = "10.100.0.0/16"

  tags = {
    Name = "Mabaya VPC"
  }
}

resource "aws_subnet" "mabaya_subnet" {
  cidr_block = "10.100.100.0/24"
  vpc_id = aws_vpc.mabaya_vpc.id
  availability_zone = data.aws_availability_zones.available.names[0]
  depends_on = [
    aws_internet_gateway.igw]
  tags = {
    Name = "Public subnet"
  }
}

resource "aws_eip" "ec2_ip" {
  vpc = true

  tags = {
    Name = "IP address for EC2 Instance"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.mabaya_vpc.id
  tags = {
    Name = "Internet Gateway"
  }
}

resource "aws_security_group" "sg_mabaya" {
  name = "SG-Mabaya"
  description = "SG Mabaya VPC"
  vpc_id = aws_vpc.mabaya_vpc.id

  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = [
      "0.0.0.0/0"]
  }

  ingress {
    from_port = 8008
    protocol = "tcp"
    to_port = 8008
    cidr_blocks = [
      "0.0.0.0/0"]
  }

  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = [
      "0.0.0.0/0"]
  }
  tags = {
    Name = "SG Mabaya"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.mabaya_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "Public RT"
  }
}

resource "aws_route_table_association" "public_rt_assign" {
  route_table_id = aws_route_table.public_rt.id
  subnet_id = aws_subnet.mabaya_subnet.id
}
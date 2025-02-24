provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "vpc_demo" {
  cidr_block           = "10.0.0.0/16"
  tags = {
    Name = "demo-vpc"
  }
}

resource "aws_subnet" "subnet_demo" {
  vpc_id     = aws_vpc.vpc_demo.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "demo-subnet"
  }
}

resource "aws_internet_gateway" "igw_demo" {
  vpc_id = aws_vpc.vpc_demo.id
  tags = {
    Name = "demo-igw"
  }
}

resource "aws_route_table" "rt_demo" {
  vpc_id = aws_vpc.vpc_demo.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_demo.id
  }
  tags = {
    Name = "demo-route-table"
  }
}

resource "aws_security_group" "sg_demo" {
  vpc_id = aws_vpc.vpc_demo.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "demo-sg"
  }
}

resource "aws_instance" "web" {
  ami           = var.ami
  instance_type = var.micro

  subnet_id              = aws_subnet.subnet_demo.id
  vpc_security_group_ids = [aws_security_group.sg_demo.id]

  tags = {
    Name = "web-server-1"
  }
}

resource "aws_s3_bucket" "demo_bkt_1" {
  bucket = "demo-bucket-78990904" # Replace with a globally unique name

  tags = {
    Name        = "demo-bkt-78990904"
  }
}
provider "aws" {
  version = "~> 2.0"
  region = "us-east-1"
}

# EC2 Instance dev
resource "aws_instance" "dev" {
    count = 1
    ami = "ami-0729e439b6769d6ab"
    instance_type = "t2.micro"
    key_name = "terraform"
    tags = {
        Name = "dev${count.index}"
    }
    vpc_security_group_ids = ["${aws_security_group.acesso-ssh.id}"]
}

# Security group to open acess by ssh
resource "aws_security_group" "acesso-ssh" {
  name        = "acesso-ssh"
  description = "acesso-ssh"

  ingress {
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["143.255.232.226/32"]
  }

  tags = {
    Name = "ssh"
  }
}

# Bucket S3 dev2
resource "aws_s3_bucket" "dev2" {
  bucket = "brfyamada-dv4-bucket"
  acl    = "private"

  tags = {
    Name = "brfyamada-dev2"
  }
}

# EC2 Instance dev2
resource "aws_instance" "dev2" {
    count = 1
    ami = "ami-0729e439b6769d6ab"
    instance_type = "t2.micro"
    key_name = "terraform-aws"
    tags = {
        Name = "dev2"
    }
    vpc_security_group_ids = ["${aws_security_group.acesso-ssh.id}"]
    depends_on = [
      aws_s3_bucket.dev2
    ]
}
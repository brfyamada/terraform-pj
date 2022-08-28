# Security group to open acess by ssh
resource "aws_security_group" "acesso-ssh" {
  name        = "acesso-ssh"
  description = "acesso-ssh"

  ingress {
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = var.cdirs_acesso_remoto
  }

  tags = {
    Name = "ssh"
  }
}


# Security group to open acess by ssh
resource "aws_security_group" "acesso-ssh-us-east-2" {
    provider = aws.us-east-2
    name        = "acesso-ssh"
    description = "acesso-ssh"

    ingress {
        description      = "TLS from VPC"
        from_port        = 22
        to_port          = 22
        protocol         = "tcp"
        cidr_blocks      = var.cdirs_acesso_remoto
    }

    tags = {
        Name = "ssh"
    }
}
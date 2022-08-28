provider "aws" {
  region = "us-east-1"
}

provider "aws" {
  alias = "us-east-2"
  region = "us-east-2"
}

# EC2 Instance dev
resource "aws_instance" "dev" {
    count = 1
    ami = var.amis["us-east-1"]
    instance_type = "t2.micro"
    key_name = var.key_name
    tags = {
        Name = "dev${count.index}"
    }
    vpc_security_group_ids = ["${aws_security_group.acesso-ssh.id}"]
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
    ami = var.amis["us-east-1"]
    instance_type = "t2.micro"
    key_name = var.key_name
    tags = {
        Name = "dev2"
    }
    vpc_security_group_ids = ["${aws_security_group.acesso-ssh.id}"]
    depends_on = [
      aws_s3_bucket.dev2
    ]
}

# EC2 Instance dev2
resource "aws_instance" "dev3" {
    provider = aws.us-east-2
    count = 1
    ami = var.amis["us-east-2"]
    instance_type = "t2.micro"
    key_name = var.key_name
    tags = {
        Name = "dev3"
    }
    vpc_security_group_ids = ["${aws_security_group.acesso-ssh-us-east-2.id}"]
    depends_on = [
      aws_dynamodb_table.dynamodb-homologacao
    ]
}

resource "aws_dynamodb_table" "dynamodb-homologacao" {
  provider = aws.us-east-2

  name             = "GameScores"
  billing_mode     = "PAY_PER_REQUEST"
  hash_key         = "UserId"
  range_key        = "GameTitle"

  attribute {
    name = "UserId"
    type = "S"
  }

  attribute {
    name = "GameTitle"
    type = "S"
  }
}

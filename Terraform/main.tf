provider "aws" {
  region = "eu-central-1"
}


resource "tls_private_key" "generated_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = "example-key"
  public_key = tls_private_key.generated_key.public_key_openssh
}

resource "local_file" "private_key" {
  content  = tls_private_key.generated_key.private_key_pem
  filename = "private_key.pem"
}

resource "aws_instance" "ec2_example" {

  ami = "ami-0767046d1677be5a0"
  instance_type = "t2.micro"
  key_name= aws_key_pair.generated_key.key_name
  vpc_security_group_ids = [aws_security_group.main.id]

  
}

resource "aws_security_group" "main" {
  egress = [
    {
      cidr_blocks      = [ "0.0.0.0/0", ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    }
  ]
  ingress                = [
    {
      cidr_blocks      = [ "0.0.0.0/0", ]
      description      = ""
      from_port        = 22
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 22
    },
    {
      cidr_blocks      = [ "0.0.0.0/0", ]
      description      = ""
      from_port        = 80
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 80
    },
    {
      cidr_blocks      = [ "0.0.0.0/0", ]
      description      = ""
      from_port        = 8080
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 8080
    }
  ]
}

resource "local_file" "public_ip" {
  content  = aws_instance.ec2_example.public_ip
  filename = "public_ip.txt"
}

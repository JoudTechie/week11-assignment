provider "aws" {
  region = "eu-north-1"
}

resource "aws_key_pair" "deployer" {
  key_name   = "new-mern-key"
  public_key = file("/home/joud-1999/terraform/week11/new-mern-key.pem.pub")

}

resource "aws_instance" "backend" {
  ami                    = "ami-0989fb15ce71ba39e"
  instance_type          = "t3.micro"
  key_name               = "new-mern-key"
  vpc_security_group_ids = [aws_security_group.backend_sg.id]
  user_data              = file("${path.module}/userdata.sh")

  tags = {
    Name = "mern-backend"
  }
}



provider "aws" {
  region = var.region
}

resource "aws_key_pair" "mykeypair_test" {
  key_name   = var.key_name
  public_key = file(var.public_key_path)
}

resource "aws_security_group" "group3_security_group" {
  name        = var.security_group_name

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "group3_final_assignment" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = aws_key_pair.mykeypair_test.key_name
  tags = {
    Name = "group3_final_assignment_test"
  }
  vpc_security_group_ids = [aws_security_group.group3_security_group.id]

   provisioner "local-exec" {
     command = "sleep 60 && ansible-playbook -i '${aws_instance.group3_final_assignment.public_ip},' ansible/playbook.yml --user ${var.aws_instance_user_id} --private-key ${var.private_key_path}"
  }
}
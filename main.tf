
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
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "group3_final_assignment" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = aws_key_pair.mykeypair_test.key_name
  tags = {
    Name = "group3_final_assignment"
  }
  vpc_security_group_ids = [aws_security_group.group3_security_group.id]

  # provisioner "local-exec" {
  # command = "sleep 90 && ansible-playbook -i ${var.inventory_filename} create_folder.yml"
  #}
}
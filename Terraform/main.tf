provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "medusa_instance" {
  ami           = "ami-0e86e20dae9224db8"  # Choose an appropriate AMI ID based on your region
  instance_type = "t2.small"
  key_name      = "task117"

  tags = {
    Name = "Medusa-task"
  }
}

resource "aws_security_group" "new_security_group" {
  name        = "medusa_security_117"
  description = "Allow HTTP, HTTPS, SSH, and Medusa traffic"
  vpc_id      = "vpc-02aca3c29abc1cd43"  # Replace with your VPC ID
}

resource "aws_security_group_rule" "allow_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.new_security_group.id
}

resource "aws_security_group_rule" "allow_https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.new_security_group.id
}

resource "aws_security_group_rule" "allow_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]  # Replace with your public IP
  security_group_id = aws_security_group.new_security_group.id
}

resource "aws_security_group_rule" "allow_medusa" {
  type              = "ingress"
  from_port         = 9000
  to_port           = 9000
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.new_security_group.id
}

resource "aws_security_group_rule" "allow_all_outbound" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"  # Allows all protocols
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.new_security_group.id
}

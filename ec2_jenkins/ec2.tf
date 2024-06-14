resource "aws_instance" "kubectl-server" {
  ami                         = var.image_ami
  key_name                    = var.key_name
  instance_type               = "t2.small"
  associate_public_ip_address = true
  subnet_id                   = local.public_subnets1_id
  vpc_security_group_ids      = [aws_security_group.allow_tls_ssh.id]

  tags = {
    Name = "jenkins_server_relq"
  }

}

resource "aws_security_group" "allow_tls_ssh" {
  name        = "jenkins-relq-sg"
  description = "Allow SSH and HTTPS traffic"
  vpc_id      = local.project_vpc_id

  ingress {
    description      = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Best practis is to define a specific address or range
  }

  ingress {
    description      = "Allow Jenkins (default port 8080)"
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # Allow all outbound traffic
    cidr_blocks = ["0.0.0.0/0"] #Best practis is to define a specific address or range
  }
  
}
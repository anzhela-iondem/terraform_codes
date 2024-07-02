resource "aws_instance" "kubectl-server" {
  ami                         = var.image_ami
  key_name                    = var.key_name
  instance_type               = "t2.small"  # You may need bigger storage
  associate_public_ip_address = false
  subnet_id                   = local.private_subnets1_id  # Need a VPN server to access Jenkins.
  vpc_security_group_ids      = [aws_security_group.allow_tls_ssh.id]

  root_block_device {
    volume_size = 16
  }

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
    cidr_blocks = ["10.0.1.0/24"]  # Provide VPN server's local IP
  }

  ingress {
    description      = "Allow Jenkins (default port 8080)"
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["10.0.1.0/24"]  # Provide VPN server's local IP
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  
    cidr_blocks = ["0.0.0.0/0"] # Allow all outbound traffic
  }
  
}
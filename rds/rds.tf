resource "aws_db_instance" "mysql" {
  identifier                  = var.db_name
  engine                      = var.db_engine
  engine_version              = var.engine_version
  instance_class              = var.instance_class
  allocated_storage           = var.allocated_storage
  storage_type                = var.storage_type
  db_name                     = var.db_name
  username                    = var.db_username
  password                    = var.db_password
  db_subnet_group_name        = aws_db_subnet_group.db_subnet_group.name
  vpc_security_group_ids      = [aws_security_group.db_sg.id]
  skip_final_snapshot         = true
#  manage_master_user_password = false
  storage_encrypted           = false
}

# Create security group for our db mysql
resource "aws_security_group" "db_sg" {
  description = "enable mysql access on port 3306"
  vpc_id      = local.project_vpc_id
  ingress {
    description = "mysql access"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    #    security_groups = [aws_security_group.private_sg.id]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "my-db-subnet-group"
  subnet_ids = [local.database_subnets1_id, local.database_subnets2_id]

  tags = {
    Name = "My DB Subnet Group"
  }
}
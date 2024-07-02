output "region" {
    description = "Region"
    value = var.region
    }

output "vpc_id" {
    description = "Main VPC ID of the Project"
    value = aws_vpc.main_vpc.id
}

output "public_subnet_1_id" {
    description = "Public Subnet 1 ID"
    value = aws_subnet.public_subnets[0].id
}

output "public_subnet_2_id" {
    description = "Public Subnet 2 ID"
    value = aws_subnet.public_subnets[1].id
}

output "private_subnet_1_id" {
    description = "Privat Subnet 1 ID"
    value = aws_subnet.private_subnets[0].id
}

output "private_subnet_2_id" {
    description = "Privat Subnet 1 ID"
    value = aws_subnet.private_subnets[1].id
}

output "database_subnet_1_id" {
    description = "Database Subnet 1 ID"
    value = aws_subnet.database_subnets[0].id
}

output "database_subnet_2_id" {
    description = "Database Subnet 1 ID"
    value = aws_subnet.database_subnets[1].id
}

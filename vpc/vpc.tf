# Get current availability zones
data "aws_availability_zones" "current" {}

# Create the VPC
resource "aws_vpc" "main_vpc" {
    cidr_block = var.vpc_cidr
    tags       = merge(var.tags, {Name = "${var.project_name}-VPC"})
}

# Define the Internet Gateway
resource "aws_internet_gateway" "main_gateway" {
    vpc_id = aws_vpc.main_vpc.id
    tags   = merge(var.tags, {Name = "${var.project_name}-IGW"})
}

# Create a public subnet within the VPC
resource "aws_subnet" "public_subnets" {
    count                   = length(var.public_subnet_cidrs)
    vpc_id                  = aws_vpc.main_vpc.id
    cidr_block              = element(var.public_subnet_cidrs, count.index)
    map_public_ip_on_launch = true
    availability_zone = data.aws_availability_zones.current.names[count.index]
    tags                    = merge(var.tags, {Name = "${var.project_name}-public-subnets${count.index + 1}"})
}

# Define the public Route Table with the Route
resource "aws_route_table" "public_subnet_rt" {
    vpc_id = aws_vpc.main_vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.main_gateway.id
    }
    tags = merge(var.tags, {Name = "${var.project_name}-route-table-public"})
    
}

# Associating public subnets to the Route Table
resource "aws_route_table_association" "public_subnets" {
    count          = length(aws_subnet.public_subnets[*].id)
    route_table_id = aws_route_table.public_subnet_rt.id
    subnet_id      = aws_subnet.public_subnets[count.index].id
}

# Create a private subnet within the VPC
resource "aws_subnet" "private_subnets" {
    vpc_id            = aws_vpc.main_vpc.id
    count             = length(var.private_subnet_cidrs)
    cidr_block        = element(var.private_subnet_cidrs, count.index)
    availability_zone = data.aws_availability_zones.current.names[count.index]
    tags              = merge(var.tags, {Name = "${var.project_name}-private-subnets-${count.index + 1}"})
}

# Define the private Route Table with the Route
resource "aws_route_table" "private_subnets_rt" {
    count              = length((var.private_subnet_cidrs))
    vpc_id             = aws_vpc.main_vpc.id
    route {
        cidr_block     = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.nat_gtw[count.index].id
    }  
    tags               = merge(var.tags, {Name = "${var.project_name}-route-table-private"})
}

# Associating private subnets to the Route Table
resource "aws_route_table_association" "private_routes" {
    count          = length(aws_subnet.private_subnets)
    route_table_id = aws_route_table.private_subnets_rt[count.index].id
    subnet_id      = aws_subnet.private_subnets[count.index].id
}

# Create a database subnet within the VPC
resource "aws_subnet" "database_subnets" {
    vpc_id            = aws_vpc.main_vpc.id
    count             = length(var.database_subnet_cidrs)
    cidr_block        = element(var.database_subnet_cidrs, count.index)
    availability_zone = data.aws_availability_zones.current.names[count.index]
    tags              = merge(var.tags, {Name = "${var.project_name}-database-subnet-${count.index + 1}"})
}

# Create Route Table for DB Subnet
resource "aws_route_table" "database_subnets_rt" {
    count              = length((var.database_subnet_cidrs))
    vpc_id             = aws_vpc.main_vpc.id
    tags               = merge(var.tags, {Name = "${var.project_name}-route-table-database"})
}

# Create Elastic IP for the NAT gateway
resource "aws_eip" "nat_eip" {
    count = length(var.private_subnet_cidrs)
    tags  = merge(var.tags, {Name = "${var.project_name}-nat-gtw-${count.index + 1}"})
}

# Create NAT gateway for the private subnets
resource "aws_nat_gateway" "nat_gtw" {
    count         = length(var.private_subnet_cidrs)
    allocation_id = aws_eip.nat_eip[count.index].id
    subnet_id     = aws_subnet.public_subnets[count.index].id
    tags          = merge(var.tags, {Name = "${var.project_name}-nat-gtw-${count.index + 1}"})
}

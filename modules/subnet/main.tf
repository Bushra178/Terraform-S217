resource "aws_subnet" "public_subnet_us_east_1a" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.subnet_cidr_block_1
  availability_zone       = var.az_1a
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.env_prefix}-public-subnet-us-east-1a"
  }
}

resource "aws_subnet" "private_subnet_us_east_1a" {
  vpc_id            = var.vpc_id
  cidr_block        = var.subnet_cidr_block_2
  availability_zone = var.az_1a

  tags = {
    Name = "${var.env_prefix}-private_subnet_us_east_1a"
  }
}

resource "aws_subnet" "public_subnet_us_east_1b" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.subnet_cidr_block_3
  availability_zone       = var.az_1b
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.env_prefix}-public_subnet_us_east_1b"
  }
}

resource "aws_subnet" "private_subnet_us_east_1b" {
  vpc_id            = var.vpc_id
  cidr_block        = var.subnet_cidr_block_4
  availability_zone = var.az_1b

  tags = {
    Name = "${var.env_prefix}-private_subnet_us_east_1b"
  }
}

resource "aws_internet_gateway" "app_igw" {
  vpc_id = var.vpc_id

  tags = {
    Name = "${var.env_prefix}-igw"
  }
}

# Allocate Elastic IPs for NAT Gateways
resource "aws_eip" "nat_eip_us_east_1a" {
  domain = "vpc"

  tags = {
    Name = "${var.env_prefix}-eip-us-east-1a"
  }
}

resource "aws_eip" "nat_eip_us_east_1b" {
  domain = "vpc"

  tags = {
    Name = "${var.env_prefix}-eip-us-east-1b"
  }
}

# Create NAT Gateway in us-east-1a
resource "aws_nat_gateway" "app_nat_gateway_us_east_1a" {
  allocation_id = aws_eip.nat_eip_us_east_1a.id
  subnet_id     = aws_subnet.public_subnet_us_east_1a.id

  tags = {
    Name = "${var.env_prefix}-nat-gateway-1a"
  }
}

# Create NAT Gateway in us-east-1b
resource "aws_nat_gateway" "app_nat_gateway_us_east_1b" {
  allocation_id = aws_eip.nat_eip_us_east_1b.id
  subnet_id     = aws_subnet.public_subnet_us_east_1b.id

  tags = {
    Name = "${var.env_prefix}-nat-gateway-1b"
  }
}


# Create a route table for public subnets
resource "aws_route_table" "public_route_table" {
  vpc_id = var.vpc_id

  route {
    cidr_block = var.default_route
    gateway_id = aws_internet_gateway.app_igw.id
  }

  tags = {
    Name = "${var.env_prefix}-public-route-table"
  }
}

# Associate route table with public subnets
resource "aws_route_table_association" "public_subnet_association_us_east_1a" {
  subnet_id      = aws_subnet.public_subnet_us_east_1a.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public_subnet_association_us_east_1b" {
  subnet_id      = aws_subnet.public_subnet_us_east_1b.id
  route_table_id = aws_route_table.public_route_table.id
}

# Create a custom route table for private subnets
resource "aws_route_table" "private_route_table_us_east_1a" {
  vpc_id = var.vpc_id

  route {
    cidr_block     = var.default_route
    nat_gateway_id = aws_nat_gateway.app_nat_gateway_us_east_1a.id  
  }

  tags = {
    Name = "${var.env_prefix}-private-route-table-1a"
  }
}

resource "aws_route_table" "private_route_table_us_east_1b" {
  vpc_id = var.vpc_id

  route {
    cidr_block     = var.default_route
    nat_gateway_id = aws_nat_gateway.app_nat_gateway_us_east_1b.id  
  }

  tags = {
    Name = "${var.env_prefix}-private-route-table-1b"
  }
}

# Associate private route table with private subnets
resource "aws_route_table_association" "private_subnet_association_us_east_1a" {
  subnet_id      = aws_subnet.private_subnet_us_east_1a.id
  route_table_id = aws_route_table.private_route_table_us_east_1a.id
}

resource "aws_route_table_association" "private_subnet_association_us_east_1b" {
  subnet_id      = aws_subnet.private_subnet_us_east_1b.id
  route_table_id = aws_route_table.private_route_table_us_east_1b.id
}
# CREATE THE VPC
resource "aws_vpc" "this_vpc" {
  cidr_block           = var.vpc_cidr_block
  instance_tenancy     = var.instance_tenancy
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_support
  tags = merge({
    Name        = var.vpc_name,
    Project     = var.project,
    Environment = var.environment
  }, var.tags)
}


# CREATE SUBNET 2 PUBLIC AND 2 PRIVATE
resource "aws_subnet" "this_public_subnet" {
  vpc_id            = aws_vpc.this_vpc.id
  cidr_block        = element(var.public_subnet_cidr, count.index)
  availability_zone = element(var.availability_zone, count.index)
  count             = 2
  tags = merge({
    Name        = "Public-subnet-${count.index}",
    Project     = var.project,
    Environment = var.environment
  }, var.tags)
}
resource "aws_subnet" "this_private_subnet" {
  vpc_id            = aws_vpc.this_vpc.id
  cidr_block        = element(var.private_subnet_cidr, count.index)
  availability_zone = element(var.availability_zone, count.index)
  count             = 2
  tags = merge({
    Name        = "Private-subnet-${count.index}",
    Project     = var.project,
    Environment = var.environment
  }, var.tags)
}

# CREATE THE INTERNET GATEWAY
resource "aws_internet_gateway" "this_igw" {
  vpc_id = aws_vpc.this_vpc.id
  tags = merge({
    Name        = "InternetGW",
    Project     = var.project,
    Environment = var.environment
  }, var.tags)
}


#CREATING PUBLIC ROUTE TABLE & ROUTE
resource "aws_route_table" "this_public_rt" {
  vpc_id = aws_vpc.this_vpc.id
  tags = merge({
    Name        = "Public-RT",
    Project     = var.project,
    Environment = var.environment
  }, var.tags)
}
resource "aws_route" "this_public" {
  route_table_id         = aws_route_table.this_public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this_igw.id
}

#CREATING PUBLIC ROUTE TABLE ASSOCIATION
resource "aws_route_table_association" "this_pub_rt_asso" {
  count          = length(var.public_subnet_cidr)
  subnet_id      = aws_subnet.this_public_subnet[count.index].id
  route_table_id = aws_route_table.this_public_rt.id
}


# CREATE AN ELASTIC IP FOR THE NAT GATEWAY
resource "aws_eip" "this_eip" {
  vpc = true
}

# CREATE THE NAT GATEWAY
resource "aws_nat_gateway" "this_nat_gw" {
  allocation_id = aws_eip.this_eip.id
  subnet_id     = aws_subnet.this_public_subnet[0].id
  depends_on    = [aws_internet_gateway.this_igw]
}


#CREATING PRIVATE ROUTE TABLE & ROUTE
resource "aws_route_table" "this_private_rt" {
  vpc_id = aws_vpc.this_vpc.id
  tags = merge(
    {
      Name        = "Private-RT",
      Project     = var.project,
      Environment = var.environment
    },
    var.tags
  )
}
resource "aws_route" "this_private" {
  route_table_id         = aws_route_table.this_private_rt.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.this_nat_gw.id
}


#CREATING PRIVATE ROUTE TABLE ASSOCIATION
resource "aws_route_table_association" "this_pri_rt_asso" {
  count          = length(var.private_subnet_cidr)
  subnet_id      = aws_subnet.this_private_subnet[count.index].id
  route_table_id = aws_route_table.this_private_rt.id
}

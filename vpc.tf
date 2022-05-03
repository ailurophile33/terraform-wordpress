########### VPC ##############

data "aws_availability_zones" "avz" {
  state = "available"
}

resource "aws_vpc" "wordpress_vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = var.vpc_name
  }
}

######## SUBNETS ############

resource "aws_subnet" "subnet" {
  vpc_id     = aws_vpc.wordpress_vpc.id            
  count = length(var.subnets_cidr)
  cidr_block = var.subnets_cidr[count.index]
  tags = {
      Name = "subnet-${count.index+1}-${aws_vpc.wordpress_vpc.id}"    
  }                              
}

########## IGW ##############

resource "aws_internet_gateway" "wordpress_igw" {
  vpc_id = aws_vpc.wordpress_vpc.id

  tags = {
    Name = "wordpress_igw"
  }
}

########## NAT & EIP ###########

resource "aws_eip" "nat" {
  vpc = true

  tags = {
    Name = "nat"
  }
}

resource "aws_nat_gateway" "wordpress_nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.subnet[0].id

  tags = {
    Name = "wordpress_nat"
  }

  depends_on = [aws_internet_gateway.wordpress_igw]
}

######## ROUTES #############

resource "aws_route_table" "wordpress_rt" {
  vpc_id = aws_vpc.wordpress_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.wordpress_igw.id
  }

  tags = {
    Name = "wordpress_rt"
  }
}

resource "aws_route_table_association" "public-1" {
  subnet_id      = aws_subnet.subnet[0].id
  route_table_id = aws_route_table.wordpress_rt.id
}

resource "aws_route_table_association" "public-2" {
  subnet_id      = aws_subnet.subnet[1].id
  route_table_id = aws_route_table.wordpress_rt.id
}

resource "aws_route_table_association" "public-3" {
  subnet_id      = aws_subnet.subnet[2].id
  route_table_id = aws_route_table.wordpress_rt.id
}

resource "aws_route_table" "wordpress_rt_private" {
  vpc_id = aws_vpc.wordpress_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.wordpress_nat.id
  }

  tags = {
    Name = "wordpress_rt_private"
  }
}

resource "aws_route_table_association" "private-3" {
  subnet_id      = aws_subnet.subnet[3].id
  route_table_id = aws_route_table.wordpress_rt_private.id
}

resource "aws_route_table_association" "private-4" {
  subnet_id      = aws_subnet.subnet[4].id
  route_table_id = aws_route_table.wordpress_rt_private.id
}

resource "aws_route_table_association" "private-5" {
  subnet_id      = aws_subnet.subnet[5].id
  route_table_id = aws_route_table.wordpress_rt_private.id
}
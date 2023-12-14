## MAIN VPC ##

resource "aws_vpc" "main_vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "main-vpc"
  }
}

resource "aws_subnet" "subnet_private1" {
  vpc_id     = aws_vpc.main_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-2a"
  tags = {
    Name = "subnet-private1"
  }
}

resource "aws_subnet" "subnet_public1" {
  vpc_id     = aws_vpc.main_vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-2a"
  tags = {
    Name = "subnet-public1"
  }
}

resource "aws_subnet" "subnet_private2" {
  vpc_id     = aws_vpc.main_vpc.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "us-east-2b"
  tags = {
    Name = "subnet-private2"
  }
}

resource "aws_subnet" "subnet_public2" {
  vpc_id     = aws_vpc.main_vpc.id
  cidr_block = "10.0.4.0/24"
  availability_zone = "us-east-2b"
  tags = {
    Name = "subnet-public2"
  }
}


resource "aws_eip" "eip" {
  domain   = "vpc"
}

resource "aws_internet_gateway" "internet_gw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "main"
  }
}


resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.subnet_public1.id

  tags = {
    Name = "gw NAT"
  }

  depends_on = [aws_internet_gateway.internet_gw]
}


## PRIVATE TABLE ##

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }

  tags = {
    Name = "private-route-table"
  }
}

# resource "aws_route" "local_route_private" {
#   route_table_id = aws_route_table.private_route_table.id
#   destination_cidr_block = "10.0.0.0/16"
#   local_gateway_id = "local"
# }

resource "aws_route_table_association" "pr1" {
  subnet_id      = aws_subnet.subnet_private1.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "pr2" {
  subnet_id      = aws_subnet.subnet_private2.id
  route_table_id = aws_route_table.private_route_table.id
}


## PUBLIC TABLE ##

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gw.id
  }

  tags = {
    Name = "public-route-table"
  }
}


# resource "aws_route" "local_route_public" {
#   route_table_id = aws_route_table.public_route_table.id
#   destination_cidr_block = "10.0.0.0/16"
#   local_gateway_id = "local"
# }

resource "aws_route_table_association" "pu1" {
  subnet_id      = aws_subnet.subnet_public1.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "pu2" {
  subnet_id      = aws_subnet.subnet_public2.id
  route_table_id = aws_route_table.public_route_table.id
}

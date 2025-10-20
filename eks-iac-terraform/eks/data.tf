# provided static tag name directly to fetch the VPC details 

data "aws_vpc" "landing_zone_vpc" {
  tags = {
    Name = "${local.cluster_name}"
  }
}

data "aws_internet_gateway" "landing_internet_gateway" {
  tags = {
    Name = "${local.cluster_name}"
  }
}

data "aws_availability_zones" "available" {
}

data "aws_subnet" "subnet_public_1" {
  tags = {
    Name = "public-subnet-1"
  }
}

data "aws_subnet" "subnet_public_2" {
  tags = {
    Name = "public-subnet-2"
  }
}

data "aws_subnet" "subnet_private_1" {
  tags = {
    Name = "private-subnet-1"
  }
}

data "aws_subnet" "subnet_private_2" {
  tags = {
    Name = "private-subnet-2"
  }
}

data "aws_route_table" "route_private_1" {
  tags = {
    Name = "private subnet 1"
  }
}

data "aws_route_table" "route_public_1" {
  tags = {
    Name = "public subnet 1"
  }
}


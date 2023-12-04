//vpc é o virtual private cloud
resource "aws_vpc" "my_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
}

resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id
}

resource "aws_route_table" "my_route_table" {
  count  = length(var.subnet_cidr_blocks)
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }
}
// Adicione a nova subnet aos recursos existentes
resource "aws_subnet" "my_subnet" {
  count                   = length(var.subnet_cidr_blocks)
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.subnet_cidr_blocks[count.index]
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = true

  tags = {
    Name = "MySubnet-${count.index + 1}"
  }
}

// Atualize o recurso aws_db_subnet_group para incluir a nova subnet
resource "aws_db_subnet_group" "my_db_subnet_group" {
  name       = "my-db-subnet-group"
  subnet_ids = aws_subnet.my_subnet[*].id
}

// Atualize o recurso aws_route_table_association para incluir a nova subnet
resource "aws_route_table_association" "my_subnet_association" {
  count          = length(var.subnet_cidr_blocks)
  subnet_id      = aws_subnet.my_subnet[count.index].id
  route_table_id = aws_route_table.my_route_table[count.index].id
}

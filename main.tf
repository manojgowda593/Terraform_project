resource "aws_vpc" "my_vpc" {
    cidr_block = "192.168.10.0/24"
    tags = {
      name = "My_Vpc"
    }
}

resource "aws_subnet" "subnet_pub" {
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = "192.168.10.0/25"
    availability_zone = "ap-south-1a"
    map_public_ip_on_launch = true

    tags = {
      name = "Public_subnet"
    }
}

resource "aws_internet_gateway" "My_IGW" {
    vpc_id = aws_vpc.my_vpc.id
    tags = {
      name = "My_IGW"
    } 
}

resource "aws_route_table" "My_Route_Table" {
    vpc_id = aws_vpc.my_vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.My_IGW.id
    }
    tags = {
      name = "Public_Route"
    }
}

resource "aws_route_table_association" "My_route_association_Pub" {
    subnet_id = aws_subnet.subnet_pub.id
    route_table_id = aws_route_table.My_Route_Table.id
}

resource "aws_instance" "My_EC2_Instance" {
  ami = var.ami_value
  instance_type = var.instance_type_value
  key_name = var.key_name_value
  subnet_id = aws_subnet.subnet_pub.id

  tags = {
    name = "Manoj_EC2_instance"
  }
}
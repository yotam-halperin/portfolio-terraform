
// VPC 
resource "aws_vpc" "yh-tf" {
    cidr_block = var.vpc_cidr

    tags = {
        Name = "${var.vpc_name}"
    }
}


// Subnets
resource "aws_subnet" "my_subnets" {
  count             = var.num_of_subnets
  vpc_id            = aws_vpc.yh-tf.id
  cidr_block        = "${element(var.subnet_cidr, count.index)}"
  availability_zone = "${element(var.subnet_azs, count.index)}"
  map_public_ip_on_launch = true
  
  tags = {
    Name = "${var.vpc_name}-sub${count.index+1}"
  }
}


// IGW
resource "aws_internet_gateway" "yh-tf-igw" {
    vpc_id = aws_vpc.yh-tf.id

    tags = {
        Name = "${var.vpc_name}-igw"
        owner = "yotam_halperin"
        bootcamp = "17"
        expiration_date = "23-02-23"
    }
}


// Routing Table
resource "aws_route_table" "yh-tf-pub1" {
    vpc_id = aws_vpc.yh-tf.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.yh-tf-igw.id
    }
}


// RT associations
resource "aws_main_route_table_association" "main" {
  vpc_id = aws_vpc.yh-tf.id
  route_table_id = aws_route_table.yh-tf-pub1.id
}
#########################################################
# Creating KeyPair
#########################################################


resource "aws_key_pair" "keypair" {
  key_name   = "devops-key"
  public_key = "public_key"
  tags = {
    Name = "devops-key"
  }
}

#########################################################
# Creating Security Group web access
#########################################################

resource "aws_security_group" "webserver" {
    
  name        = "devops-webserver"
  description = "allows 22,80,443"
  vpc_id      = aws_vpc.vpc.id  
  ingress {
   
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
 
  ingress {
   
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
    
  ingress {
   
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
    
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "devops-webserver"
  }
}


# ===============================================================================
# Gathering All Subent Name
# ===============================================================================

data "aws_availability_zones" "AZ" {
  state = "available"
}


# ===============================================================================
# vpc creation
# ===============================================================================
resource "aws_vpc" "vpc" {
    
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "${var.project}-vpc"
  }
    
}


# ===============================================================================
# InterGate Way For Vpc
# ===============================================================================
resource "aws_internet_gateway" "igw" {
    
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.project}-igw"
  }
}

# ===============================================================================
# subent public1
# ===============================================================================

resource "aws_subnet" "public1" {
    
  vpc_id                   = aws_vpc.vpc.id
  cidr_block               = cidrsubnet(var.vpc_cidr, 2, 0)
  availability_zone        = element(data.aws_availability_zones.AZ.names,0)
  map_public_ip_on_launch  = true
  tags = {
    Name = "${var.project}-public1"
  }
}

# ===============================================================================
# subent public2
# ===============================================================================

resource "aws_subnet" "public2" {
    
  vpc_id                   = aws_vpc.vpc.id
  cidr_block               = cidrsubnet(var.vpc_cidr, 2, 1)
  availability_zone        = element(data.aws_availability_zones.AZ.names,1)
  map_public_ip_on_launch  = true
  tags = {
    Name = "${var.project}-public2"
  }
}


# ===============================================================================
# subent public3
# ===============================================================================

resource "aws_subnet" "public3" {
    
  vpc_id                   = aws_vpc.vpc.id
  cidr_block               = cidrsubnet(var.vpc_cidr, 2, 2)
  availability_zone        = element(data.aws_availability_zones.AZ.names,2)
  map_public_ip_on_launch  = true
  tags = {
    Name = "${var.project}-public-3"
  }
}




# ===============================================================================
#  Route Table
# ===============================================================================

resource "aws_route_table" "public" {
    
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.project}-public"
  }
}



# ===============================================================================
# Public Route Table Association
# ===============================================================================

resource "aws_route_table_association" "public1" {        
  subnet_id      = aws_subnet.public1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public2" {      
  subnet_id      = aws_subnet.public2.id
  route_table_id = aws_route_table.public.id
}


resource "aws_route_table_association" "public3" {       
  subnet_id      = aws_subnet.public3.id
  route_table_id = aws_route_table.public.id
}






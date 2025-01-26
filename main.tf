
provider "aws" {
    region = "eu-west-2"
}
    resource  "aws_instance" "web_ubuntu" {
    ami =  "ami-091f18e98bc129c4e"
    instance_type =  "t2.micro"
    key_name = "simbababy"
    tags = {
        Name = "WEB-UBUNTU"
    }
}

resource  "aws_instance" "web_amazon" {
    ami = "ami-04ba8620fc44e2264"
    instance_type = "t2.micro"
    key_name = "simbababy"
    tags = {
        Name = "WEB-AMAZON"
    }
}

resource  "aws_instance" "app_ubuntu" {
    ami = "ami-091f18e98bc129c4e"
    instance_type =  "t2.micro"
    key_name = "simbababy"
    tags = {
        Name = "APP-UBUNTU"
    }
}

resource  "aws_instance" "app_amazon" {
    ami = "ami-04ba8620fc44e2264"
    instance_type = "t2.micro"
    key_name = "simbababy"
    tags = {
        Name = "APP-AMAZON"
    }
}


resource  "aws_instance" "ansible" {
    ami = "ami-04ba8620fc44e2264"
    instance_type = "t2.micro"
    key_name = "simbababy"
    vpc_security_group_ids = [aws_security_group.nginx_ingress.id]
    tags = {
        Name = "ANSIBLE"
    }
}


  


resource "aws_security_group" "nginx_ingress" {
  name        = "nginx-ingress-sg"
  

  # Allow HTTP (port 80) traffic
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow from all IPv4 addresses
  }

  

  # Allow traffic from all IPv6 addresses (optional)
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
 
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
   
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # Allow all protocols
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "nginx-ingress-sg"
  }
}




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
    tags = {
        Name = "ANSIBLE"
    }
}

output "ANSIBLE" {
    value = aws_instance.ansible.public_ip
    }

    output "WEB-AMAZON" {
    value = aws_instance.web_amazon.private_ip
    }

     output "WEB-UBUNTU" {
    value = aws_instance.web_ubuntu.private_ip
    }

       output "APP-UBUNTU" {
    value = aws_instance.app_ubuntu.private_ip
    }

 output "APP-AMAZON" {
    value = aws_instance.app_amazon.private_ip 
    }
  
  


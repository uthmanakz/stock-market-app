resource  "aws_resource" "web_ubuntu" {
    ami = "ami-04ba8620fc44e2264"
    instance_type =  "t2.micro"
    key_name = "simbababy"
    tags = {
        Name = "WEB-UBUNTU"
    }
}

resource  "aws_resource" "web_amazon" {
    ami = "ami-091f18e98bc129c4e"
    instance_type = "t2.micro"
    key_name = "simbababy"
    tags = {
        Name = "WEB-AMAZON"
    }
}

resource  "aws_resource" "app_ubuntu" {
    ami = "ami-04ba8620fc44e2264"
    instance_type =  "t2.micro"
    key_name = "simbababy"
    tags = {
        Name = "APP-UBUNTU"
    }
}

resource  "aws_resource" "app_amazon" {
    ami = "ami-091f18e98bc129c4e"
    instance_type = "t2.micro"
    key_name = "simbababy"
    tags = {
        Name = "APP-AMAZON"
    }
}


resource  "aws_resource" "ansible" {
    ami = "ami-091f18e98bc129c4e"
    instance_type = "t2.micro"
    key_name = "simbababy"
    tags = {
        Name = "ANSIBLE"
    }
}


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
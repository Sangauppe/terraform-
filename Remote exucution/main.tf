provider "aws" {
	region = "ap-south-1"
}

resource "aws_security_group" "my-sg" {
  vpc_id      = "vpc-0ea930f4e90d639f2"

  ingress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
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
    Name = "My-Sg"
  }
}

resource "aws_instance" "my-instance" {
	ami = "ami-05c8ca4485f8b138a"
	instance_type = "t2.micro"
	key_name = "Mun"
	vpc_security_group_ids = [aws_security_group.my-sg.id]
	tags = {
    Name = "Terraform-Instance"
    } 

	connection {
		type = "ssh"
		user = "ec2-user"
		private_key = file("./Mun.pem")
		host = aws_instance.my-instance.public_ip
	}
	
	provisioner "file" {
		source = "./script.sh"
		destination = "/home/ec2-user/script.sh"
	}
	
	provisioner "remote-exec" {
		inline = [
			"chmod u+x /home/ec2-user/script.sh",
			"sh /home/ec2-user/script.sh"
		]
	}

}

output "public-ip" {
	value = aws_instance.my-instance.public_ip
}
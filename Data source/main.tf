provider "aws" {
	region = "ap-south-1"
}

data "aws_instance" "my-ec2" {
	instance_tags = {
		Name = "Mumbai2"
	}
}

output "instance-id" {
	value = data.aws_instance.my-ec2.id
}

output "public-ip" {
	value = data.aws_instance.my-ec2.public_ip
}
provider "aws" {
	region = "ap-southeast-1"
}
resource "aws_instance" "test" {
	tags = {
			Name = "terraform-ec2"
	}
	ami = "ami-051f0947e420652a9"
	instance_type = "t2.micro"
	key_name = "s1"
}

provider "aws" {
	alias = "ohio"
	region = "us-east-2"
}

resource "aws_instance" "my-instance" {
	ami = "ami-092b43193629811af"
	instance_type = "t2.micro"
	provider = aws.ohio
	
}


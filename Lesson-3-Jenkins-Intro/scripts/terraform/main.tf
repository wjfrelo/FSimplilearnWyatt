terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 3.22.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  shared_credentials_file = "~/.aws/credentials"
  profile = "student"
}


# Nice easy way to set custom variable that has your ip_address
data http ip_address {
  url             = var.get_address_url
  request_headers = var.get_address_request_headers
}

# Get Amazon Machine Image id for ubuntu AMI. Used to run EC2 Instances
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

# Get default VPC. Easy to do because there is only one Virtual Private Cloud for your account
resource aws_default_vpc "get-vpc" {
}

# Set security group to allow our machine access to the EC2 Instance
resource "aws_security_group" "set-sg" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_default_vpc.get-vpc.id

  ingress {
    description = "Allows access to Jenkins from student machine"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = [
      data.http.ip_address/32]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}


resource "aws_instance" "jenkins" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.small"
  key_name      = "wyatts-keypair"
  security_groups = aws_security_group.set-sg.id
  tags = {
    Name = "Jenkins Instance"
  }

  provisioner "remote-exec" {
    inline = [
      "wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -",
      "sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'",
      "sudo apt install jenkins",
      "systemctl status jenkins",
      "sudo /etc/init.d/jenkins start"
      "sudo update install maven "
    ]
  }
}


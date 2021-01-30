terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 3.22.0"
    }
  }
}

# Ensure IAM user is created, programmatic access provided (access ke and secret key) and AWS configuration completed (aws configure)
provider "aws" {
  profile = "student"
  shared_credentials_file = "~/.aws/credentials"
}

# Nice easy way to set custom variable that has your ip_address
data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}

resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = file("~/.ssh/id_rsa.pub")
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
    cidr_blocks = ["${chomp(data.http.myip.body)}/32"]
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
  ami = data.aws_ami.ubuntu.id
  instance_type = "t2.small"
  key_name = aws_key_pair.deployer.key_name
  security_groups = [
    aws_security_group.set-sg.name]
  tags = {
    Name = "Jenkins Instance"
  }

//  provisioner "remote-exec" {
//    connection {
//      type = "ssh"
//      user = "ubuntu"
//      host = self.public_dns
//      private_key = file("~/.ssh/id_rsa")
//    }
//    inline = [
//      "wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -",
//      "sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'",
//      "sudo apt install jenkins",
//      "systemctl status jenkins",
//      "sudo /etc/init.d/jenkins start",
//      "sudo update install maven"
//    ]
//  }
}



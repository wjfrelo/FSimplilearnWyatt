#!/usr/bin/env bash

# Goal: Configure the development environment for Lesson-3 demonstrations

[[ ! -z "$1" ]] && echo "Using $1 as email for generating ssh-key" || echo "Expecting email address for 1st argument. Stopping install and run script with email address (e.g., 'sh main.sh email@address" && break

function configure-exercise-environment {
  local email=$1
## Class Demo 3.1
  sudo apt-get update -y
  sudo apt-get install git-core openjdk-8-jdk maven -y

  ssh-keygen -t rsa -f  ~/.ssh/id_rsa -q -P ""
  # Add key to local agent
  eval "$(ssh-agent -s)"
  ssh-add ~/.ssh/id_rsa

## Class Demo 3.2
  wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
  sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
  sudo apt update -y
  sudo apt install jenkins -y
  sudo /etc/init.d/jenkins start
}

function print-key-information{
  echo 'hello'

}

function verify {
  echo 2
  echo "PUBLIC SSH-KEY: $(cat ~/.ssh/id_rsa.pub)"
  # Verify id_rsa key exists
  [[ ! -z "$1" ]] && echo "PRIVATE SSH-KEY: ~/.ssh/id_rsa" || echo "Expect private key is not available. Rerun script to recreate ssh-key" && break
  echo "JENKINS-SECRET-KEY: $(sudo cat /var/lib/jenkins/secrets/initialAdminPassword)"
  echo "MAVEN-HOME: /usr/share/maven"
  echo "JAVA-HOME: /usr/lib/jvm/java-8-openjdk-amd64"
 # Verify git
}

function  install_terraform {
  curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
  sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
  sudo apt-get update && sudo apt-get install terraform
}

function create-terraform-instance-structure {
  mkdir aws-terraform
  touch aws-terraform/main.tf
  touch aws-terraform/variables.tf
  touch aws-terraform/output.tf
  cd aws-terraform
}

#function install awscli {
#  curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
#  unzip awscliv2.zip
#  sudo ./aws/install
#}

https://www.surveymonkey.com/r/YKY5HMX?session_id=1709478983&type=PGP&trainer=wyatt%20frelot&course=&mega_category=&id=&mega_id=
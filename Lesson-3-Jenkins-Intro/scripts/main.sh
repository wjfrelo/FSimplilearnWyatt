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

configure-exercise-environment "$1"

verify

# Cron 0 11,22 * * *

#!/usr/bin/env bash

# Goal: Configure the development environment for Lesson-3 demonstrations

[[ ! -z "$1" ]] && echo "Using $1 as email for generating ssh-key" || echo "Expecting email address for 1st argument. Stopping install and run script with email address (e.g., 'sh main.sh email@address" && break

function configure-exercise-environment {

  local email=$1
  # Class Demo 3.1
  sudo apt-get update -y
  sudo apt-get install git-core -y
  ssh-keygen -t rsa -f  ~/.ssh/id_rsa -q -P ""
  # Add key to local agent
  eval "$(ssh-agent -s)"
  ssh-add ~/.ssh/id_rsa
}



function print-key-information{
  echo 'hello'

}

function verify {

  echo "PUBLIC SSH-KEY: $(cat ~/.ssh/id_rsa.pub)"
  # Verify id_rsa key exists
  [[ ! -z "$1" ]] && echo "PRIVATE SSH-KEY: ~/.ssh/id_rsa" || echo "Expect private key is not available. Rerun script to recreate ssh-key" && break
 # Verify git
}

#!/bin/bash
sudo apt update
sudo apt-get install python3 python3-pip

echo "Waiting for 30 seconds before installing the jenkins package..."
sleep 30
sudo apt install openjdk-11-jre -y
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo 'deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/' | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update && sudo apt-get install jenkins -y
sudo service jenkins restart

echo "Waiting for 30 seconds before installing the Terraform..."
sleep 30
wget https://releases.hashicorp.com/terraform/1.8.2/terraform_1.8.2_linux_386.zip
sudo apt-get install unzip
unzip 'terraform*.zip'
sudo mv terraform /usr/local/bin/

echo "Waiting for 30 seconds before installing the docker package..."
sleep 30
sudo apt-get install -y \
apt-transport-https \
ca-certificates \
curl \
gnupg-agent \
software-properties-common &&
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - &&
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" &&
sudo apt-get update -y &&
sudo sudo apt-get install docker-ce docker-ce-cli containerd.io -y &&
sudo usermod -aG docker adminuser
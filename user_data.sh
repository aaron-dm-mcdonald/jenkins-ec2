#!/bin/bash

# Update the system and install Docker
sudo dnf update -y
sudo dnf install docker -y

# Start and enable systemd daemon to start Docker on start boot/restart
sudo systemctl start docker
sudo systemctl enable docker

# Add ec2-user to the Docker group (so you dont have to use sudo)
sudo usermod -aG docker ec2-user


############



sudo docker pull aaronmcdonald/jenkins-class6:latest
sudo docker run --name jenkins -d -p 8080:8080 -p 50000:50000 --restart=always aaronmcdonald/jenkins-class6:latest

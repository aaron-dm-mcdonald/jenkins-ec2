#!/bin/bash

# Update the system and install Docker
sudo dnf update -y
sudo dnf install docker -y

# Start and enable systemd daemon to start Docker on boot/restart
sudo systemctl start docker
sudo systemctl enable docker

# Add ec2-user to the Docker group (so you don't have to use sudo)
sudo usermod -aG docker ec2-user

# Create the Jenkins backup directory (if it doesn't exist)
mkdir -p ./jenkins-backup

# Download the Jenkins volume tarball
curl -o ./jenkins-backup/jenkins_home_backup.tar.gz https://test-124655869758685.s3.us-east-1.amazonaws.com/jenkins_home_backup.tar.gz

# Restore Jenkins backup
sudo docker run --rm -v jenkins_home:/var/jenkins_home -v ./jenkins-backup:/backup alpine \
tar xzf /backup/jenkins_home_backup.tar.gz -C /var/jenkins_home

# Pull the latest Jenkins image
sudo docker pull aaronmcdonald/jenkins-class6:latest

# Run the Jenkins container with the restored volume
sudo docker run --name jenkins -d -p 8080:8080 -p 50000:50000 -v jenkins_home:/var/jenkins_home --restart=always aaronmcdonald/jenkins-class6:latest

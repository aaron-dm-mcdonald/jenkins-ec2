# Cloud Deployment of Containerized Jenkins Server

## Table of Contents
- [Overview](#overview)
- [Steps to Deploy](#steps-to-deploy)
  - [EC2 Creation](#ec2-creation)
  - [User Data Explained](#user-data-explained)

## Overview

This guide will walk you through the steps to deploy a containerized Jenkins server on AWS using EC2. The goal is to have Jenkins running on an EC2 instance, making it accessible via the web for continuous integration and delivery pipelines. The setup uses Amazon Linux 2023 as the operating system and provisions the EC2 instance with a user data script for automation.

## Steps to Deploy

Follow the instructions below to deploy Jenkins on an EC2 instance.

### 1) Sign in to AWS Console and Go to EC2 Dashboard
   - Log into your AWS account and navigate to the EC2 dashboard.

### 2) Create a Security Group
   - Create a new security group that allows inbound traffic on:
     - **SSH (Port 22)** for SSH access to the EC2 instance.
     - **Custom TCP (Port 8080)** for Jenkins access via the web interface.
   - Name the security group "Jenkins" (or something similar).

### 3) Provision EC2 Instance with Startup Script Provided
   - Launch a new EC2 instance with Amazon Linux 2023.
   - Assign the previously created security group to the instance.
   - Use the provided user data script to automate the installation and setup of Jenkins inside a Docker container.

### 4) Get Public DNS of EC2 Instance
   - After the EC2 instance has been successfully provisioned, find the **Public DNS** (IPv4) from the EC2 dashboard.
   - This URL will be used to access Jenkins via a web browser.

### 5) Sign Into Jenkins
   - Open a web browser and navigate to `http://<your-ec2-public-dns>:8080`.
   - Follow the Jenkins setup instructions, including unlocking Jenkins using the initial admin password generated during the instance setup.

## EC2 Creation in detail

### 1) Sign into AWS Console and Go to EC2 Dashboard
   - Log in to the [AWS Management Console](https://aws.amazon.com/console/), and select **EC2** from the services menu to access the EC2 dashboard.

### 2) Create a Security Group
   - Go to the **Security Groups** section under **Network & Security** and create a new security group with the following inbound rules:
     - **SSH (Port 22)**: Allow SSH connections for administrative access.
     - **Custom TCP (Port 8080)**: Allow access to Jenkins, which runs on port 8080 by default.
   - Name the security group "Jenkins" (or similar) and save it for use in the next step.

### 3) Create EC2 Instance
   - Choose **Launch Instance** from the EC2 dashboard.
   - Configure the following:
     - **AMI**: Choose **Amazon Linux 2023**.
     - **Instance Type**: Select an appropriate instance type based on your needs (e.g., `t2.micro` for testing or development).
     - **Security Group**: Assign the "Jenkins" security group you created in the previous step.
     - **Key Pair**: You do **not** need a key pair since the EC2 instance will be accessed via Jenkins' web interface rather than SSH.
   - **User Data**: Paste the provided startup script (Link to script: [insert link here]) to automate the setup of Jenkins in a Docker container.

### 4) Launch EC2 Instance
   - Review your configuration and click **Launch** to create the EC2 instance.
   - Once the instance is running, get the **Public DNS** (IPv4) from the EC2 dashboard.

### 5) Sign Into Jenkins
   - Open a web browser and navigate to `http://<your-ec2-public-dns>:8080`.
 

## User Data Explained



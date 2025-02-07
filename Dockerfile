# Use the official Jenkins LTS base image
FROM jenkins/jenkins:lts

# Switch to root user to install additional software
USER root

# Install necessary dependencies and tools
RUN apt-get update && \
    apt-get install -y \
    git \
    curl \
    unzip \
    ca-certificates \
    gnupg2 \
    software-properties-common

# Install Terraform
RUN curl -fsSL https://apt.releases.hashicorp.com/gpg | tee /etc/apt/trusted.gpg.d/hashicorp.asc && \
    echo "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list && \
    apt-get update && \
    apt-get install -y terraform

# Install AWS CLI v2
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install

# Switch back to the Jenkins user
USER jenkins

# Expose Jenkins port (optional, if you want to access it externally)
EXPOSE 8080

# The default command to start Jenkins (from the base image)
CMD ["jenkins"]

# # Use a Jenkins image as base image
# FROM jenkins/jenkins:lts

# # Install Docker
# USER root
# RUN apt-get update -y && \
#     apt-get install -y apt-transport-https ca-certificates curl gnupg2 software-properties-common && \
#     curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - && \
#     add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" && \
#     apt-get update -y && \
#     apt-get install -y docker-ce-cli docker-ce

# # Configure Docker to run as a non-root user
# RUN usermod -aG docker jenkins

# # Enable DinD
# RUN mkdir -p /var/lib/docker
# VOLUME /var/lib/docker

# Use Jenkins LTS image as base
# Use Jenkins LTS as the base image
FROM jenkins/jenkins:lts

# Switch to root to install packages
USER root

# Install Docker CLI and other dependencies
RUN apt-get update -y && \
    apt-get install -y docker.io python3 python3-pip git curl unzip && \
    rm -rf /var/lib/apt/lists/*

# Add Jenkins user to the Docker group
RUN usermod -aG docker jenkins

# Set up Docker-in-Docker volume
VOLUME /var/lib/docker

# Switch back to Jenkins user
USER jenkins

# Expose Jenkins default ports
EXPOSE 8080 50000


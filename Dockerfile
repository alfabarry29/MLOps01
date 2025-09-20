# # Use a lightweight Python image
# FROM python:slim

# # Set environment variables to prevent Python from writing .pyc files & Ensure Python output is not buffered
# # This reduces the docker image size further
# ENV PYTHONDONTWRITEBYTECODE=1 \
#     PYTHONUNBUFFERED=1

# # Set the working directory
# WORKDIR /app

# # Copy only the requirements file 
# COPY requirements.txt requirements.txt

# # Install required packages but do not store cache files to reduce image size
# RUN pip install --no-cache-dir -r requirements.txt

# # Copy the application code
# COPY . .

# # Train the model before running the application
# RUN python train.py

# # Expose the port that Flask will run on
# EXPOSE 5000

# # Command to run the app
# CMD ["python", "app.py"]

# Start from Jenkins LTS
# Start from Jenkins LTS
# Use official Jenkins LTS image
FROM jenkins/jenkins:lts-jdk17

# Ensure all packages are updated to the latest security patches
USER root
RUN apt-get update -y && apt-get upgrade -y && rm -rf /var/lib/apt/lists/*

# Switch to root to install Docker CLI
USER root

# Install Docker CLI dependencies
RUN apt-get update -y && \
    apt-get install -y apt-transport-https ca-certificates curl gnupg2 lsb-release software-properties-common && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - && \
    echo "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" \
        > /etc/apt/sources.list.d/docker.list && \
    apt-get update -y && \
    apt-get install -y docker-ce-cli && \
    rm -rf /var/lib/apt/lists/*

# Add Jenkins user to docker group (so it can use host Docker)
RUN usermod -aG docker jenkins

# Switch back to Jenkins user
USER jenkins

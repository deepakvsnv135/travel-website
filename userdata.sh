#!/bin/bash
#
set -e

# --- 1. System Update ---
sudo apt update -y

# --- 2. Install Java (Jenkins Requirement) ---
# Jenkins requires Java 11, 17, or 21. 
# OpenJDK 17 is the most stable LTS choice for Jenkins right now.
sudo apt install fontconfig openjdk-21-jre -y

# --- 3. Install Jenkins ---
# Download the official Jenkins repository key
# Note: Using the '2023' key which is the current standard for stable releases
sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2026.key
echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt update
sudo apt install jenkins -y

# Start Jenkins
sudo systemctl enable jenkins
sudo systemctl start jenkins

# --- 4. Install AWS CLI v2 ---
sudo snap install aws-cli --classic

# --- 5. Install Kubectl ---
# Download the latest stable release
sudo snap install kubectl --classic

# --- 6. Install Helm ---
# 'get-helm-3' is the correct script. 'get-helm-4' does not exist yet.
sudo snap install helm --classic

# --- Final Cleanup ---
sudo apt-get clean
echo "User data script completed successfully."

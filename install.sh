#!/bin/bash

# Exit script on any error
set -e

# Install git
echo "Installing Git..."
sudo apt-get update
sudo apt-get install -y git


# Install Docker
echo "Installing Docker..."
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
rm get-docker.sh

# Add current user to docker group to execute docker without sudo (this may require logout/login to take effect)
sudo usermod -aG docker $(whoami)

# Install Docker Compose
echo "Installing Docker Compose..."
sudo apt install docker-compose

# Clone a public GitHub repository
git clone https://github.com/stayrai/hello.git

# Create a data folder in the hello directory
cd hello
mkdir -p data


# Start Docker Compose (assuming you have a docker-compose.yml file in the cloned repository)
echo "Starting Docker Compose..."
docker-compose up -d

echo "Done!"
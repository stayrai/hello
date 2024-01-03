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
sudo chown root:docker /var/run/docker.sock
newgrp docker
sudo systemctl restart docker
docker ps 
# this should not fail

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


# prevent wpa_supplicant from starting on boot
sudo systemctl mask wpa_supplicant.service
sudo mv /sbin/wpa_supplicant /sbin/no_wpa_supplicant
sudo pkill wpa_supplicant


echo "Done! rebooting now"

sudo reboot
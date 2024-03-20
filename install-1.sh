#!/bin/bash

# Function to print error message and exit
error_handler() {
  echo "Error occurred at line $1."
  exit 1
}

# Trap any error and call error_handler function, passing the line number
trap 'error_handler $LINENO' ERR

# Exit script on any error
set -e

docker ps 
# this should not fail

# Install Docker Compose
echo "Installing Docker Compose..."
sudo apt install -y docker-compose

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

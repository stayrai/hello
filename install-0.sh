#!/bin/bash
source .env
# Function to print error message and exit
error_handler() {
  echo "Error occurred at line $1."
  exit 1
}

# Trap any error and call error_handler function, passing the line number
trap 'error_handler $LINENO' ERR

# Exit script on any error
set -e


# Enable 1wire and i2c
echo "dtparam=i2c_arm=on" | sudo tee -a /boot/config.txt
echo "dtoverlay=w1-gpio" | sudo tee -a /boot/config.txt

# Install git
echo "Installing Git..."
sudo apt-get update
sudo apt-get install -y git

# Install tailscale
curl -fsSL https://tailscale.com/install.sh | sh
sudo tailscale up --authkey $TSKEY


# Install Docker
echo "Installing Docker..."
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
rm get-docker.sh

# Add current user to docker group to execute docker without sudo (this may require logout/login to take effect)
echo "Configuring docker"
sudo usermod -aG docker $(whoami)
sudo chown root:docker /var/run/docker.sock
newgrp docker
sudo systemctl restart docker


echo "Done with Install 0! rebooting now"

sudo reboot

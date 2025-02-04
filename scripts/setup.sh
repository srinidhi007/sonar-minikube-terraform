#!/bin/bash

set -e

echo "Updating package lists..."
sudo apt-get update -y

echo "Installing dependencies..."
sudo apt-get install -y curl git unzip

if ! docker info &> /dev/null
then
    echo "Docker could not be foud, installing..."
    sudo apt-get install -y gnupg
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update -y
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io
else
    echo "Docker is already installed, skipping..."
fi

echo "Installing Minikube..."
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
chmod +x minikube
sudo mv minikube /usr/local/bin/

echo "Installing kubectl..."
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl
sudo mv kubectl /usr/local/bin/

echo "Installing Helm..."
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

echo "Installing Terraform..."
curl -Lo terraform.zip https://releases.hashicorp.com/terraform/1.6.0/terraform_1.6.0_linux_amd64.zip
unzip terraform.zip
sudo rm -rf /usr/local/bin/terraform
sudo mv terraform /usr/local/bin/
rm terraform.zip

echo "Setup complete!"

sudo systemctl enable docker # Enable on boot
sudo systemctl start docker
echo "Adding user:$USER to Docker group..."
sudo usermod -aG docker $USER
exec newgrp docker
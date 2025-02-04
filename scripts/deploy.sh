#!/bin/bash

set -e

echo "Add our bitnami Helm repository"
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update

# Function to update /etc/hosts with Minikube IP
update_hosts() {
    MINIKUBE_IP=$(minikube ip)
    HOSTNAME="sonarqube.local"

    if grep -q "$HOSTNAME" /etc/hosts; then
        echo "✅ [WSL] $HOSTNAME already exists in /etc/hosts"
    else
        echo "$MINIKUBE_IP $HOSTNAME" | sudo tee -a /etc/hosts
        echo "✅ [WSL] Added $MINIKUBE_IP $HOSTNAME to /etc/hosts"
        echo "If you are using WSL, you need to update your Windows hosts file as well"
        echo "add $MINIKUBE_IP $HOSTNAME in C:\Windows\System32\drivers\etc\hosts"
    fi

    # Print the final Minikube IP that was added
    echo "🚀 SonarQube should be accessible at: http://$MINIKUBE_IP:31268"
}

# Function to configure and start Minikube with Docker driver
configure_minikube() {
  echo "Configuring Minikube with Docker driver..."
  minikube config set cpus 4
  minikube config set memory 7949
  minikube config set driver docker

  echo "Starting Minikube..."
  minikube start
  minikube addons enable ingress
}

# Run the function
configure_minikube

echo "Provisioning Infrastructure with Terraform now"
cd terraform-module

echo "Terraform Initialize"
terraform init

echo "Deploying Postgres Database and Sonarcube with Terraform"
terraform apply -auto-approve

sleep 20

# Calling the fuction to update hosts in /etc/hosts
update_hosts

echo "Deploying Sonarqube and postgres with Helm complete"

echo "SonarQube should be accessible at:"
minikube service sonarqube-sonarqube -n default --url


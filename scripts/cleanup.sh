echo "Destroying infrastructure..."
kubectl delete namespace sonarqube
terraform -chdir=terraform-module destroy -auto-approve
minikube delete --all

sleep 5

echo "🧹 Removing Terraform state files..."
rm -rf terraform-module/.terraform terraform-module/.terraform.lock.hcl
rm -rf terraform-module/terraform.tfstate terraform-module/terraform.tfstate.backup

echo "Uninstalling dependencies..."
sudo apt-get remove --purge -y curl git unzip apt-transport-https ca-certificates gnupg
sleep 5
sudo apt-get remove --purge -y helm kubelet kubeadm kubectl terraform minikube
sleep 10

sudo apt-get remove --purge -y docker-ce docker-ce-cli containerd.io docker-compose-plugin  # Newer versions (try these first)
sudo apt-get remove --purge -y docker.io docker-engine docker-ce docker-ce-cli containerd.io  # Older versions (might be needed too)

sudo rm -rf /var/lib/docker
sudo rm -rf /var/lib/containerd
sudo rm -rf /var/run/docker.sock
sudo rm -rf /var/run/containerd/containerd.sock # Remove containerd socket as well

# Remove any remaining Docker-related files and directories (be cautious with these!)
sudo rm -rf /etc/docker
sudo rm -rf /etc/systemd/system/docker.service.d
sudo rm -rf /var/lib/docker.bak* # If any backup files exist

sudo apt-get autoremove -y
sudo apt-get autoclean -y
sleep 5
sudo apt-get clean
sleep 5

rm -rf ~/.kube ~/.helm ~/.minikube terraform-module/.terraform
rm -rf ~/terraform-module/.terraform.d/plugins

echo "Cleanup complete!"

sudo reboot
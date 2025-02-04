# 🚀 SonarQube Deployment with Minikube, Helm, and Terraform

This project automates the deployment of SonarQube and PostgreSQL on a Minikube cluster using Helm and Terraform. The entire setup is fully automated via Bash scripts, ensuring a seamless installation on a clean Ubuntu Server.
As the Oteemo chart is depretiaceted (https://github.com/Oteemo/charts/tree/master/charts/sonarqube), I am suing official sonaqube helm chart from github: https://SonarSource.github.io/helm-chart-sonarqube

## 📁 Folder Structure

```plaintext
SONAR-MINIKUBE-TERRAFORM/
├── k8s/                      # Kubernetes configuration files (if any)
├── scripts/                  # Automation scripts
│   ├── cleanup.sh            # Destroys cluster and removes dependencies
│   ├── deploy.sh             # Deploys SonarQube & PostgreSQL
│   ├── setup.sh              # Sets up Minikube, Helm, and Terraform
├── terraform-module/         # Terraform configuration directory
│   ├── .terraform/           # Terraform provider registry & state (auto-generated)
│   ├── providers.tf          # Defines providers (Kubernetes, Helm)
│   ├── main.tf               # Main Terraform configuration
│   ├── variables.tf          # Terraform variables
│   ├── terraform.tfvars      # User-defined variable values
│   ├── terraform.tfstate     # Terraform state file (auto-generated)
│   ├── terraform.tfstate.backup  # Backup of the state file (auto-generated)
├── .gitignore                # Excludes Terraform state and unnecessary files
└── README.md                 # Project documentation (this file)
```
# ⚡ Prerequisites

- Docker
- Minikube
- kubectl
- Helm  
- Terraform  

---

## 💻 System Requirements

Ensure your system meets the following requirements:

- **Operating System:** Ubuntu/Linux (Debian-based preferred)  
- **RAM:** Minimum **8GB**  
- **Disk Space:** At least **20GB free space**  
- **CPU:** Minimum **4 cores**  
- **Internet:** Required for downloading dependencies & charts  

---

```
## Usage:
```
```
### Step 1: clone the repo
```bash
git clone https://github.com/srinidhi007/sonar-minikube-terraform.git
cd SONAR-MINIKUBE-TERRAFORM
```

### Step 2: Run the Setup script for environment
```bash
chmod +x ./scripts/setup.sh
sudo ./scripts/setup.sh
```

### Step 3: Run the deployment script
```bash
chmod +x ./scripts/deploy.sh
sudo ./scripts/deploy.sh
```
---

## Script Workflow

1. **Configure and Start Minikube**:
   - Allocates 4 CPUs and 8GB memory for Minikube.
   - Sets Docker as the driver.
   - Enables the Minikube ingress addon.

2. **Add Helm Repository**:
   - Adds the helm Repository

3. **Terraform Deployment**:
   - Initializes and applies the Terraform configuration in the `terraform-module` folder.

4. **Verify Application**:
   - After the succesfull deployment the link will be generated to access Sonarqube on your browser   

5. **Access Sonarkube in browser from the link**:
   - The default credentials to log in are admin and admin, you can change the password to a more secure one

6. **Cleanup script to clear workspace (optional)**:
   - The default credentials to log in are admin and admin, you can change the password to a more secure one
   - run:
```bash
chmod +x ./scripts/deploy.sh
sudo ./scripts/deploy.sh
```
---
---

## Troubleshooting

### Add Minikube IP and sonarqube.local to Hosts File
To access SonarQube using a friendly domain name, add an entry to your `/etc/hosts` file:
In case you are using wsl, you also need to add in windows: C:\Windows\System32\drivers\etc
```bash
MINIKUBE_IP=$(minikube ip)
echo "$MINIKUBE_IP sonarqube.local" | sudo tee -a /etc/hosts
```


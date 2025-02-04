# 🚀 SonarQube Deployment with Minikube, Helm, and Terraform

This project automates the deployment of **SonarQube** and **PostgreSQL** on a **Minikube** cluster using **Helm** and **Terraform**.

---

## 🎯 Features

✅ **Minikube Cluster Setup**  
✅ **Helm-based Deployment of SonarQube & PostgreSQL**  
✅ **Terraform-based Infrastructure Automation**  
✅ **Ingress Configuration for External Access**  
✅ **Automated Cleanup & Deployment Scripts**  

---

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
├── minikube-url.log          # Stores Minikube IP for easy reference
└── README.md                 # Project documentation (this file)

# ⚡ Prerequisites

Before running the scripts, ensure the following dependencies are installed:

### 🐳 Docker  
- **Install:** [Docker Installation Guide](https://docs.docker.com/engine/install/)

### 🚀 Minikube  
- **Install:** [Minikube Installation Guide](https://minikube.sigs.k8s.io/docs/start/)

### ☸️ kubectl  
- **Install:** [kubectl Installation Guide](https://kubernetes.io/docs/tasks/tools/install-kubectl/)

### 🎩 Helm  
- **Install:** [Helm Installation Guide](https://helm.sh/docs/intro/install/)

### 🌍 Terraform  
- **Install:** [Terraform Installation Guide](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

---

## 💻 System Requirements

Ensure your system meets the following requirements:

- **Operating System:** Ubuntu/Linux (Debian-based preferred)  
- **RAM:** Minimum **8GB**  
- **Disk Space:** At least **20GB free space**  
- **CPU:** Minimum **4 cores**  
- **Internet:** Required for downloading dependencies & charts  

---

### 🚀 Usage

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
   - The minikube-url.log file will store the service URL output..
   - you can also see this at tail -f minikube-url.log

5. **Access Sonarkube in browser from the link**:
   - The default credentials to log in are admin and admin, you can change the password to a more secure one
   - 

---

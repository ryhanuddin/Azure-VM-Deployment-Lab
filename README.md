# Azure VM Deployment Lab

This repository demonstrates a practical Azure CLI automation lab for deploying a small Ubuntu virtual machine. It is designed for system administrator and cloud administrator portfolio use.

The project creates an Azure resource group, virtual network, subnet, network security group, public IP address, network interface, and Ubuntu VM. It also restricts SSH access to the administrator's current public IP address and includes scripts for checking VM status and cleaning up resources.

## What This Project Shows

This lab demonstrates:

- Azure CLI automation
- Azure resource group management
- Virtual network and subnet creation
- Network Security Group configuration
- IP-based SSH access restriction
- Ubuntu VM deployment
- SSH key-based access
- Basic cloud security awareness
- Cloud cost-control using cleanup automation

## Repository Structure

```text
Azure-VM-Deployment-Lab
├── README.md
├── scripts
│   ├── deploy-ubuntu-vm.sh
│   ├── restrict-ssh-my-ip.sh
│   ├── vm-status.sh
│   └── cleanup.sh
├── docs
│   ├── architecture.md
│   └── security-notes.md
├── sample-output
│   └── deployment-output.txt
└── .gitignore
```

## Scripts

| Script | Purpose |
|---|---|
| `deploy-ubuntu-vm.sh` | Deploys the full Azure VM lab environment |
| `restrict-ssh-my-ip.sh` | Updates the SSH NSG rule if your public IP changes |
| `vm-status.sh` | Shows VM status, public IP, private IP, size, and NSG rules |
| `cleanup.sh` | Deletes the lab resource group to avoid ongoing charges |

## Resources Created

The deployment script creates:

- Resource group
- Virtual network
- Subnet
- Network Security Group
- SSH inbound security rule
- Static public IP
- Network interface
- Ubuntu virtual machine

## Prerequisites

You need:

- Azure subscription
- Azure CLI installed
- Bash-compatible shell, such as Git Bash, WSL, Linux terminal, or Azure Cloud Shell

Login to Azure first:

```bash
az login
```

## Usage

Clone the repository:

```bash
git clone https://github.com/ryhanuddin/Azure-VM-Deployment-Lab.git
cd Azure-VM-Deployment-Lab
```

Run the deployment script:

```bash
bash scripts/deploy-ubuntu-vm.sh
```

After deployment, the script prints the VM public IP and SSH command.

Example:

```bash
ssh azureadmin@PUBLIC_IP_ADDRESS
```

If your public IP changes later, update the SSH rule:

```bash
bash scripts/restrict-ssh-my-ip.sh
```

Check VM and NSG status:

```bash
bash scripts/vm-status.sh
```

Delete all lab resources:

```bash
bash scripts/cleanup.sh
```

## Default Configuration

| Setting | Value |
|---|---|
| Resource Group | `rg-ubuntu-vm-lab` |
| Location | `eastus` |
| VM Name | `vm-ubuntu-lab` |
| VM Size | `Standard_B1s` |
| Image | `Ubuntu2204` |
| Admin User | `azureadmin` |
| SSH Port | `22` |
| VNet CIDR | `10.10.0.0/16` |
| Subnet CIDR | `10.10.1.0/24` |

## Security Notes

The deployment allows SSH only from the current public IP address detected during script execution. This is safer than opening SSH to the entire internet.

The script uses SSH key-based access with `--generate-ssh-keys`. Avoid using password-based SSH for internet-facing cloud VMs.

## Cost Note

This project creates real Azure resources. Delete the lab when finished:

```bash
bash scripts/cleanup.sh
```

## Portfolio Summary

Azure CLI-based infrastructure automation project that deploys an Ubuntu VM with VNet, subnet, NSG, public IP, SSH key access, IP-restricted SSH rules, VM status reporting, and cleanup automation.

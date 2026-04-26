#!/bin/bash

# Azure Ubuntu VM deployment lab.
# Creates a small Ubuntu VM with VNet, subnet, NSG, public IP, and SSH access.

set -e

RESOURCE_GROUP="rg-ubuntu-vm-lab"
LOCATION="eastus"
VNET_NAME="vnet-ubuntu-lab"
SUBNET_NAME="subnet-ubuntu"
NSG_NAME="nsg-ubuntu-vm"
PUBLIC_IP_NAME="pip-ubuntu-vm"
NIC_NAME="nic-ubuntu-vm"
VM_NAME="vm-ubuntu-lab"
ADMIN_USER="azureadmin"
VM_SIZE="Standard_B1s"
IMAGE="Ubuntu2204"

echo "[+] Checking Azure login..."
az account show >/dev/null 2>&1 || {
  echo "[!] Please run: az login"
  exit 1
}

echo "[+] Detecting current public IP..."
MY_IP=$(curl -s ifconfig.me)

if [ -z "$MY_IP" ]; then
  echo "[!] Could not detect public IP."
  exit 1
fi

echo "[+] SSH will be allowed from: $MY_IP/32"

echo "[+] Creating resource group..."
az group create \
  --name "$RESOURCE_GROUP" \
  --location "$LOCATION" \
  --output table

echo "[+] Creating virtual network and subnet..."
az network vnet create \
  --resource-group "$RESOURCE_GROUP" \
  --name "$VNET_NAME" \
  --address-prefix 10.10.0.0/16 \
  --subnet-name "$SUBNET_NAME" \
  --subnet-prefix 10.10.1.0/24 \
  --output table

echo "[+] Creating network security group..."
az network nsg create \
  --resource-group "$RESOURCE_GROUP" \
  --name "$NSG_NAME" \
  --output table

echo "[+] Creating SSH rule for current public IP..."
az network nsg rule create \
  --resource-group "$RESOURCE_GROUP" \
  --nsg-name "$NSG_NAME" \
  --name Allow-SSH-MyIP \
  --priority 1000 \
  --access Allow \
  --protocol Tcp \
  --direction Inbound \
  --source-address-prefixes "$MY_IP/32" \
  --source-port-ranges "*" \
  --destination-address-prefixes "*" \
  --destination-port-ranges 22 \
  --output table

echo "[+] Creating static public IP..."
az network public-ip create \
  --resource-group "$RESOURCE_GROUP" \
  --name "$PUBLIC_IP_NAME" \
  --sku Basic \
  --allocation-method Static \
  --output table

echo "[+] Creating network interface..."
az network nic create \
  --resource-group "$RESOURCE_GROUP" \
  --name "$NIC_NAME" \
  --vnet-name "$VNET_NAME" \
  --subnet "$SUBNET_NAME" \
  --network-security-group "$NSG_NAME" \
  --public-ip-address "$PUBLIC_IP_NAME" \
  --output table

echo "[+] Creating Ubuntu VM..."
az vm create \
  --resource-group "$RESOURCE_GROUP" \
  --name "$VM_NAME" \
  --nics "$NIC_NAME" \
  --image "$IMAGE" \
  --size "$VM_SIZE" \
  --admin-username "$ADMIN_USER" \
  --generate-ssh-keys \
  --output table

VM_IP=$(az vm show \
  --resource-group "$RESOURCE_GROUP" \
  --name "$VM_NAME" \
  --show-details \
  --query publicIps \
  --output tsv)

echo
echo "[+] Deployment complete."
echo "[+] VM name: $VM_NAME"
echo "[+] Public IP: $VM_IP"
echo "[+] SSH command:"
echo "ssh $ADMIN_USER@$VM_IP"

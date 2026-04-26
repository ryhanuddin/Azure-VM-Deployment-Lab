#!/bin/bash

# Displays basic Azure VM and NSG information.

set -e

RESOURCE_GROUP="rg-ubuntu-vm-lab"
VM_NAME="vm-ubuntu-lab"
NSG_NAME="nsg-ubuntu-vm"

echo "[+] VM status:"
az vm show \
  --resource-group "$RESOURCE_GROUP" \
  --name "$VM_NAME" \
  --show-details \
  --query "{Name:name, PowerState:powerState, PublicIP:publicIps, PrivateIP:privateIps, Size:hardwareProfile.vmSize}" \
  --output table

echo
echo "[+] NSG inbound rules:"
az network nsg rule list \
  --resource-group "$RESOURCE_GROUP" \
  --nsg-name "$NSG_NAME" \
  --query "[].{Name:name, Priority:priority, Access:access, Direction:direction, Source:sourceAddressPrefix, Port:destinationPortRange}" \
  --output table

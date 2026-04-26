#!/bin/bash

# Updates the NSG SSH rule to allow access only from the current public IP.

set -e

RESOURCE_GROUP="rg-ubuntu-vm-lab"
NSG_NAME="nsg-ubuntu-vm"
RULE_NAME="Allow-SSH-MyIP"

echo "[+] Detecting current public IP..."
MY_IP=$(curl -s ifconfig.me)

if [ -z "$MY_IP" ]; then
  echo "[!] Could not detect public IP."
  exit 1
fi

echo "[+] Updating SSH source IP to: $MY_IP/32"

az network nsg rule update \
  --resource-group "$RESOURCE_GROUP" \
  --nsg-name "$NSG_NAME" \
  --name "$RULE_NAME" \
  --source-address-prefixes "$MY_IP/32" \
  --output table

echo "[+] SSH rule updated."

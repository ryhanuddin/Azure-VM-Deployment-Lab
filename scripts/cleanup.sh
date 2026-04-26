#!/bin/bash

# Deletes the lab resource group to avoid ongoing Azure charges.

set -e

RESOURCE_GROUP="rg-ubuntu-vm-lab"

echo "[!] This will delete the resource group and all resources inside it:"
echo "$RESOURCE_GROUP"
echo

read -p "Type DELETE to continue: " CONFIRM

if [ "$CONFIRM" != "DELETE" ]; then
  echo "[=] Cleanup cancelled."
  exit 0
fi

echo "[+] Deleting resource group..."
az group delete \
  --name "$RESOURCE_GROUP" \
  --yes \
  --no-wait

echo "[+] Delete request submitted."
echo "[+] You can check progress in Azure Portal."

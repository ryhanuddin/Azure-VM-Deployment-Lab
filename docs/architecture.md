# Architecture

This lab creates a simple Azure VM environment suitable for learning and portfolio demonstration.

```text
Resource Group: rg-ubuntu-vm-lab
│
├── Virtual Network: vnet-ubuntu-lab
│   └── Subnet: subnet-ubuntu
│
├── Network Security Group: nsg-ubuntu-vm
│   └── Inbound Rule: Allow SSH from current public IP only
│
├── Public IP: pip-ubuntu-vm
│
├── Network Interface: nic-ubuntu-vm
│
└── Virtual Machine: vm-ubuntu-lab
```

## Traffic Flow

```text
Admin Laptop
    │
    │ SSH TCP/22
    │ Source restricted to current public IP
    ▼
Azure NSG
    ▼
Ubuntu VM
```

## Why This Design Is Useful

This structure demonstrates the main building blocks of a basic Azure VM deployment:

- Compute through Azure VM
- Networking through VNet and subnet
- Access control through NSG
- Internet access through public IP
- Secure administration through SSH key access

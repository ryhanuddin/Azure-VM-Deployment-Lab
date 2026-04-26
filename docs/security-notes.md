# Security Notes

This lab includes basic Azure security practices for VM administration.

## Included Security Controls

- SSH access is restricted to the administrator's current public IP.
- The VM uses SSH key-based authentication.
- A Network Security Group controls inbound access.
- Cleanup automation is included to remove unused resources.

## What Not To Do

Avoid opening SSH to the full internet:

```text
0.0.0.0/0
```

That allows login attempts from anywhere and increases risk.

## Recommended Improvements For Production

For a real production environment, consider:

- Azure Bastion instead of direct public SSH
- Private subnet deployment
- Just-in-time VM access
- Microsoft Defender for Cloud
- Azure Monitor alerts
- Centralized logging
- Terraform or Bicep for Infrastructure as Code
- Azure DevOps or GitHub Actions for controlled deployment

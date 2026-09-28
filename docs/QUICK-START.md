# AZ-104 Course: Quick Start

## Begin

1. Open the [30-day study plan](30-DAY-STUDY-PLAN.md).
2. Check the current [AZ-104 exam objectives](https://learn.microsoft.com/en-us/credentials/certifications/exams/az-104).
3. Confirm you can access the Azure Portal and an authorized lab tenant/subscription.
4. Install Azure CLI using Microsoft's current [installation guide](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli).
5. Start Day 1, and use the module links in the plan and the [course map](../README.md#course-map).

## Verify your CLI context

```bash
az login
az account show --output table
az account list --output table
```

Before creating anything, confirm that the displayed tenant and subscription are the ones intended for practice. Use `az account set --subscription "<subscription-id-or-name>"` to switch deliberately.

## Keep labs low-cost

- Check pricing and free-tier eligibility before deployment; not all services or settings are free.
- Prefer diagrams, `what-if`, template validation, Portal inspection, and local tools when a live deployment is not necessary.
- Use a dedicated resource group and remove it after the lab. Verify separately billed resources and data are gone.
- A Cost Management budget sends alerts; it is not a hard spending limit.
- Avoid public SSH/RDP. If a task needs it, scope access to your IP and remove the rule immediately afterward.

## Study loop

For each day, learn the terms, explain the architecture in your own words, perform or simulate the lab, verify the result, troubleshoot one failure path, and answer practice questions without notes. Record incorrect answers by concept, not just by question number.

Older material in the module folders varies in completeness. The course map marks the best available starting point for each domain; use the 30-day plan as the authoritative schedule.
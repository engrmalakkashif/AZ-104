# Day 7 Lab Notes: Storage Accounts

## Purpose
Compare storage-account creation settings and redundancy choices, then verify the selected configuration safely.

## Prerequisites
- Azure subscription where you are authorized to create and delete a resource group and storage account.
- Azure Portal access; Azure CLI is optional.
- Unique account name, selected region, and approved spending limit.
- A cost alert is useful but is not a spending cap.

## Cost and safety
Storage can incur capacity, operation, redundancy, transfer, snapshot, and retention costs. A free account does not guarantee every redundancy option or configuration is free. For zero-deployment practice, inspect the creation wizard and cancel before creating. Never disable security on a production account.

## Naming and resource plan
- Resource group: `az104-storage-lab-<initials>`
- Storage name: globally unique, lowercase, 3–24 characters; letters/numbers only.
- Use only non-sensitive test data.
- Avoid enabling public blob access. Keep secure transfer required and TLS at current recommended minimum.

## Portal navigation
Azure Portal > **Storage accounts** > **Create**. Inspect Basics, Advanced, Networking, Data protection, Encryption and Tags. For an existing disposable account: **Data management > Redundancy** and **Configuration**.

## CLI context check
```bash
az login
az account show --output table
az account set --subscription '<subscription-id-or-name>'
```
Confirm tenant and subscription before resource creation. Do not store storage keys or SAS values in files or command history.

## Completion and cleanup
Record account kind, SKU, region, endpoint types, redundancy and network posture. Delete the dedicated resource group after the exercise, check for remaining resources, and revisit Cost Analysis when usage data appears.
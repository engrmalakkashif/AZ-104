# Day 8 Lab Notes: Blob Storage

## Prerequisites
- Day 7 storage-account concepts.
- Authorized test subscription/account and storage data-plane permission.
- Azure Portal or CLI with `az login`; use a small non-sensitive local file.

## Cost and safety
Capacity, read/write/list operations, redundancy, retrieval, transfer and retained versions can cost money. Archive rehydration can take time and incur retrieval charges. Do not use real customer data. Keep the container private; do not turn on anonymous access to fix an authorization error.

## Recommended test variables
Use a dedicated lab RG, existing approved storage account where possible, and a container named `lab-private`. For CLI, use `--auth-mode login`. Required Blob data role is separate from storage-account management permissions. Allow time for role assignment propagation.

## Portal path
**Storage accounts** > account > **Data storage > Containers** > container > **Upload**. Select a blob > inspect **Properties** and **Access tier**. **Data protection** contains versioning/soft-delete controls when supported.

## Cleanup
Delete test blobs/container. If versioning/soft delete is enabled, confirm no retained versions or deleted objects remain. Delete a disposable account/resource group and check cost after billing data refresh.
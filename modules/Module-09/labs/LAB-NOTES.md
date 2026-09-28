# Day 9 Lab Notes: Blob Security and Protection

## Prerequisites
- Days 7–8 concepts, authorized disposable storage account and a private test container.
- Azure Portal; Entra sign-in and suitable Blob data permissions.
- A tiny non-sensitive test object.

## Security constraints
Never paste account keys/SAS tokens into chat, notes, source control, screenshots or shared shell history. If generating a token, use a private terminal, least privilege, HTTPS-only, short expiry and a revocation plan. Do not weaken production settings. Paid features and retained versions may incur charges.

## Portal path
Storage account > **Data management > Data protection** for soft delete/versioning/restore options. **Data storage > Containers** > container/blob for access and SAS options. **Access control (IAM)** manages data-role assignments. **Networking** controls endpoint reachability separately.

## Zero-secret alternative
Inspect the SAS wizard but do not generate/copy a token. Complete a table showing principal, object scope, operation, expiry, network path, and revocation option. Compare Entra-based access with a SAS.

## Cleanup
Expire/revoke test credentials, delete test blob/container, inspect versions and soft-deleted data, remove temporary role assignments, and delete disposable account/RG if created.
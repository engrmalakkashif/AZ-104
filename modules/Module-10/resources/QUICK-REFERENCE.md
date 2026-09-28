# Day 10 Quick Reference: Azure Files

## Choose
- **Azure Files:** Managed file share accessed with supported SMB or NFS configuration.
- **Blob Storage:** Object API for unstructured data; not a general mounted file share.

## Diagnose a mount
1. Account/share protocol support and tier
2. DNS and endpoint resolution
3. Network path, firewall, private endpoint/route and required port
4. Authentication method and client compatibility
5. Share/file authorization
6. Mount path, options and credentials

## Cost controls
Check tier/performance, quota, redundancy, snapshots, transactions, transfer and any VM used for a mount. Remove snapshots and test share, then check cost later.

Portal: **Storage accounts > account > Data storage > File shares > share > Connect**.
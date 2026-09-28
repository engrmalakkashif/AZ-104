# Day 8 Quick Reference: Blob Storage

## Hierarchy and types
`Storage account > container > blob`

| Blob type | Typical pattern |
|---|---|
| Block | Documents, images, media, general objects |
| Append | Append-oriented data such as certain logs |
| Page | Random page reads/writes and specialized disk-like workloads |

## Access tiers
Hot = frequent access; Cool/Cold = less frequent access with different storage/retrieval economics; Archive = offline and must be rehydrated. Validate minimum retention and early-deletion charges for the selected tier.

## Identity-based CLI
```bash
az storage container list --account-name '<account>' --auth-mode login --output table
az storage blob list --account-name '<account>' --container-name '<container>' --auth-mode login --output table
az storage blob show --account-name '<account>' --container-name '<container>' --name '<blob>' --auth-mode login
```
Grant the least-privilege Blob data role needed. Keep anonymous access off unless explicitly approved.
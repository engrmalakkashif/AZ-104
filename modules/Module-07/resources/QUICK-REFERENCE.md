# Day 7 Quick Reference: Storage Accounts

## Redundancy
| Option | Replication scope | Secondary reads |
|---|---|---|
| LRS | Within one region/facility | No |
| ZRS | Across availability zones in one region | No secondary-region endpoint |
| GRS | Local primary plus asynchronous geo-secondary | No |
| RA-GRS | GRS plus read access to secondary | Yes |
| GZRS | ZRS primary plus asynchronous geo-secondary | No |
| RA-GZRS | GZRS plus read access to secondary | Yes |

Check region/service availability and current design details before relying on a specific option. Replication is not backup.

## Safe CLI checks
```bash
az account show --output table
az storage account list --output table
az storage account show --name '<account>' --resource-group '<rg>' --output json
az storage account show --name '<account>' --resource-group '<rg>' \
  --query '{kind:kind,sku:sku.name,location:location,httpsOnly:enableHttpsTrafficOnly}' \
  --output table
```

## Exam reminders
- Account names are globally unique, lowercase, 3–24 characters.
- Distinguish management-plane roles from data-plane access.
- Secure transfer/TLS, identity, firewall and data protection are separate settings.
- Compare regional support, failure scope, read requirement, and cost.
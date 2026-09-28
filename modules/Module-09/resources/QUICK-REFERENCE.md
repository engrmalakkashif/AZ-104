# Day 9 Quick Reference: Blob Security

| Method/feature | Use | Key caution |
|---|---|---|
| Entra ID + Blob data role | Identity-based operations | Management-plane roles alone may not grant blob data |
| User delegation SAS | Delegated Blob access signed via Entra | Bearer secret; scope and expiry tightly |
| Service SAS | Delegated access to a storage service/resource | Stored policy can apply in supported cases |
| Account SAS | Delegated access to account-level services/resource types | Broadest SAS scope; avoid unless necessary |
| Shared key | Legacy/account-level access | Broad secret; rotate and migrate workloads |
| Blob soft delete | Recover deleted blobs | Retention/cost; must be enabled before deletion |
| Container soft delete | Recover deleted containers | Retention/cost; must be enabled before deletion |
| Versioning | Preserve prior blob writes | Extra stored versions incur cost |
| Snapshot | Point-in-time blob copy | Not a complete backup strategy |

**SAS design:** minimum resource + permission + short expiry + HTTPS + protected secret + revocation/rotation plan.

**CLI principle:** use `--auth-mode login` for identity-based data access where supported. Never print a live SAS in shared logs.
# Day 10: Azure Files

**Exam domain:** Implement and manage storage | **Level:** Beginner to intermediate  
**Prerequisites:** Storage accounts, resource groups, basic SMB/NFS and file-system concepts

## 1. What is it?
Azure Files is a managed cloud file-share service. Clients can access a share over SMB or, for supported configurations, NFS; it is useful when applications need a shared file-system interface rather than object access through Blob APIs.

## 2. Why is it needed?
It supports shared files for users and applications without operating a file server. Use it for lift-and-shift file shares, shared configuration, or application data where the protocol and performance fit. It is not a replacement for Blob Storage for massive object collections, nor does creating a share automatically configure client identity or network access. Stored data, transactions, snapshots, and transfer can incur charges.

## 3. Key components
- **Storage account:** Namespace, region, redundancy, security and billing boundary.
- **File share:** Named share, quota, protocol and tier configuration.
- **Directory/file:** Hierarchical paths and file data.
- **SMB/NFS:** File access protocols; availability depends on account and share configuration.
- **Authentication/authorization:** Account key or supported identity-based configuration, with permissions and network access configured separately.
- **Snapshot/soft delete:** Recovery features with retention and storage implications.

## 4. Architecture / simple diagram
```text
Client or VM
    | SMB or NFS over permitted network path
    v
Storage account endpoint
    |
    +-- File share (quota, tier, protocol)
          +-- directories and files
          +-- snapshots / recovery settings
```

## 5. How it works step-by-step
1. Select an account type, region, redundancy, and protocol-compatible configuration.
2. Create a file share and set a quota and tier supported by the account.
3. Configure network rules and an authentication method appropriate to the client.
4. Grant access at the required share/directory/file level where supported.
5. Mount the share from a compatible client using the documented endpoint and protocol.
6. Monitor capacity, transactions, availability, and recovery settings; remove temporary credentials and lab resources.

## 6. Important Azure Portal settings
Portal: **Storage accounts** > select account > **Data storage** > **File shares** > **+ File share**. Review share name, quota, tier, and protocol options. On the account, inspect **Networking**, **Configuration**, and **Data protection**. Identity-based SMB options are configured through the account's file-share identity/authentication settings and have prerequisites; do not assume a storage key and Entra identity are interchangeable.

⭐ Quota limits share capacity; it does not pre-allocate or guarantee that capacity. Protocol, redundancy, identity, and tier availability are configuration-dependent.

## 7. Azure CLI commands
Sign in and verify the intended subscription. The create commands below provision resources and may incur charges.
```bash
az login
az account show --output table
RG="az104-files-lab"
LOCATION="eastus"
STORAGE="az104files$RANDOM"
SHARE="labshare"

az group create --name "$RG" --location "$LOCATION"
az storage account create --name "$STORAGE" --resource-group "$RG" \
  --location "$LOCATION" --sku Standard_LRS --kind StorageV2
az storage share-rm create --resource-group "$RG" --storage-account "$STORAGE" \
  --name "$SHARE" --quota 1
az storage share-rm list --resource-group "$RG" --storage-account "$STORAGE" --output table
```
Management-plane commands avoid placing an account key or SAS in shell history. Check `az storage share-rm --help` for current options. Remove resources after the lab:
```bash
az group delete --name "$RG" --yes --no-wait
```

## 8. Hands-on lab with exact steps
**Prerequisites:** Authorized subscription and rights to create a resource group/storage account; Azure CLI; approved budget. A Free account does not guarantee a free share. Check current regional price first.

**Portal walkthrough:**
1. Sign in to `https://portal.azure.com`; verify directory and subscription.
2. Search **Storage accounts**. Open a disposable account, or create one only after reviewing pricing.
3. Open **Data storage** > **File shares** > **+ File share**.
4. Enter `labshare`, choose the lowest suitable tier and a small quota; note protocol options.
5. Select **Review + create** and **Create**. Open the share and inspect **Connect** for client-specific mount instructions.
6. Do not paste account keys into notes or source control. For a no-cost alternative, stop after inspecting the configuration blades in an existing training account.
7. When finished, delete the share and disposable account/resource group. Verify there are no snapshots or related resources left; review Cost Management later because billing data can be delayed.

**Expected result:** A private share is listed with the configured quota and tier. No public access should be enabled for this exercise. **Cost warning:** Storage, transactions, snapshots, and network transfer may be billed; do not run a VM just to mount the share unless separately approved.

## 9. Real-world DevOps use case
A legacy deployment writes shared configuration and generated files to a file share. A release pipeline stages versioned files, validates permissions, and deploys to test before production. Production uses identity-based access where supported, private networking, monitored capacity, and documented snapshot/restore procedures. Secrets are obtained from a managed secret store, not committed to pipeline YAML.

## 10. Common troubleshooting scenarios
- **Mount fails:** Check DNS, endpoint reachability, protocol/port, firewall, client OS support, and exact mount syntax.
- **Authentication denied:** Confirm the selected authentication method, identity prerequisites, share permissions, and client credentials.
- **Share not listed:** Confirm subscription/account context, resource-group scope, and control-plane permissions.
- **Quota exceeded:** Check share quota and actual capacity; increase only after reviewing cost.
- **Slow access:** Compare tier/performance requirements, client location, network path, and metrics.
- **NFS unavailable:** Verify account and share configuration support NFS and required network conditions.
- **Deleted file recovery fails:** Check soft-delete/snapshot configuration, retention window, and correct restore workflow.

## 11. Common mistakes
- Confusing Azure Files (file shares) with Blob Storage (objects).
- Treating account-key access as least privilege; keys can grant broad access.
- Assuming SMB and NFS have identical authentication and feature support.
- Exposing a storage endpoint publicly when a private path is required.
- Forgetting snapshots, data, or the storage account during cleanup.
- Treating share quota as reserved capacity or as a spending cap.

## 12. AZ-104 exam points ⭐
- Select Azure Files when a managed shared file system/protocol is required; use Blob for object access.
- Know SMB versus NFS support depends on account/share configuration.
- Separate network access from authentication and authorization.
- Compare redundancy, tier, quota, snapshots, and soft delete against scenario requirements.
- Mount configuration is client-specific; verify endpoint, DNS, protocol, port, and credentials.
- Always distinguish a share quota from provisioned performance/capacity semantics.

## 13. Interview questions + answers
1. **What is Azure Files?** A managed file-share service accessible over supported protocols such as SMB and, in eligible configurations, NFS.
2. **How does it differ from Blob Storage?** Files exposes a file-share interface; Blob exposes object storage APIs and containers.
3. **What does a file-share quota do?** It limits the share's allowed capacity; it does not itself reserve that capacity.
4. **What should you check before mounting?** Protocol support, endpoint/DNS, network rules, authentication, authorization, and client syntax.
5. **Are SMB and NFS interchangeable?** No; supported account types, authentication, and client requirements differ.
6. **How can storage keys be risky?** They provide broad account-level access and are difficult to scope to one user or operation.
7. **How would you protect a share privately?** Restrict network paths, use private connectivity where required, and configure least-privilege identity access.
8. **How would you recover a deleted file?** Use configured soft delete or snapshots within retention and validate the restore path.
9. **What drives Azure Files cost?** Stored data, tier/performance, redundancy, transactions, snapshots, and transfer.
10. **How would you deploy files safely?** Stage and validate files, use controlled pipeline identity, preserve rollback data, and monitor capacity/access.

## 14. AZ-104 practice questions + answers
1. **A workload requires a shared SMB file system. Which service fits?** Azure Files; it provides managed file shares.
2. **A workload uses object API operations on unstructured files. Which service is a better fit?** Blob Storage; it is object storage.
3. **A client cannot mount a share. What should be checked first?** Protocol, DNS/network reachability, firewall, authentication, and mount syntax.
4. **Does a 1-TiB quota mean 1 TiB is pre-purchased?** No; quota is a capacity limit, not proof of preallocation.
5. **A team needs NFS. Can it assume any storage account supports it?** No; confirm the account/share configuration and regional support.
6. **Which is broader: a storage account key or a narrowly scoped identity permission?** The account key; prefer least-privilege identity authorization where supported.
7. **A share must not be reachable from the public internet. What configuration area matters?** Storage networking/private connectivity; authentication alone does not block public network paths.
8. **A file was deleted yesterday. What determines whether recovery is possible?** Whether soft delete/snapshots were enabled and the retention period has not expired.
9. **A share is unexpectedly costly. What should be reviewed?** Data volume, tier/performance, redundancy, transactions, snapshots, and transfer.
10. **A share is created but a user cannot open a file. Is creation sufficient?** No; network access, authentication, and authorization must all permit the operation.

## 15. Short revision notes
- Azure Files = managed file share; Blob = object store.
- Account, protocol, tier, redundancy, network, and identity settings determine behavior.
- Quota is a limit, not a spending cap or access grant.
- Diagnose mounts across DNS, network, protocol, authentication, authorization, and client syntax.
- Soft delete/snapshots only help when configured and within retention.
- Clean up shares, snapshots, accounts, and lab resources.

## Azure ↔ AWS Comparison
Azure Files is closest to Amazon EFS for managed NFS shares and to Amazon FSx for managed file-system workloads; there is no single exact equivalent for every SMB/NFS configuration.
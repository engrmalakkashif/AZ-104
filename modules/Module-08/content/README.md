# Day 8: Azure Blob Storage

**Exam domain:** Implement and manage storage | **Prerequisites:** Day 7 storage-account concepts

## 1. What is it?
Azure Blob Storage is Azure's object-storage service for unstructured data such as documents, images, logs, media and backups. A blob is stored in a container inside a storage account and is addressed through a service endpoint and object name.

## 2. Why is it needed?
Blob Storage scales for large object collections and supports access tiers, metadata, versioning and lifecycle management. Use it when applications access objects through HTTPS/REST, SDKs, or tools such as AzCopy. Use Azure Files when clients require a shared file protocol. Blob storage does not behave like a mounted POSIX filesystem by default.

## 3. Key components
- **Storage account:** Namespace, region, security and redundancy boundary.
- **Container:** Logical grouping and access-policy boundary for blobs.
- **Blob:** Object data plus properties/metadata.
- **Block blob:** Common choice for documents, images and media; uploaded as blocks.
- **Append blob:** Optimized for append operations such as some log patterns.
- **Page blob:** Random read/write pages; used by certain workloads including unmanaged disk scenarios.
- **Access tier:** Hot, Cool, Cold, or Archive for eligible block blobs. Archive is offline and requires rehydration.
- **Endpoint:** Common public endpoint pattern `https://<account>.blob.core.windows.net` (network policy may restrict access).

## 4. Architecture / simple diagram
```text
Application / AzCopy / Storage Explorer
       | HTTPS + identity or scoped credential
       v
Storage account: <account>.blob.core.windows.net
       |
       +-- Container: images
       |       +-- block blob: logo.png
       +-- Container: logs
               +-- append blob: service.log
```

## 5. How it works step-by-step
1. Create or select an eligible storage account and private container.
2. Authenticate using Microsoft Entra ID, SAS, or shared key, then authorize the requested data operation.
3. Upload a blob; Azure stores object data and properties under its container/name.
4. Select or change the access tier appropriate to access frequency and retention.
5. Read or list blobs using SDK/REST/AzCopy/Portal, subject to both authorization and network controls.
6. Protect data using versioning, soft delete, snapshots or backup as appropriate; tiering/deletion behavior can affect cost and recoverability.

## 6. Important Azure Portal settings
Portal > **Storage accounts** > account > **Data storage > Containers** > **+ Container**. Keep **Anonymous access level: Private (no anonymous access)** unless public reads are an explicit approved requirement. Open a container > **Upload** for a small test object. Select a blob to inspect **Properties**, **Metadata**, **Access tier**, and version history where enabled. Account defaults are at **Configuration**; versioning/soft delete are under **Data protection**.

⭐ Container access level and account networking are distinct: a private container requires authorization, while public network restrictions are controlled separately. Setting account-wide anonymous access to disabled prevents anonymous blob reads even if a container is mistakenly configured for public access.

## 7. Azure CLI commands
Use Entra sign-in and data-plane RBAC rather than account keys. The current user needs an appropriate Blob data role (for example, Storage Blob Data Contributor for upload). Role propagation may take time.
```bash
az login
az account show --output table
RG='az104-blob-lab'
LOCATION='eastus'
ACCOUNT='az104blob12345' # substitute unique lowercase 3-24 character name
CONTAINER='lab-private'

az group create --name "$RG" --location "$LOCATION"
az storage account create --name "$ACCOUNT" --resource-group "$RG" \
  --location "$LOCATION" --sku Standard_LRS --kind StorageV2 --https-only true
az storage container create --name "$CONTAINER" --account-name "$ACCOUNT" \
  --auth-mode login --public-access off
printf 'AZ-104 test object\n' > /tmp/az104-blob.txt
az storage blob upload --account-name "$ACCOUNT" --container-name "$CONTAINER" \
  --name sample.txt --file /tmp/az104-blob.txt --auth-mode login
az storage blob list --account-name "$ACCOUNT" --container-name "$CONTAINER" \
  --auth-mode login --output table
az storage blob download --account-name "$ACCOUNT" --container-name "$CONTAINER" \
  --name sample.txt --file /tmp/az104-downloaded.txt --auth-mode login
```
Commands create billed resources. Delete the lab group after the exercise. Use `az storage blob --help` and check the current CLI syntax.

## 8. Hands-on lab with exact steps
**Prerequisites:** Authorized subscription, storage-account create permission, Blob data-plane role on the account/container, Azure CLI or Portal, and approved budget. Use only a tiny non-sensitive file. **No-deployment alternative:** inspect an existing training account and simulate the container/blob path.

1. Verify tenant/subscription with `az account show`.
2. Create a disposable storage account (Day 7 commands) or use a dedicated training account.
3. In Portal open **Containers** > **+ Container**. Name it `lab-private`; leave anonymous access private/off.
4. Upload a small text file. Verify name, size, content type and tier.
5. Download the file and compare it with the original. In CLI use `--auth-mode login`; resolve authorization errors by checking data-plane role and scope, not by enabling public access.
6. If inspecting tier selection, note Hot/Cool/Cold/Archive eligibility, minimum retention/early deletion considerations and retrieval costs. Do not archive a file needed immediately.
7. Delete the blob/container and then the lab resource group. Remove temporary local copies if desired. Review cost later.

## 9. Real-world DevOps use case
CI publishes versioned build artifacts to a private container. The pipeline uses workload identity with minimum Blob data permissions; applications download artifacts over private networking. Lifecycle rules transition old artifacts to cooler tiers and eventually delete them under a retention policy. Release manifests remain available for rollback.

## 10. Common troubleshooting scenarios
- **AuthorizationPermissionMismatch:** Add/check the correct Blob data-plane role at the right scope; management-plane Contributor alone may not grant blob data access.
- **Container not found:** Verify account, container name, subscription and endpoint.
- **403 from network:** Check account firewall, private endpoint/DNS, trusted network and client path.
- **Anonymous access denied:** Expected for a private container; authenticate and authorize instead of making it public.
- **Upload throttles/fails:** Check network, file size, concurrency, account limits and CLI logs.
- **Cold/archive read delayed or costly:** Check tier and rehydration status; Archive requires rehydration before normal reads.
- **Unexpected early deletion charge:** Review tier minimum-duration and early-deletion rules for the service/SKU.

## 11. Common mistakes
- Calling containers directories with full filesystem semantics.
- Assuming a management-plane Reader/Contributor role grants blob data access.
- Setting anonymous access to container/blob when a SAS or identity is sufficient.
- Treating Archive as immediately online or ignoring retrieval/rehydration cost.
- Assuming access tier changes replication or encryption.
- Forgetting versions, snapshots, soft-deleted blobs and local test data during cleanup.

## 12. AZ-104 exam points ⭐
- Hierarchy: account > container > blob.
- Block blobs are common object content; append blobs suit append patterns; page blobs support random-page I/O scenarios.
- Hot = frequent access; Cool/Cold = infrequent access; Archive = offline with rehydration.
- Know container access level and account-level anonymous access control.
- Separate management-plane RBAC from Blob data-plane roles.
- Compare retrieval cost, latency, minimum retention and early deletion when choosing a tier.

## 13. Interview questions + answers
1. **What is a blob?** An object stored in a container, with content and properties/metadata.
2. **Block versus append blob?** Block blobs suit general objects; append blobs optimize append operations.
3. **What is a page blob used for?** Random page-oriented reads/writes, including some disk-oriented workloads.
4. **What is the Blob hierarchy?** Storage account, container, blob.
5. **Why can Contributor fail to upload a blob?** Management-plane role does not necessarily include Blob data actions.
6. **When choose Archive?** Long-term, rarely accessed data where offline rehydration delay/cost is acceptable.
7. **How keep a container private?** Disable anonymous access and grant authorized identities or scoped credentials.
8. **What does a blob tier affect?** Storage and access cost/latency characteristics, not authorization.
9. **How safely automate upload?** Use managed/federated identity and least-privilege Blob data role.
10. **How recover an overwritten blob?** If configured, restore a prior version/snapshot or use supported point-in-time recovery.

## 14. AZ-104 practice questions + answers
1. **Store an image object accessed by HTTPS APIs.** Blob Storage, typically a block blob.
2. **Need append-only logging behavior.** Consider append blobs, while validating service limits and design.
3. **Need to read archived data immediately.** Archive is unsuitable until rehydrated; choose an online tier if immediate access is required.
4. **CLI upload gets authorization mismatch. User has Contributor on account.** Assign an appropriate Blob data-plane role.
5. **Prevent anonymous reads.** Keep account anonymous blob access disabled and container private.
6. **Where does a blob live?** In a container in a storage account.
7. **Cool tier data read frequently unexpectedly.** Evaluate retrieval/transaction costs and tier suitability.
8. **Does changing Hot to Cool change redundancy?** No; redundancy is a separate account setting.
9. **A public container still cannot be anonymously read. Why?** Account-level public access may be disabled or network restrictions apply.
10. **Need restore prior contents after overwrite.** Enable and use versioning/snapshot/appropriate recovery feature before the incident.

## 15. Short revision notes
- Account > container > blob.
- Block = general object; append = append pattern; page = random-page I/O.
- Hot/Cool/Cold are online tiers; Archive is offline and needs rehydration.
- Data role, network path, and anonymous-access setting all matter.
- Use private containers, identity, tiny test objects and immediate cleanup.

## Azure ↔ AWS Comparison
Azure Blob Storage is closest to Amazon S3 object storage; access tiers and account/container controls differ in implementation and behavior.
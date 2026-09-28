# Day 11: Storage Operations, Lifecycle, and Object Replication

**Exam domain:** Implement and manage storage | **Prerequisites:** Days 7–9 storage accounts and Blob concepts

## 1. What is it?
Storage operations tools move and manage data; lifecycle management automates tier transitions/deletion based on age or access; object replication asynchronously copies eligible block blobs between accounts/containers. Storage Explorer is a graphical client, while AzCopy is a command-line transfer tool.

## 2. Why is it needed?
Administrators need repeatable, efficient transfer and retention processes. AzCopy supports scripted bulk movement; Storage Explorer helps inspect data; lifecycle rules control long-term storage cost; object replication supports copy/availability scenarios. None is automatically a backup or transactionally consistent database replication system.

## 3. Key components
- **Storage Explorer:** Desktop app for browsing supported Azure storage services; authenticates through configured methods.
- **AzCopy:** CLI for copy/sync operations between local paths and supported storage endpoints.
- **Lifecycle policy:** JSON rule with filters and actions, such as moving eligible block blobs to cooler tiers or deleting them after age thresholds.
- **Object replication:** Asynchronous policy between compatible source/destination accounts and containers; requires supported configuration and replication permissions/versioning prerequisites.
- **Network rules:** Firewalls/private endpoints still apply to management and data tools.
- **Cost signals:** Capacity, transactions, retrieval, transfer, versions/snapshots and destination copies.

## 4. Architecture / simple diagram
```text
Local files -- AzCopy/Storage Explorer --> Source storage account
                                             |
                                    lifecycle policy by age/access
                                             |
                                    Cool/Cold/Archive/delete

Source Blob container -- asynchronous object replication --> Destination account/container
```

## 5. How it works step-by-step
1. Authenticate to source and destination using identity or a carefully scoped credential.
2. Select copy versus sync semantics; preview/list files and validate destination path before transfer.
3. Transfer a small sample, inspect logs and compare names/counts/checksums where available.
4. Define lifecycle rules with filters and transition/delete actions; account for last-access tracking support, minimum-duration and early-deletion costs.
5. For object replication, meet account/versioning/permission requirements, configure source/destination policy and monitor replication status.
6. Test recovery and cleanup. Never assume replication copies deletes bidirectionally or preserves every property in all configurations.

## 6. Important Azure Portal settings
- **Lifecycle:** Storage account > **Data management > Lifecycle management** > **Add a rule**. Choose scope/filter and actions; validate each age threshold before saving.
- **Object replication:** Storage account > **Data management > Object replication**. Confirm prerequisites and destination/source authorization in the current Portal.
- **Networking:** Storage account > **Networking**. Confirm the machine running AzCopy/Storage Explorer can reach both endpoints.
- **Data protection:** Storage account > **Data protection**. Versioning/soft delete settings can affect lifecycle and replication support.
- **Storage Explorer:** sign in via Microsoft Entra and select the intended tenant/subscription/account.

⭐ Lifecycle policies act asynchronously and do not guarantee a precise transition time. Archive is offline; retrieval/rehydration and early deletion can cost money.

## 7. Azure CLI commands
Install AzCopy using Microsoft's current instructions. Azure CLI examples for lifecycle use a JSON policy file. Avoid SAS in shell history; identity-based auth needs correct data permissions.
```bash
az login
az account show --output table
az storage account list --output table
az storage container list --account-name '<account>' --auth-mode login --output table
az storage blob list --account-name '<account>' --container-name '<container>' \
  --auth-mode login --output table
```
AzCopy examples (identity-based login):
```bash
azcopy login
azcopy copy './sample-data' 'https://<account>.blob.core.windows.net/<container>' --recursive
azcopy copy 'https://<account>.blob.core.windows.net/<container>/sample.txt' './download/'
azcopy jobs list
azcopy jobs show '<job-id>'
```
The commands transfer data and may incur transaction/egress costs. Check current `azcopy copy --help`; do not use `sync --delete-destination` without a reviewed dry run and verified backup.

## 8. Hands-on lab with exact steps
**Prerequisites:** Authorized test account, AzCopy or Storage Explorer, Entra identity with minimum required data permission, small non-sensitive source files, approved budget. Use read-only Portal simulation if no account is available.

1. Create a disposable private container or use an authorized lab container. Record source/destination names.
2. Sign in with `azcopy login` or Storage Explorer Entra sign-in; verify tenant/account context.
3. Upload one tiny file with AzCopy `copy`; inspect output/job log and confirm object exists in Portal.
4. Download it to a separate temporary directory and compare content. Do not use destructive sync flags.
5. In Portal inspect **Lifecycle management** and design a rule for test-prefix blobs only. Use a retention threshold and action appropriate for the data; do not set immediate delete. Review without saving if uncertain.
6. Inspect object-replication prerequisites/policy on a training account. Do not create two accounts just for practice unless the cost is approved.
7. Delete test objects/container and temporary local copy. If disposable, remove the account/RG and review cost after data updates.

## 9. Real-world DevOps use case
A build pipeline uploads versioned artifacts with AzCopy using a federated workload identity. A lifecycle rule tiers old artifacts while a legal-retention tag excludes protected artifacts. A separate replication policy copies eligible blobs to another account for regional distribution. Monitoring detects failed transfers and replication lag; restore is tested independently.

## 10. Common troubleshooting scenarios
- **AzCopy 403:** Check identity login, Blob data role, scope, token tenant and storage firewall.
- **DNS/network timeout:** Check endpoint, private DNS, firewall, proxy and private endpoint path.
- **Transfer incomplete:** Inspect job logs/retries, source permissions, destination quota and network stability.
- **Sync removed destination files:** Understand source/destination comparison and destructive flags; restore from version/backup if configured.
- **Lifecycle rule not acting:** Check filters, blob type, last-modified/access age, policy evaluation delay, tier eligibility and account support.
- **Object replication pending:** Check policy state, versioning, source/destination permissions, compatibility and backlog/status.
- **Higher-than-expected bill:** Review transaction counts, retrieval, egress, extra replicas, retained versions and account redundancy.

## 11. Common mistakes
- Using AzCopy `sync` with deletion without a preview/backup.
- Using a long-lived account key/SAS when Entra login is supported.
- Assuming lifecycle rules execute exactly at the threshold or apply to every blob type.
- Moving data to Archive without considering rehydration or early deletion.
- Treating object replication as bidirectional sync, failover, or backup.
- Forgetting destination data adds capacity/transaction costs.

## 12. AZ-104 exam points ⭐
- Know when Storage Explorer versus AzCopy is suitable.
- Distinguish `copy` from `sync` and understand deletion risk.
- Lifecycle actions depend on filters, blob type, age/access conditions and service support.
- Object replication is asynchronous and prerequisite-dependent; check supported source/destination settings.
- Data transfer and replication can create transaction, egress and destination storage charges.
- Keep replication, backup, lifecycle retention and redundancy concepts distinct.

## 13. Interview questions + answers
1. **When use AzCopy?** Scripted high-throughput copy/sync for supported storage endpoints.
2. **Copy versus sync?** Copy transfers selected items; sync compares source/destination and may remove destination items depending on flags.
3. **How authenticate AzCopy?** Entra login/workload identity where supported, or scoped SAS when necessary.
4. **What does lifecycle management do?** Applies data-tiering/deletion actions based on rule filters and age/access criteria.
5. **Does a lifecycle transition happen exactly on schedule?** No; policy evaluation is asynchronous.
6. **What is object replication?** Asynchronous copy of eligible blobs between compatible storage accounts/containers.
7. **Is replication a backup?** No; it may copy unwanted changes/deletions depending on setup and does not replace recovery controls.
8. **Why use Storage Explorer?** GUI inspection and management of storage resources.
9. **What causes AzCopy 403?** Identity/data role, scope, wrong tenant, token or network rules.
10. **How make transfers safer?** Small test, preview, non-destructive copy first, logs/checksums, least privilege and verified cleanup.

## 14. AZ-104 practice questions + answers
1. **Need scripted bulk upload from local files.** AzCopy `copy` with identity auth where possible.
2. **Which command requires extra caution for destination deletion?** `sync` with delete-destination behavior.
3. **Transition old eligible blobs to cool tier.** Lifecycle rule with correct filters/actions.
4. **Lifecycle didn't transition every object.** Check blob type, filters, age, support, and asynchronous evaluation.
5. **Need second-account copies of eligible blobs.** Configure object replication after validating prerequisites.
6. **Does replication provide point-in-time recovery?** Not necessarily; use versioning/soft delete/backup as required.
7. **AzCopy gets 403 although user can create account.** Check Blob data-plane authorization.
8. **Archive data must be read now.** Rehydrate it or use a suitable online tier; consider cost/time.
9. **Replication increases storage charge. Why?** Destination stores another copy and may incur operations/transfer.
10. **Safest first sync run?** Preview/list scope, use a disposable destination, avoid delete flags, validate backup and logs.

## 15. Short revision notes
- Storage Explorer = GUI; AzCopy = scriptable transfer.
- Prefer identity; inspect logs; copy before attempting destructive sync.
- Lifecycle is rule/filter based and asynchronous; Archive requires rehydration.
- Object replication is async, prerequisite-bound, and not backup.
- Count destination capacity, operations, retrieval and network transfer in cost.

## Azure ↔ AWS Comparison
AzCopy/Storage Explorer are closest to AWS CLI/console transfer tools; Azure lifecycle management and object replication are comparable to S3 Lifecycle and Cross-Region Replication, with differing prerequisites and semantics.
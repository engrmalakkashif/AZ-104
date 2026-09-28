# Day 11 Quick Reference: Storage Operations

## AzCopy
```bash
azcopy login
azcopy copy './file.txt' 'https://<account>.blob.core.windows.net/<container>/file.txt'
azcopy jobs list
azcopy jobs show '<job-id>'
```
Prefer `copy` for initial practice. Understand `sync` comparison and deletion behavior before using it. Protect job logs and credentials.

## Portal locations
- Lifecycle rules: storage account > **Data management > Lifecycle management**.
- Object replication: storage account > **Data management > Object replication**.
- Network controls: storage account > **Networking**.

## Exam reminders
- Lifecycle rules filter by scope/prefix and operate asynchronously on eligible data.
- Archive is offline; rehydration takes time and may incur retrieval/early-deletion charges.
- Object replication is asynchronous, feature/prerequisite dependent and not a backup.
- Budget for transactions, destination capacity, egress, retrieval, versions and snapshots.
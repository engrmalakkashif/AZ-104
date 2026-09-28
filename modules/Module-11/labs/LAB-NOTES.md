# Day 11 Lab Notes: Storage Operations

## Prerequisites
- Days 7–9 storage concepts and authorized private test container.
- AzCopy installed or Storage Explorer; Entra login and minimum Blob data permissions.
- Small non-sensitive sample file; approved cost limit.

## Safety
Use `copy` before `sync`; do not use destination-delete flags on valuable data. Avoid SAS/key in history. Transfers, transactions, egress, Archive retrieval and replicated destination capacity may cost money. Lifecycle deletion/transition can be delayed and cannot be treated as an immediate switch.

## Portal paths
- Lifecycle: account > **Data management > Lifecycle management**.
- Replication: account > **Data management > Object replication**.
- Storage Explorer: sign in with Entra and confirm tenant/subscription before selecting resources.

## Transfer verification
Record source and destination names, object count/size, job ID/log, exit status, and one content comparison. Use a unique test prefix/container. Avoid recursive operations on broad production paths.

## Cleanup
Delete only test objects/prefixes you created. Remove temporary local files. Disable test lifecycle/replication rules if created. Review destination copies, versions, snapshots, and Cost Analysis after refresh.
# Day 10 Lab Notes: Azure Files

## Prerequisites
- Day 7 storage account and Day 9 identity/network concepts.
- Authorized storage account and permission to manage file shares.
- For an actual mount: compatible client, documented protocol, network path and authentication method.

## Cost and safety
Share capacity, tier/performance, redundancy, transactions, snapshots, data transfer and mounted VM compute may be billed. Do not provision a VM just to test a mount unless approved. Use an existing training account or Portal walkthrough if budget is uncertain. Never share account keys.

## Portal path
Storage account > **Data storage > File shares** > **+ File share**. Check tier, quota and protocol. Open the share > **Connect** for OS-specific mount instructions. Check **Data protection** for file-share soft delete/snapshots and **Networking** for endpoint controls.

## Protocol and authentication checklist
- Confirm SMB/NFS support for the selected account/share and region.
- Confirm client operating system and protocol version.
- Confirm DNS, endpoint, firewall/private access, port and route.
- Confirm identity/key method and share/file permissions.
- Separate control-plane permission to manage the account from data-plane permission to access file contents.

## Cleanup
Unmount the share; remove only test files/share/snapshot created for the lab; delete the disposable account/resource group if created; verify no VM, disk, snapshot, or retained share remains.
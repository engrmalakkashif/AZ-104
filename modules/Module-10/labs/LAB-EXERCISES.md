# Day 10 Lab Exercises: Azure Files

## Exercise 10.1: Compare file and object storage
**Time:** 15 minutes | **Cost:** None
For a shared SMB application directory, unstructured web images, Linux NFS workload, and archive of infrequently retrieved documents, choose Azure Files or Blob and explain protocol/access semantics.

## Exercise 10.2: Inspect or create a small share
**Time:** 30 minutes | **Cost:** May incur charges
**Prerequisites:** Authorized account and reviewed regional pricing. If uncertain, do the read-only path.
1. Portal > **Storage accounts** > authorized lab account > **File shares**.
2. Inspect an existing share's quota, tier, protocol and connect instructions, or create a tiny-quota test share only if approved.
3. Record the SMB/NFS options and the required authentication/network conditions.
4. Do not copy account keys into notes. Do not create a VM solely for mounting without budget approval.
5. Delete the test share/files and any snapshot. Confirm no retained resources remain.

## Exercise 10.3: Mount-troubleshooting tabletop
Given a mount failure, check in order: client support, DNS, endpoint, route, firewall/NSG, protocol/port, authentication, authorization/permissions, mount syntax. For each item, name one Portal blade or client command that could provide evidence.

## Exercise 10.4: Recovery decision
Explain what Azure Files snapshots and soft delete can recover, their retention/cost implications, and why neither should be assumed enabled by default.

## Success checklist
- [ ] Select Files for file protocol access and Blob for object access.
- [ ] Identify protocol, identity and network prerequisites.
- [ ] Verify quota/tier without assuming quota reserves capacity.
- [ ] Clean up share, snapshots and optional compute.
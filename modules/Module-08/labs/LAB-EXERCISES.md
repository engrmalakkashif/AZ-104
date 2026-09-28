# Day 8 Lab Exercises: Blob Storage

## Exercise 8.1: Model blob types and tiers
**Time:** 20 minutes | **Cost:** None
For a profile photo, append-oriented diagnostic log, disk-like random-I/O workload, current project file, and long-term legal archive, choose a blob type/tier or explain why another storage service is a better fit. Note archive rehydration and minimum-duration considerations.

## Exercise 8.2: Create a private container and round-trip an object
**Time:** 30 minutes | **Cost:** Storage and operations may be billed
**Prerequisites:** Approved disposable account/permissions, CLI signed in, and a tiny test file.
1. Portal > **Storage accounts** > account > **Containers** > **+ Container**.
2. Create `lab-private` with anonymous access set to private/off.
3. Upload a small non-sensitive text file and inspect properties.
4. Download it and compare the bytes/content to the original.
5. Alternative without deployment: use an existing lab account or map each CLI action to the Portal blades without clicking **Create**.
6. Delete blob/container; if the account is disposable, delete its RG and verify cleanup.

CLI identity-based shape:
```bash
az storage container create --account-name '<account>' --name lab-private \
  --auth-mode login --public-access off
az storage blob upload --account-name '<account>' --container-name lab-private \
  --name sample.txt --file ./sample.txt --auth-mode login
az storage blob download --account-name '<account>' --container-name lab-private \
  --name sample.txt --file ./sample.downloaded.txt --auth-mode login
```

## Exercise 8.3: Diagnose a 403
Given `AuthorizationPermissionMismatch`, check identity, Blob data role, assignment scope, propagation, container/blob name, and network rules. Explain why making the container public is not an acceptable default fix.

## Completion checklist
- [ ] Correct hierarchy and blob type/tier choice explained.
- [ ] Container remained private.
- [ ] Upload/download verified.
- [ ] Data role distinguished from management-plane role.
- [ ] Test data and any disposable resources cleaned up.
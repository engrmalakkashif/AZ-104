# Day 9 Lab Exercises: Blob Security and Protection

## Exercise 9.1: Select an access method
For each scenario, choose Entra/RBAC, user delegation SAS, service SAS, account SAS, or shared key and explain scope, duration and risk: application workload, one-time vendor download, administrator rotation, broad migration tool. Prefer least privilege and explain alternatives.

## Exercise 9.2: Inspect recovery settings
**Time:** 20 minutes | **Cost:** None if read-only
1. Portal > storage account > **Data protection**.
2. Record blob soft-delete, container soft-delete, versioning and point-in-time restore status/retention.
3. Identify prerequisites and whether the current account supports the setting.
4. Explain which feature helps with deleted container, deleted blob, and overwritten blob.
Do not alter an account you do not own.

## Exercise 9.3: Design a least-privilege SAS (do not expose secret)
**Time:** 20 minutes | **Cost:** None if wizard is inspected only
Create a paper configuration for read-only access to one test blob for one hour, HTTPS-only. Record scope/permissions/time and revocation strategy, but do not generate or copy the token. Explain why List/Write are omitted and why stored policy revocation has limits.

## Exercise 9.4: Recovery tabletop
For accidental deletion, malicious overwrite, regional outage and credential leak, choose an appropriate prevention/recovery action. State which settings must have been enabled before the event and what may still be lost.

## Verification checklist
- [ ] Separate identity, authorization and network controls.
- [ ] Correctly explain three SAS types and stored access policy limitation.
- [ ] Distinguish soft delete, version, snapshot and geo-replication.
- [ ] No live credential recorded or shared.
- [ ] Remove test data/permissions and confirm cleanup.
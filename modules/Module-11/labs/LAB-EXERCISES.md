# Day 11 Lab Exercises: Storage Operations

## Exercise 11.1: Small AzCopy round-trip
**Time:** 25 minutes | **Cost:** Small storage/transactions/transfer may be billed
1. Create/use an approved private test container and a small text file.
2. Run `azcopy login`; verify correct tenant.
3. Use `azcopy copy` to upload to a unique test path.
4. Review job output/log and verify object via Portal or `az storage blob list --auth-mode login`.
5. Download with `azcopy copy` to a separate local path and compare content.
6. Do not use `sync` or delete flags for this exercise. Remove test object/container and local copies.

## Exercise 11.2: Lifecycle rule design
**Time:** 20 minutes | **Cost:** None if design-only
Design a rule applying only to a prefix named `training/`: transition eligible block blobs from Hot to a cooler tier after a suitable age and delete only after an explicitly selected retention period. Identify the effect on archived retrieval, minimum duration, versions/snapshots and legal holds. Inspect the Portal rule builder but cancel rather than save if scope is uncertain.

## Exercise 11.3: Object replication readiness
**Time:** 20 minutes | **Cost:** None if read-only
On paper or in a training account, list prerequisites to check: account compatibility, versioning/protection configuration, container mapping, source/destination permissions, regional support and monitoring. Explain why replication is asynchronous and is not an independent backup.

## Exercise 11.4: Troubleshoot a failed transfer
For each case, identify first checks: HTTP 403, DNS timeout, partial job, wrong destination path, lifecycle action not occurring, replication pending. Include evidence to capture without exposing secrets.

## Completion checklist
- [ ] Transfer a small object with identity auth or simulate it.
- [ ] Inspect logs and validate content.
- [ ] Explain copy versus sync deletion behavior.
- [ ] Design lifecycle filters and actions safely.
- [ ] Describe replication prerequisites and cost.
- [ ] Remove all temporary data/resources.
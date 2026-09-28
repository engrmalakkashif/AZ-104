# Day 9: Blob Security and Data Protection

**Exam domain:** Implement and manage storage | **Prerequisites:** Days 7–8, identity and authorization basics

## 1. What is it?
Blob security controls who can reach an account and what an identity or token can do. Data-protection features preserve recoverable states after deletion or overwrite. **Authentication** establishes an identity/token; **authorization** determines permitted operations; **network controls** determine whether the endpoint is reachable.

## 2. Why is it needed?
Storage contains sensitive and operationally important data. Use least-privilege identity access where possible, a narrowly scoped SAS when delegated access is needed, and recovery controls matched to retention objectives. A key or SAS is a bearer secret; leaked credentials can expose data. Protection features consume storage and do not replace a tested backup strategy.

## 3. Key components
- **Microsoft Entra ID:** Identity authentication; grant a Blob data-plane role for data operations.
- **Shared key:** Account key authenticates broad shared-key operations; rotate/restrict it and disable shared-key authorization only after confirming workload compatibility.
- **SAS:** Signed, time-bounded, permission/scope-constrained access. Types: user delegation SAS (Entra-authorized, Blob), service SAS (specific service/resource; can use a stored access policy in supported scenarios), account SAS (one or more services/resource types). Prefer user delegation SAS where supported.
- **Stored access policy:** Server-side policy that can define/revoke parameters for supported service SAS; not used for user-delegation/account SAS.
- **Blob soft delete:** Recover deleted blobs for a configured retention period.
- **Container soft delete:** Recover deleted containers during retention.
- **Versioning:** Retain prior blob versions after writes/overwrites (supported scenarios).
- **Snapshot:** Point-in-time read-only blob state; not automatically a full-account backup.
- **Point-in-time restore:** Restore a block-blob account/container to an earlier time when prerequisites and supported settings are configured.
- **Immutability/legal hold:** WORM protections for supported compliance scenarios; can prevent deletion, so test cautiously.

## 4. Architecture / simple diagram
```text
Client -- Entra token / SAS / shared key --> Network gate --> Blob endpoint
                                              |               |
                                              +-- firewall    +-- RBAC/SAS permission check
                                                              |
                                             blob data + versions/snapshots/soft delete
```

## 5. How it works step-by-step
1. Client resolves and reaches the endpoint through allowed public/private networking.
2. Client presents an Entra token, SAS, or shared-key authorization.
3. Azure validates the credential and requested scope/permissions/time window.
4. Data-plane authorization and account/container rules determine whether the request succeeds.
5. Soft delete/versioning/snapshots capture recoverable states only if configured before the incident and within retention.
6. Administrators test recovery, rotate/revoke credentials, audit access, and remove obsolete retained data according to policy.

## 6. Important Azure Portal settings
Portal > **Storage accounts** > account > **Security + networking > Access keys** to inspect/rotate keys; never copy them into shared notes. **Configuration** includes shared-key and anonymous-access controls where supported. **Data storage > Containers** > container > **Generate SAS** (labels vary) to scope resource, permissions, start/expiry and allowed protocols. Prefer Entra/user-delegation SAS if available. **Data management > Data protection** configures blob/container soft delete, versioning, snapshots and restore options. Review retention/cost and account feature prerequisites.

⭐ SAS grants only the encoded scope/permissions until expiry or revocation where supported. A stored access policy can revoke associated service SAS, but not all SAS types. Keep expiry short, HTTPS-only, and permissions minimal.

## 7. Azure CLI commands
Read-only checks:
```bash
az storage account show --name '<account>' --resource-group '<rg>' \
  --query '{allowSharedKeyAccess:allowSharedKeyAccess,httpsOnly:enableHttpsTrafficOnly}' --output json
az storage blob list --account-name '<account>' --container-name '<container>' \
  --auth-mode login --output table
az storage blob service-properties show --account-name '<account>' --auth-mode login
```
SAS generation can print a live secret. Do not run it in a shared terminal, log it, commit it, or paste it in chat. If practicing, use a short expiry, HTTPS-only, minimum permissions, a test object, and a private shell. Inspect exact flags using `az storage blob generate-sas --help` rather than copying old syntax.

## 8. Hands-on lab with exact steps
**Prerequisites:** Authorized disposable storage account, Blob data permissions, and an approved cost limit. Use a non-sensitive test blob. **No-deployment option:** inspect settings in a training account and complete the permission matrix below.

1. In Portal search **Storage accounts** > disposable account > **Data protection**. Record enabled soft-delete, versioning and snapshot settings and retention days. Do not change production.
2. Open **Containers** > test private container > upload a tiny sample blob.
3. Inspect **Access control (IAM)** and identify which data role would allow read versus write; do not grant broader roles for convenience.
4. Open the SAS generation blade. Select the smallest resource scope, read-only permission, HTTPS-only, and short expiry. Do not copy the token to a file, notes, source control or chat. If unable to protect the generated credential, cancel and do the no-deployment walkthrough.
5. Test only against the sample blob in a private terminal; verify read succeeds and write/list are not granted. Revoke/expire access and remove the sample data.
6. Delete disposable resources. Confirm soft-deleted objects/versions are also removed or have known retention/cost behavior.

**Permission matrix:** identity, object scope, allowed operation, network path, expiration/revocation method. Record policy settings, never the actual secret.

## 9. Real-world DevOps use case
A CI job uses workload identity to upload release artifacts with a scoped Blob data role. A vendor receives a short-lived read-only user-delegation SAS to one object. Storage events and audit logs are monitored; soft delete/versioning support operational recovery, while immutable retention is applied only to approved records.

## 10. Common troubleshooting scenarios
- **403 AuthorizationPermissionMismatch:** Check identity, Blob data role, scope, propagation, SAS permissions and resource path.
- **SAS AuthenticationFailed:** Check start/expiry time, clock skew, signature, HTTPS requirement, resource path and key validity.
- **SAS works for read but not list:** It may not include List permission or the scope may be one blob, not container.
- **Cannot revoke token:** Determine SAS type; stored access policy does not revoke user-delegation/account SAS. Rotate key only with impact analysis if signed by that key.
- **Deleted blob unavailable:** Confirm soft delete/versioning/snapshot were enabled, retention remains, correct version/resource selected, and required RBAC is present.
- **Restore option unavailable:** Check account type, blob type, region/features and prerequisites; not every protection feature supports every configuration.
- **Shared key disabled breaks app:** Identify dependencies, migrate to Entra/SAS, test, then disable under change control.

## 11. Common mistakes
- Treating SAS as harmless because it has an expiry; anyone holding it can use its grants.
- Granting read/write/list when only read is required.
- Giving a SAS long lifetime, broad account scope, or HTTP access.
- Confusing a stored access policy with universal SAS revocation.
- Assuming soft delete/versioning are enabled by default or have no cost.
- Treating replication, snapshots, or soft delete alone as comprehensive backup.

## 12. AZ-104 exam points ⭐
- Choose between Entra RBAC, shared keys and SAS based on scope, lifecycle and least privilege.
- Know user delegation, service and account SAS differences; understand stored policy limits.
- SAS controls resource/service, permissions, time, protocol and sometimes IP range.
- Distinguish blob soft delete, container soft delete, versioning, snapshots and point-in-time restore.
- Recoverability depends on feature enablement before deletion and retention windows.
- ⭐ Credentials authorize requests; firewall/private endpoint controls network reachability. Both must permit access.

## 13. Interview questions + answers
1. **Why prefer Entra ID over shared key?** Identity-based, auditable and more granular access without distributing account-wide secrets.
2. **What is a SAS?** Signed delegated access with scope, permissions, time and protocol constraints.
3. **What is a user delegation SAS?** Blob SAS signed using an Entra-authorized user delegation key.
4. **What can a stored access policy do?** Control/revoke associated service SAS parameters in supported services.
5. **Can it revoke every SAS?** No; not user-delegation or account SAS.
6. **Soft delete versus versioning?** Soft delete retains deleted objects; versioning records prior blob states on writes.
7. **Snapshot versus version?** Snapshot is a point-in-time read-only copy; versions are managed prior states when versioning is enabled.
8. **How reduce SAS risk?** Minimum scope/permissions, short validity, HTTPS, protected secret handling, and revocation plan.
9. **Why might a valid token still get blocked?** Network rules, DNS/private endpoint, account settings or authorization scope.
10. **How design recovery?** Select supported protections/retention, monitor, test restore and maintain independent backup/DR as required.

## 14. AZ-104 practice questions + answers
1. **Grant vendor read to one blob for one hour.** Use a narrowly scoped read-only short-lived SAS, preferably user delegation where supported.
2. **Need role-based access to blobs without keys.** Entra identity plus a suitable Blob data role.
3. **Need revoke a service SAS centrally.** Use a stored access policy where supported and SAS was associated with it.
4. **Can stored policy revoke a user delegation SAS?** No.
5. **Need recover overwritten content.** Versioning or another supported point-in-time protection may help if enabled beforehand.
6. **Need recover deleted container.** Container soft delete if enabled and within retention.
7. **Blob list returns 403 but blob read works.** Check List permission and SAS/RBAC scope.
8. **SAS expired according to client but works until a future date.** Check UTC time, start/expiry values and clock skew; revoke via supported mechanism if necessary.
9. **Credential is correct but endpoint blocked from office network.** Review storage firewall, public network access, private endpoint and DNS.
10. **Is GRS an alternative to soft delete?** No; replication and logical deletion recovery address different failure modes.

## 15. Short revision notes
- Entra identity/RBAC preferred; SAS is a bearer secret; shared key is broad.
- Short, least-privilege, HTTPS-only SAS; stored policy revokes associated service SAS only.
- Soft delete = deleted item retention; versioning = prior blob states; snapshot = point-in-time copy.
- Configure before incident; test restore; account for retention charges.

## Azure ↔ AWS Comparison
Entra/RBAC and SAS are broadly comparable to IAM roles/policies and S3 presigned URLs; Azure SAS is not identical to an AWS presigned URL or bucket policy.
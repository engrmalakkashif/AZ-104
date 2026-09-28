# Day 7: Azure Storage Accounts and Redundancy

**Exam domain:** Implement and manage storage | **Level:** Beginner to intermediate
**Prerequisites:** Resource groups, regions, basic availability and durability concepts

## 1. What is it?
An Azure Storage account is a globally unique namespace and management boundary for Azure Storage data services. It exposes endpoints for services such as Blob Storage, Azure Files, queues, and tables. Account settings determine supported services, performance, replication, security, networking, and billing behavior.

## 2. Why is it needed?
The account provides a durable, scalable place for application data and centralizes access and configuration. Select an account based on data service, workload, performance, recovery, and network requirements. It is not itself a database or backup plan. Stored capacity, operations, transfer, redundancy, and optional features may be billed.

## 3. Key components
- **Account kind:** General-purpose v2 (StorageV2) is the common account for current general storage scenarios; specialized premium account types target specific workloads.
- **Service endpoints:** Blob, File, Queue, and Table endpoints. The account name must be globally unique.
- **Performance:** Standard or premium performance; supported services and features depend on account type.
- **Redundancy:** LRS, ZRS, GRS, GZRS and read-access variants RA-GRS/RA-GZRS.
- **Access tier:** Account-level default for applicable Blob scenarios; individual blobs can have their own tier.
- **Security/network:** Microsoft Entra authorization, shared key, SAS, firewall/network rules, private endpoints, encryption, secure transfer and TLS settings.
- **Data protection:** Soft delete, versioning, point-in-time restore and other options depend on service/account support and incur storage costs.

## 4. Architecture / simple diagram
```text
Application / operator
			 | HTTPS + identity/SAS/key
			 v
Storage account (unique namespace, region, SKU, redundancy)
	 +--- Blob endpoint  -> containers and blobs
	 +--- File endpoint  -> shares and files
	 +--- Queue endpoint -> messages
	 +--- Table endpoint -> entities
			 |
			 +--- primary region copies (LRS/ZRS)
			 +--- optional secondary region copies (GRS/GZRS)
```

## 5. How it works step-by-step
1. Choose a subscription, resource group, region, account name, account kind, and performance tier.
2. Select redundancy that matches availability and recovery objectives; check regional/service support.
3. Configure secure transfer, minimum TLS, public network access, firewall rules, and identity/access model.
4. Create a container/share or other data resource and assign data-plane permissions as needed.
5. Upload or access data through a service endpoint; Azure replicates data according to the selected redundancy option.
6. Monitor capacity, transactions, replication health, and cost. Configure data protection separately.

## 6. Important Azure Portal settings
Portal > **Storage accounts** > **Create**. Review **Basics** (subscription, RG, account name, region, performance, redundancy), **Advanced** (security options and hierarchical namespace where relevant), **Networking** (public access/firewall/private endpoints), **Data protection**, and **Encryption** tabs before **Review + create**. On an existing account inspect **Data management > Redundancy** and **Configuration**.

⭐ Redundancy is selected when creating the account and can have conversion constraints. RA-* gives read access to the secondary endpoint; GRS/GZRS alone do not. ZRS spans availability zones in one region; GRS/GZRS add asynchronous geo-replication to a paired/selected secondary region.

## 7. Azure CLI commands
Verify subscription first. Resource creation may incur charges.
```bash
az login
az account show --output table
RG="az104-storage-lab"
LOCATION="eastus"
ACCOUNT="az104store$RANDOM"  # lowercase, globally unique, 3-24 characters

az group create --name "$RG" --location "$LOCATION"
az storage account create --name "$ACCOUNT" --resource-group "$RG" \
	--location "$LOCATION" --sku Standard_LRS --kind StorageV2 \
	--https-only true --min-tls-version TLS1_2
az storage account show --name "$ACCOUNT" --resource-group "$RG" \
	--query '{name:name,kind:kind,sku:sku.name,location:location,httpsOnly:enableHttpsTrafficOnly}' \
	--output table
az storage account list --resource-group "$RG" --output table
az storage account delete --name "$ACCOUNT" --resource-group "$RG" --yes
az group delete --name "$RG" --yes --no-wait
```
Use `az storage account create --help` for current SKU flags and region availability. Never put keys or SAS tokens in shell history.

## 8. Hands-on lab with exact steps
**Prerequisites:** Authorized subscription, permission to create resource groups/storage accounts, Azure Portal or CLI, and an approved spend limit. Free-tier eligibility varies. **No-deployment option:** use the Portal wizard and compare settings without selecting **Create**.

1. Create a dedicated resource group, e.g. `az104-storage-lab`.
2. In Portal search **Storage accounts** > **Create**. Choose a unique lowercase name, nearby region, StorageV2, and Standard performance.
3. Compare LRS, ZRS, GRS, GZRS, RA-GRS and RA-GZRS. Record failure domain, secondary-region behavior, read access and relative cost. Select the lowest suitable option only after checking current pricing.
4. On **Networking**, keep public access restricted for the exercise. On **Advanced**, require secure transfer and TLS 1.2 or higher where configurable.
5. Inspect **Data protection** without enabling long retentions on production. Review **Review + create** validation, then create only if authorized and cost-approved.
6. Verify account kind, SKU, region, and endpoints in **Overview** and **Redundancy**.
7. Delete the disposable resource group immediately after practice; check for remaining resources and review Cost Management after billing data updates.

## 9. Real-world DevOps use case
A deployment pipeline stores build artifacts in Blob Storage and release manifests in a storage account. The account uses a region/redundancy choice matched to recovery objectives, private access where required, managed identity for pipeline authentication, and lifecycle rules for old artifacts. Infrastructure is deployed repeatably using Bicep/ARM and monitored for capacity and transaction anomalies.

## 10. Common troubleshooting scenarios
- **Name unavailable:** account names are globally unique; choose a new lowercase name of valid length.
- **SKU unavailable:** check region, account kind, feature, and quota support.
- **Firewall blocks client:** inspect selected network rules, client egress IP/VNet, private DNS and endpoint.
- **HTTPS/authorization fails:** check secure transfer, TLS/client support, identity role scope, SAS validity, and clock skew.
- **Secondary data appears stale:** geo-replication is asynchronous; inspect replication status and do not assume zero RPO.
- **Cannot read secondary endpoint:** confirm RA-GRS/RA-GZRS rather than GRS/GZRS and use the secondary endpoint.
- **Unexpected charges:** review stored capacity, operations, redundancy, snapshots, transfer and data protection.

## 11. Common mistakes
- Treating redundancy as backup; deletion/corruption can replicate.
- Assuming GRS/GZRS allows secondary reads without RA.
- Assuming every SKU and feature is available in every region.
- Exposing public network access for convenience.
- Confusing management-plane roles with data-plane access.
- Treating a budget alert as an automatic cap.

## 12. AZ-104 exam points ⭐
- Know each redundancy option and whether it is local, zone, or geo redundant.
- RA-GRS/RA-GZRS permit secondary read access; GRS/GZRS do not.
- ZRS is synchronous zone replication within one region; geo-replication is asynchronous.
- Choose redundancy from durability, availability, regional recovery, read-access, and cost requirements.
- Know account kind/performance constraints and storage service endpoints.
- Security settings and data protection are separate: encryption at rest is not authorization; replication is not backup.

## 13. Interview questions + answers
1. **What does a storage account provide?** Namespace and account-level configuration for Azure Storage services.
2. **What is LRS?** Multiple copies in a single datacenter/facility within one region, according to the service design.
3. **What is ZRS?** Synchronous replication across availability zones in one region.
4. **What distinguishes GRS from RA-GRS?** RA-GRS enables reads from the secondary endpoint.
5. **Is geo-replication synchronous?** No, it is asynchronous and may have replication lag.
6. **Is redundancy a backup?** No; logical deletion/corruption may replicate; use recovery features/backups too.
7. **Why choose StorageV2?** It is the general-purpose v2 account for common current storage services and features.
8. **How restrict account access?** Combine identity-based least privilege with network restrictions/private endpoints and secure transport.
9. **What is a data-plane role?** A permission to operate on data, such as reading blobs, rather than managing the account resource.
10. **How choose redundancy?** Match failure scope, read-access needs, recovery objectives, region support, and cost.

## 14. AZ-104 practice questions + answers
1. **Need zone resilience but data must remain in one region.** Choose ZRS if supported; it replicates across zones in-region.
2. **Need to read from secondary during primary outage.** Select an RA redundancy option and use the secondary endpoint.
3. **Need geo-replication but no secondary reads.** GRS or GZRS, selected by zone-resilience requirement.
4. **Need zone and geo redundancy.** GZRS; RA-GZRS adds secondary read access.
5. **Does GRS guarantee synchronous writes to secondary?** No; geo replication is asynchronous.
6. **Data deleted accidentally with LRS. Is it recoverable automatically?** Not necessarily; configure soft delete/versioning/backup as applicable.
7. **Storage account name contains uppercase letters. Valid?** No; account names follow lowercase and length rules.
8. **Client can manage account but cannot download blob. Likely issue?** Missing data-plane authorization or storage network/access restriction.
9. **Need general-purpose Blob, Files, Queue, and Table services.** Use an eligible StorageV2 account and verify feature/SKU support.
10. **Cheapest redundancy should always be selected?** No; choose the lowest cost option that meets availability and recovery requirements.

## 15. Short revision notes
- Storage account = namespace/config boundary; StorageV2 is common general-purpose choice.
- LRS local; ZRS zones; GRS geo; GZRS zones + geo; RA variants permit secondary reads.
- Geo-replication is asynchronous; do not treat replication as backup.
- Check regional SKU support, network rules, identity/data-plane permissions, TLS, and cost.

## Azure ↔ AWS Comparison
Azure Storage accounts are closest to AWS storage service boundaries such as S3, EFS, SQS, and DynamoDB, but one Azure account can expose several storage services.

# Day 7 Lab Exercises: Storage Accounts

Complete in sequence. Do not provision an account unless authorized and cost-approved.

## Exercise 7.1: Compare redundancy options
**Time:** 25 minutes | **Cost:** None (diagram/table exercise)

For LRS, ZRS, GRS, RA-GRS, GZRS, and RA-GZRS, write down replication scope, secondary read capability, whether replication is synchronous locally or asynchronous across regions, and one suitable scenario. Verify the table against current Microsoft Learn documentation.

**Success criteria:** You can choose ZRS for zone resilience in one region, GRS/GZRS for geo-replication, and RA variants when secondary reads are required.

## Exercise 7.2: Inspect the storage-account wizard
**Time:** 25 minutes | **Cost:** None if you cancel before creation

1. Portal > **Storage accounts** > **Create**.
2. Choose a valid unique-style name (do not create until approved), region, StorageV2, and Standard.
3. Compare redundancy options and note unavailable choices.
4. Inspect **Advanced**, **Networking**, **Data protection**, and **Encryption**. Record secure transfer, TLS, public access and protection controls.
5. Stop at **Review + create** and cancel. Do not create a resource for this exercise.

## Exercise 7.3: Optional disposable account deployment
**Time:** 20–30 minutes | **Cost:** May incur charges

Only with permission and budget approval, follow the Azure CLI example in [Day 7 theory](../content/README.md), using a unique account name and disposable group. Verify SKU, region, kind, and HTTPS/TLS settings. Delete the resource group immediately afterward.

## Exercise 7.4: Scenario check
1. Requirement: zone protection, same region, secondary reads not needed. Choose a suitable option and explain.
2. Requirement: copy to another region, read secondary during primary outage. Choose a suitable option and explain.
3. Requirement: accidental blob deletion protection. Explain why redundancy alone is insufficient and name a data-protection feature to investigate.

**Cleanup checklist:** Resource group deleted; no account, container, snapshot or test data remains; any temporary role assignment removed; cost checked after billing data refreshes.
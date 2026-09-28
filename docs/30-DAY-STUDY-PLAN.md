# AZ-104 Microsoft Azure Administrator: 30-Day Course

> **Goal:** Build practical Azure administration skills and prepare for the AZ-104 exam through progressive study, low-cost labs, troubleshooting, and exam practice.
>
> **Scope:** Azure services tested by AZ-104. AWS appears only in the short comparison at the end.

## How to use this course

Work through one day at a time. Each day combines concepts, Portal exploration, Azure CLI practice, a lab, troubleshooting, and review. The linked module folders contain supporting notes and command references; verify their links and service details as the course materials are refreshed.

### Daily study rhythm

| Activity | Standard day | Short day |
|---|---:|---:|
| Recall and revision | 1 hour | 30 min |
| New concepts | 2 hours | 30 min |
| Hands-on lab | 2 hours | 60 min |
| Practice questions | 1 hour | 30 min |
| Notes and troubleshooting | 1 hour | 30 min |

The standard rhythm totals seven hours. If that is too much, use the short-day rhythm and spread a day across multiple sessions. Learn the concept before the lab; do not rush through chargeable resources to meet a calendar target.

## Before the first lab

- Use a personal or training Azure subscription where you have permission to create and delete resources. A free account is not a guarantee that every service or configuration is free.
- Set a spending alert in Cost Management, but remember that a budget alerts you; it does not automatically stop all spending.
- Use a unique resource-group name such as `az104-lab-<initials>-<date>` and tag resources with `Purpose=AZ104-Lab`.
- Check regional availability, quotas, and current pricing before deployment. Prefer free, student, sandbox, or lowest eligible tiers where available.
- Avoid public inbound access unless a task explicitly requires it. Restrict SSH/RDP to your current IP and remove the rule after the test.
- Delete lab resources when finished. Review the resource group after deletion; disks, snapshots, public IPs, Log Analytics ingestion, backups, and registries can incur separate charges.
- For Microsoft Entra ID labs, use a tenant where you are authorized to manage users. Do not invite real external users or assign paid licenses for practice.
- Azure Portal labels can change. Follow the service blade and setting names if navigation labels differ.

## 30-day schedule

### Week 1: Identities and governance

| Day | Focus | Learn and practice | Lab outcome |
|---|---|---|---|
| 1 | Microsoft Entra ID foundations | Tenant, directory, users, groups, cloud-only versus hybrid identities, guest users, authentication versus authorization | Inspect a tenant; create test users and a security group only where permitted |
| 2 | Users, groups, licensing, SSPR | User and group properties, assigned and dynamic membership, direct and group-based licensing, usage location, SSPR and authentication methods | Build a test team group and review SSPR configuration; do not purchase licenses |
| 3 | Azure RBAC | Security principals, role definitions, assignments, scopes, Owner, Contributor, Reader, User Access Administrator | Assign least-privilege roles to a lab resource group and inspect effective access |
| 4 | Azure Policy | Definitions, assignments, initiatives, parameters, exemptions, compliance, effects including Audit, Deny, Modify, Append, and DeployIfNotExists | Audit or deny a noncompliant location in a disposable resource group; remove the assignment afterward |
| 5 | Resource organization and protection | Management groups, subscriptions, resource groups, tags, CanNotDelete and ReadOnly locks | Tag lab resources and test a lock on a disposable resource; remove it before cleanup |
| 6 | Cost Management and domain review | Cost analysis, budgets, alerts, Azure Advisor, domain 1 review | Create a budget if supported; review cost and complete 30–40 identity/governance questions |

### Week 2: Storage

| Day | Focus | Learn and practice | Lab outcome |
|---|---|---|---|
| 7 | Storage accounts | Account types, performance, endpoints, encryption, network access, LRS/ZRS/GRS/GZRS and read-access variants | Inspect or create one storage account using the lowest suitable option; check regional pricing |
| 8 | Blob Storage | Accounts, containers, block/append/page blobs, Hot/Cool/Cold/Archive tiers, upload and download | Upload a small non-sensitive file, inspect properties, then delete it |
| 9 | Blob security and protection | Access keys, SAS, stored access policies, Microsoft Entra authorization, soft delete, versions, snapshots | Create a short-lived, least-privilege SAS; test access and revoke/expire it |
| 10 | Azure Files | File shares, SMB/NFS, identity-based access, snapshots, soft delete, mounting concepts | Create a small share only if pricing is acceptable; otherwise complete the configuration walkthrough without provisioning |
| 11 | Storage operations and review | Storage Explorer, AzCopy, lifecycle rules, object replication, network restrictions | Transfer a small test object and create/review a lifecycle policy; complete 30–40 questions |

### Week 3: Compute

| Day | Focus | Learn and practice | Lab outcome |
|---|---|---|---|
| 12 | Virtual machines | Images, sizes, disks, NICs, public/private IPs, NSGs, VM extensions and deployment options | Create a small Linux VM only when eligible pricing and access are confirmed; otherwise inspect a deployment template |
| 13 | Managed disks and encryption | Disk SKUs, performance limits, snapshots, encryption at host, disk attachment and guest formatting | Practice disk concepts with a disposable disk or a diagram/template; delete snapshots and disks afterward |
| 14 | Availability and scale | Availability Zones, availability sets, fault/update domains, VM Scale Sets, autoscale | Compare deployment options; VMSS hands-on deployment is optional and chargeable |
| 15 | ARM templates | Declarative deployments, parameters, variables, resources, outputs, dependencies, deployment modes | Validate and deploy a minimal template in a disposable resource group, then remove resources |
| 16 | Bicep | Bicep syntax, parameters, modules, outputs, dependencies, `what-if`, build/decompile | Build and validate a Bicep template; deploy only if the resulting resource is low-cost |
| 17 | Azure containers | ACR, repositories, tags, ACI, Container Apps, ingress, revisions, scaling | Run a local container workflow or a short-lived Azure deployment; registry storage and running compute may be billed |
| 18 | App Service and compute review | Plans, scaling, deployment slots, custom domains, TLS, backup, networking | Compare tiers and inspect slot configuration; use a local or lowest-cost deployment and delete the app/plan |

### Week 4: Virtual networking

| Day | Focus | Learn and practice | Lab outcome |
|---|---|---|---|
| 19 | VNets and subnets | Address spaces, subnet planning, private/public IPs, NICs, IP allocation | Design a VNet and three non-overlapping subnets on paper or in a disposable deployment |
| 20 | NSGs and ASGs | Inbound/outbound rules, priority, default rules, effective security rules, ASG references | Create a restrictive rule in a lab and verify the effective rules; remove it afterward |
| 21 | Peering and routing | Regional/global peering, route tables, UDRs, next hop, system routes | Diagram two VNets and inspect route behavior; deploy only if needed for the exercise |
| 22 | Service and private endpoints | Service endpoint versus private endpoint, private IP, private DNS, PaaS access | Trace DNS and access flow for a Storage private endpoint; live endpoint resources may incur charges |
| 23 | DNS and load balancing | Public/private DNS zones, records, Load Balancer frontend, backend pool, probes, rules | Configure or diagram a basic probe and rule; avoid multi-VM deployments unless budgeted |

### Week 5: Monitoring and maintenance

| Day | Focus | Learn and practice | Lab outcome |
|---|---|---|---|
| 24 | Azure Monitor | Metrics, logs, Activity Log, diagnostic settings, Log Analytics workspaces, KQL basics | Inspect platform metrics and Activity Log; enable ingestion only after checking retention and pricing |
| 25 | Alerts and insights | Metric/log/activity alerts, action groups, alert processing rules, VM/Storage/Network insights | Build an alert rule in design mode or use a short test; email/SMS and log ingestion may have costs/limits |
| 26 | Network Watcher | Connection troubleshoot, IP flow verify, NSG diagnostics, topology, Connection Monitor | Diagnose a simulated blocked flow or use Network Watcher tools on a small lab network |
| 27 | Backup and Site Recovery | Recovery Services vault, Backup vault, policies, restore, replication, failover/failback | Compare backup and disaster recovery flows; protect a real VM only after reviewing retention and storage charges |

### Final revision

| Day | Focus | Work products |
|---|---|---|
| 28 | Integrated Azure architecture lab | Draw an end-to-end design connecting identity, RBAC, policy, VNet, compute, private access to storage, monitoring, and backup. Implement only the components that fit your budget. |
| 29 | Full-domain revision | Recall identity/governance, storage, compute, networking, and monitoring without notes; record weak objectives and revisit labs selectively. |
| 30 | Mock exam and remediation | Take a timed, reputable practice assessment; classify every miss, revise the two weakest areas, and verify current exam objectives on Microsoft Learn. |

## CLI practice track

Install Azure CLI from Microsoft’s official instructions, sign in, and verify the active tenant and subscription before issuing changes. Commands that create resources can incur charges.

```bash
az login
az account show --output table
az account list --output table
az account set --subscription "<subscription-id-or-name>"

az group list --output table
az group show --name "<resource-group>" --output table
az group create --name "<resource-group>" --location "<region>"

az role definition list --name "Reader" --output table
az role assignment list --scope "<resource-id>" --output table

az storage account list --output table
az network vnet list --output table
az vm list --show-details --output table
```

Use `az <service> <command> --help` and Microsoft Learn for service-specific create commands. Do not paste passwords, keys, SAS tokens, or other secrets into shared notes or source control.

## Troubleshooting routine

For every lab, check in this order: resource state and deployment errors; configuration; authentication; authorization and scope; DNS; network path and NSG rules; route table and next hop; service health; metrics, Activity Log, and diagnostic logs. Change one variable at a time and record the result.

## Exam readiness checklist

- [ ] Explain the difference between Microsoft Entra roles and Azure RBAC.
- [ ] Choose a correct RBAC scope and least-privilege role.
- [ ] Predict Azure Policy effects and lock behavior.
- [ ] Select storage redundancy, access method, and recovery feature from a scenario.
- [ ] Choose VM availability, scale, disk, and deployment options.
- [ ] Distinguish NSGs, routes, peering, service endpoints, and private endpoints.
- [ ] Interpret Azure Monitor metrics, logs, alerts, and Network Watcher findings.
- [ ] Distinguish Azure Backup from Site Recovery and describe restore/failover.
- [ ] Clean up lab resources and confirm no billable leftovers remain.

## Azure ↔ AWS Comparison

| Azure | Closest AWS equivalent |
|---|---|
| Microsoft Entra ID | IAM Identity Center / IAM |
| Azure subscription | AWS account |
| Azure RBAC | IAM policies and roles |
| Azure Policy | AWS Config / Service Control Policies |
| Blob Storage | Amazon S3 |
| Azure Files | Amazon EFS / FSx |
| Azure VM / VM Scale Sets | Amazon EC2 / Auto Scaling Groups |
| Azure VNet / NSG | Amazon VPC / security groups |
| Private Endpoint | AWS PrivateLink / VPC endpoint |
| Azure Monitor | Amazon CloudWatch |
| Azure Backup / Site Recovery | AWS Backup / Elastic Disaster Recovery |
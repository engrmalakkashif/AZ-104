# AZ-104 Microsoft Azure Administrator

A practical 30-day course for preparing for the **AZ-104: Microsoft Azure Administrator** exam. It progresses through identity and governance, storage, compute, networking, monitoring, and final revision, with hands-on work designed to be safe for low-cost subscriptions.

Before booking, verify the current [AZ-104 exam objectives](https://learn.microsoft.com/en-us/credentials/certifications/exams/az-104). Azure exam objectives, service features, Portal labels, regional availability, and pricing can change.

## Getting started

1. Choose the standard or short daily study rhythm below.
2. Install [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli) and sign in, or begin in the Azure Portal.
3. Confirm you are using an authorized training tenant and the intended subscription.
4. Open the day’s module in [`modules/`](modules/README.md), then read its lesson, lab notes, exercises, and quick reference.
5. Keep a lab log with the objective, settings/commands, result, troubleshooting notes, and cleanup confirmation.

### Daily study rhythm

| Activity | Standard day | Short day |
|---|---:|---:|
| Recall and revision | 1 hour | 30 min |
| New concepts | 2 hours | 30 min |
| Hands-on lab | 2 hours | 60 min |
| Practice questions | 1 hour | 30 min |
| Notes and troubleshooting | 1 hour | 30 min |

The standard rhythm is seven hours. The short rhythm is three hours; spread a day across sessions if needed. Understand the concept before provisioning resources.

## Prerequisites and lab safety

- Use an Azure subscription and tenant where you are authorized to create, inspect, and delete training resources. A Free or student subscription does not make every service/configuration free.
- Set a spending alert before labs. A Cost Management budget sends alerts; it is not a guaranteed spending cap.
- Check current pricing, region availability, quotas, and free-tier eligibility before deployment. Prefer read-only inspection, diagrams, template validation, and local simulations when live resources are unnecessary.
- Use a dedicated resource group, for example `az104-lab-<initials>-<date>`, and tag resources with `Purpose=AZ104-Lab`.
- Restrict public access. If SSH/RDP is required, allow only your current IP and remove that rule immediately after testing.
- Delete lab resources when finished and inspect for separately billed disks, snapshots, public IPs, storage, registries, Log Analytics ingestion, backups, and retained data.
- Do not invite real external users, buy licenses, or use production identities for practice. Never place passwords, account keys, or SAS tokens in notes, chat, or source control.

## 30-Day Study Plan

### Week 1: Identities and governance

| Day | Focus | Learn and practice | Lab outcome |
|---:|---|---|---|
| 1 | [Microsoft Entra ID foundations](modules/Module-01/README.md) | Tenant/directory, users, groups, cloud-only and hybrid identities, guests, authentication versus authorization | Inspect an authorized tenant; create test identities only where permitted |
| 2 | [Users, groups, licenses, SSPR](modules/Module-02/README.md) | User/group properties, assigned/dynamic membership, licensing, usage location, SSPR and authentication methods | Review group and SSPR configuration; do not purchase licenses for practice |
| 3 | [Azure RBAC](modules/Module-03/README.md) | Principals, role definitions and assignments, scope inheritance, built-in roles, custom roles | Inspect or assign least-privilege access at a disposable scope |
| 4 | [Azure Policy](modules/Module-04/README.md) | Definitions, assignments, initiatives, parameters, effects, compliance and exemptions | Audit or test a policy at a disposable scope, then remove it |
| 5 | [Resource groups, subscriptions, locks, tags](modules/Module-05/README.md) | Management hierarchy, `CanNotDelete`/`ReadOnly` locks, tags and scope | Draw hierarchy; test a lock only on disposable resources and remove it before cleanup |
| 6 | [Cost Management and review](modules/Module-06/README.md) | Cost Analysis, budgets, alerts, Advisor and domain 1 review | Inspect costs, set an alert if supported, and complete 30–40 questions |

### Week 2: Storage

| Day | Focus | Learn and practice | Lab outcome |
|---:|---|---|---|
| 7 | [Storage accounts and redundancy](modules/Module-07/README.md) | Account kinds, performance, endpoints, encryption, network access, LRS/ZRS/GRS/GZRS and RA variants | Compare account settings; create an account only after checking price and SKU availability |
| 8 | [Blob Storage](modules/Module-08/README.md) | Containers, block/append/page blobs, Hot/Cool/Cold/Archive, upload/download | Upload a small private test object, inspect it, download it, and clean it up |
| 9 | [Blob security and protection](modules/Module-09/README.md) | Keys, SAS, stored access policies, Entra authorization, soft delete, versions and snapshots | Design least-privilege access and inspect recovery settings; keep live credentials private |
| 10 | [Azure Files](modules/Module-10/README.md) | Shares, SMB/NFS, identity, quota, snapshots, soft delete and mounting | Inspect/create a small share only if cost-approved; mounting compute is optional |
| 11 | [Storage operations and lifecycle](modules/Module-11/README.md) | Storage Explorer, AzCopy, lifecycle rules, object replication and network controls | Transfer a tiny object, inspect lifecycle settings, and complete 30–40 questions |

### Week 3: Compute

| Day | Focus | Learn and practice | Lab outcome |
|---:|---|---|---|
| 12 | [Virtual machines](modules/Module-12/README.md) | Images, sizes, disks, NICs, IPs, NSGs, extensions and deployment | Use a template or create a small VM only after checking cost; delete related resources |
| 13 | [Managed disks and encryption](modules/Module-13/README.md) | Disk SKUs/performance, snapshots, encryption at host, attach and guest formatting | Practice with a diagram or disposable disk; remove snapshots and disks afterward |
| 14 | [Availability and scaling](modules/Module-14/README.md) | Zones, availability sets, fault/update domains, VMSS and autoscale | Compare designs; live VMSS deployment is optional and chargeable |
| 15 | [ARM templates](modules/Module-15/README.md) | Parameters, variables, resources, outputs, dependencies and deployment modes | Validate/preview a template; deploy only in a disposable RG and clean up |
| 16 | [Bicep](modules/Module-16/README.md) | Syntax, parameters, modules, outputs, dependencies, build and `what-if` | Build/validate locally; deploy only when the resulting cost is approved |
| 17 | [Azure containers](modules/Module-17/README.md) | ACR, repositories, tags, ACI, Container Apps, ingress, revisions and scaling | Prefer local containers; Azure registries/compute can be billed |
| 18 | [App Service](modules/Module-18/README.md) | Plans, scaling, slots, custom domains, TLS, backups and networking | Inspect plan/slot settings; use a low-cost deployment only if approved |

### Week 4: Virtual networking

| Day | Focus | Learn and practice | Lab outcome |
|---:|---|---|---|
| 19 | [VNets and subnets](modules/Module-19/README.md) | Address spaces, CIDR, subnet planning, NICs and IP allocation | Design a VNet and non-overlapping subnets before deploying |
| 20 | [NSGs and ASGs](modules/Module-20/README.md) | Inbound/outbound rules, priority, defaults, effective rules and ASGs | Test a restrictive rule and remove temporary access rules |
| 21 | [Peering and routing](modules/Module-21/README.md) | Regional/global peering, route tables, UDRs, next hop and system routes | Trace a route on paper; deploy only if needed for the exercise |
| 22 | [Service and private endpoints](modules/Module-22/README.md) | Service endpoints, private endpoints, private IPs and private DNS | Trace DNS/network flow; live endpoints may incur charges |
| 23 | [DNS and load balancing](modules/Module-23/README.md) | Public/private zones, records, frontends, backend pools, probes and rules | Design a probe/rule; avoid multi-VM deployment unless budgeted |

### Week 5: Monitoring and maintenance

| Day | Focus | Learn and practice | Lab outcome |
|---:|---|---|---|
| 24 | [Azure Monitor](modules/Module-24/README.md) | Metrics, logs, Activity Log, diagnostic settings, Log Analytics and KQL | Inspect platform telemetry; check ingestion/retention pricing before enabling logs |
| 25 | [Alerts and insights](modules/Module-25/README.md) | Metric/log/activity alerts, action groups, alert processing and insights | Design an alert; test notifications only in an authorized scope |
| 26 | [Network Watcher](modules/Module-26/README.md) | Connection troubleshoot, IP flow verify, NSG diagnostics, topology and Connection Monitor | Diagnose a simulated blocked flow or use a small disposable network |
| 27 | [Backup and Site Recovery](modules/Module-27/README.md) | Vaults, policies, restore, replication, recovery plans, failover/failback | Compare workflows; protect real workloads only after reviewing retention and cost |

### Final revision

| Day | Focus | Work product |
|---:|---|---|
| 28 | [Integrated Azure architecture lab](modules/Module-28/README.md) | Design identity, RBAC, policy, VNet, compute, private storage access, monitoring and recovery; provision only budget-approved components |
| 29 | [Full-domain revision](modules/Module-29/README.md) | Recall all five domains without notes, record weak objectives, and revisit selected lessons/labs |
| 30 | [Mock exam and remediation](modules/Module-30/README.md) | Take a timed reputable assessment, classify misses, and revise the two weakest domains |

## Azure CLI setup and practice

Install Azure CLI using the [official instructions](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli). Sign in and verify the active tenant/subscription before running commands. Creation commands may incur charges.

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

Use `az <service> <command> --help` and current Microsoft Learn documentation for service-specific syntax. Never paste passwords, keys, or SAS tokens into shared notes or source control.

## Troubleshooting routine

For each lab, check in this order: deployment/resource state; configuration; authentication; authorization and scope; DNS; network path, NSG and route; service health; metrics, Activity Log and diagnostic logs. Change one variable at a time and record the result.

## Exam readiness checklist

- [ ] Distinguish Microsoft Entra roles from Azure RBAC and choose least privilege at the correct scope.
- [ ] Predict Azure Policy effects and resource-lock behavior.
- [ ] Select storage redundancy, access method, tier and recovery feature for a scenario.
- [ ] Choose VM availability, scale, disk and deployment options.
- [ ] Distinguish NSGs, routes, peering, service endpoints and private endpoints.
- [ ] Interpret Azure Monitor metrics/logs, alerts and Network Watcher findings.
- [ ] Explain the difference between Azure Backup and Site Recovery.
- [ ] Clean up lab resources and verify no separately billed leftovers remain.
- [ ] Recheck current objectives on the official [AZ-104 exam page](https://learn.microsoft.com/en-us/credentials/certifications/exams/az-104).

## Course resources

- [All day modules](modules/README.md)
- [Per-day content coverage audit](CONTENT-AUDIT.md)
- [Reusable instructor lesson template](MODULE-TEMPLATE.md)
- [Azure CLI documentation](https://learn.microsoft.com/en-us/cli/azure/)

Older materials that are not part of the core sequence are marked as optional within [Day 28](modules/Module-28/README.md). Some day folders share cross-day labs or still need dedicated deep-dive content; the audit identifies those gaps.

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
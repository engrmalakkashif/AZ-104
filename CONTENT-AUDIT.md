# 30-Day Course Content Audit

The `modules/Module-1` through `modules/Module-30` folders are the single course sequence. Existing material was moved into these folders; no separate `course-content` directory is required. This audit distinguishes content that exists from content still needing authoring.

| Day | Topic | Merged content | Missing or incomplete |
|---:|---|---|---|
| 1 | Entra ID fundamentals | Theory, lab notes, exercises, PowerShell/quick reference | Day-specific CLI reference; older labs include license actions that must be treated as optional/paid |
| 2 | Users, groups, licenses, SSPR | Shares Day 1 identity foundation | Dedicated theory, lab notes, safe no-purchase exercises, current CLI/Graph examples |
| 3 | Azure RBAC | Theory, lab notes, exercises, commands, diagram | Azure CLI reference verification; data-plane distinction should be expanded |
| 4 | Azure Policy | Governance theory, notes, policy/tag/lock exercises, commands | Dedicated policy-only lesson and safe policy cleanup lab |
| 5 | Resource groups, subscriptions, locks, tags | Shares governance notes and exercises from Day 4 | Dedicated hierarchy/lock exercise and CLI reference |
| 6 | Cost Management | Cost theory, lab notes, exercises, commands | Dedicated 30-day-aligned lesson and safer budget guidance |
| 7 | Storage accounts | Storage theory, lab notes, exercises, commands | Dedicated account/redundancy lab focused on currently supported SKUs |
| 8 | Blob Storage | Shares Day 7 storage reference | Blob-specific theory and upload/tier exercises |
| 9 | Blob security/protection | Shares Day 7 storage reference | SAS, Entra data access, soft delete/versioning/snapshot lab; secret-safe examples |
| 10 | Azure Files | Full `CONTENT.md` lesson and shared storage labs/references | Dedicated Azure Files lab notes/exercises and SMB/NFS mount walkthrough |
| 11 | Storage operations | Shares Day 7 storage references | AzCopy/lifecycle/object replication exercises and CLI quick reference |
| 12 | Virtual machines | VM notes, exercises, PowerShell/quick reference | Dedicated Azure CLI reference and low-cost cleanup-focused VM lab |
| 13 | Disks/encryption | Shares Day 12 VM notes/exercises | Disk-specific theory, attach/format/snapshot/encryption labs |
| 14 | Availability/VMSS | Shares Day 12 VM references | Zones/sets/VMSS/autoscale lesson and charge-aware exercises |
| 15 | ARM templates | 30-day outline only | Theory, validation/what-if lab notes, exercises, CLI/template samples |
| 16 | Bicep | 30-day outline only | Theory, build/what-if lab notes, exercises, sample Bicep files |
| 17 | Containers | Outline retained under this day | ACR/ACI/Container Apps theory, lab notes, local/Azure exercises, CLI reference |
| 18 | App Service | Full 15-section lesson, lab notes, exercises, PowerShell/quick reference | Azure CLI quick reference; current lesson has CLI examples |
| 19 | VNets/subnets | Networking notes, exercises, commands | Dedicated VNet address-planning lab and Azure CLI reference check |
| 20 | NSG/ASG | Network-security notes, exercises, commands | Dedicated ASG/priority/effective-rules lab and Azure CLI reference check |
| 21 | Peering/routing | Shares Day 19 networking references | Dedicated peering/UDR/next-hop exercises |
| 22 | Service/private endpoints | Shares Day 20 security references | Private DNS, endpoint, and access-validation lab |
| 23 | DNS/load balancing | Shares Day 19/20 references | DNS record and Load Balancer probe/backend exercises |
| 24 | Azure Monitor | Outline retained under this day | Metrics/logs/Activity Log theory, diagnostic-settings lab notes and exercises |
| 25 | Alerts/insights | Outline retained under this day | Alert/action group/insights theory and notification-safe lab |
| 26 | Network Watcher | No dedicated lesson assets | Troubleshooting tool guide, blocked-flow exercise, CLI/Portal notes |
| 27 | Backup/Site Recovery | Outline retained under this day | Vault/policy/restore/failover theory and cost-reviewed lab exercises |
| 28 | Integrated architecture | Architecture prompt; optional old SQL/Functions/security/monitoring/backup outlines | Stepwise integration exercise, validation rubric, cleanup checklist |
| 29 | Full revision | Study-plan review checklist | Domain-by-domain recall sheets and original question sets |
| 30 | Mock exam/remediation | Study-plan mock-exam workflow | Original practice assessment, answer explanations, scoring/weak-area tracker |

## Shared-folder note

Some legacy materials span multiple adjacent study days. They remain in the earliest relevant day folder and are linked by later day READMEs rather than copied, avoiding duplicate lab files. `REFERENCE-OVERVIEW.md` and `REFERENCE-SUMMARY.md` retain historical module descriptions; the day README is the authoritative sequence and instructions.

## Lab safety gaps to correct when expanding

- Replace instructions that imply a Free subscription makes all configurations free; check current region-specific pricing.
- Never purchase/assign a paid license for a practice lab.
- Scope policy and RBAC tests to disposable resources and remove assignments/policies after testing.
- Restrict SSH/RDP to the learner's current IP; avoid leaving public access open.
- Verify separately billed disks, snapshots, public IPs, Log Analytics ingestion, storage, container registries, and backup data after cleanup.
- Treat Cost Management budgets as alerts, not hard spending limits.
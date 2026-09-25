# AZ-104: Microsoft Azure Administrator - 15 Day Complete Study Plan

**Exam Effective Date:** April 17, 2026  
**Total Study Hours:** 75 hours (5 hours/day × 15 days)  
**Passing Score:** 700 or greater

---

## 📋 Complete 15-Module Breakdown

### **Skill Domain Distribution**
- Manage Azure identities and governance: **20-25%** (Modules 1-3)
- Implement and manage storage: **15-20%** (Modules 4-6)
- Deploy and manage Azure compute resources: **20-25%** (Modules 7-10)
- Implement and manage virtual networking: **15-20%** (Modules 11-13)
- Monitor and maintain Azure resources: **10-15%** (Modules 14-15)

---

## 🗓️ 15-Day Study Schedule

### **WEEK 1: Azure Identities & Governance (Modules 1-3)**

#### **Day 1: Module 1 - Manage Microsoft Entra Users & Groups**
- ⏱️ **Duration:** 5 hours
- 📚 **Topics:**
  - Create cloud users in Microsoft Entra ID
  - Manage user and group properties
  - Manage licenses in Microsoft Entra ID
  - Manage external users and guest accounts
  - Configure self-service password reset (SSPR)
- 🔧 **Labs:**
  - Create cloud user with complete profile
  - Create dynamic security groups
  - Assign Microsoft 365 licenses
  - Configure SSPR policies
- ✅ **Deliverables:**
  - 3 users created with different roles
  - 2 dynamic groups with membership rules
  - License assignments verified

#### **Day 2: Module 2 - Manage Access & RBAC**
- ⏱️ **Duration:** 5 hours
- 📚 **Topics:**
  - Azure RBAC fundamentals
  - Security principals (users, groups, service principals, managed identities)
  - Role definitions (built-in and custom)
  - Role assignment scopes (Management Group → Subscription → RG → Resource)
  - Interpret effective access assignments
- 🔧 **Labs:**
  - Assign Contributor role at resource group level
  - Assign Storage Contributor at storage account level
  - Assign Reader role at subscription level
  - Check effective permissions
  - Create custom VM Operator role
- ✅ **Deliverables:**
  - 3+ role assignments at different scopes
  - 1 custom role created
  - Effective access reviewed for 3 users

#### **Day 3: Module 3 - Azure Subscriptions & Governance**
- ⏱️ **Duration:** 5 hours
- 📚 **Topics:**
  - Implement Azure Policy (definitions, assignments, effects)
  - Configure resource locks (CanNotDelete, ReadOnly)
  - Apply and manage tags on resources
  - Manage resource groups effectively
  - Manage subscriptions and management groups
  - Cost management with alerts and budgets
- 🔧 **Labs:**
  - Enforce location policy (Deny effect)
  - Create custom tag enforcement policy
  - Apply CanNotDelete lock to storage account
  - Apply ReadOnly lock to configuration storage
  - Tag resources with Environment/Owner/CostCenter
  - Create management group hierarchy
- ✅ **Deliverables:**
  - 2 policy assignments active
  - 2 locks applied and tested
  - 5+ resources tagged
  - Management group structure created

---

### **WEEK 2: Azure Storage & Compute (Modules 4-7)**

#### **Day 4: Module 4 - Configure Storage Access & Security**
- ⏱️ **Duration:** 5 hours
- 📚 **Topics:**
  - Configure Azure Storage firewalls and virtual networks
  - Create and use shared access signature (SAS) tokens
  - Configure stored access policies
  - Manage access keys
  - Configure identity-based access for Azure Files
  - Network service endpoints vs. private endpoints
- 🔧 **Labs:**
  - Create storage account with firewall rules
  - Generate SAS token for blob access
  - Configure stored access policy
  - Set up service endpoint for storage account
  - Create private endpoint for secure access
  - Rotate access keys
- ✅ **Deliverables:**
  - Storage account with firewall active
  - 2 SAS tokens generated (time-limited)
  - Private endpoint configured
  - Access verified from different networks

#### **Day 5: Module 5 - Configure Storage Accounts & Redundancy**
- ⏱️ **Duration:** 5 hours
- 📚 **Topics:**
  - Create and configure storage accounts
  - Azure Storage redundancy options (LRS, ZRS, GRS, GZRS, RA-GRS)
  - Configure object replication
  - Configure storage account encryption
  - Manage data with Azure Storage Explorer and AzCopy
  - Storage tiers (Hot, Cool, Archive)
- 🔧 **Labs:**
  - Create storage account with GRS redundancy
  - Configure blob lifecycle management
  - Set up object replication between accounts
  - Enable encryption at rest
  - Transfer data using AzCopy
  - Configure storage tier policies
- ✅ **Deliverables:**
  - Storage account created with appropriate redundancy
  - Lifecycle policies active
  - Data replicated to secondary region
  - AzCopy transfers completed

#### **Day 6: Module 6 - Azure Files & Blob Storage**
- ⏱️ **Duration:** 5 hours
- 📚 **Topics:**
  - Create and configure file share in Azure Files
  - Create and configure blob containers
  - Configure storage tiers and access tiers
  - Configure soft delete for blobs and containers
  - Configure snapshots and soft delete for Azure Files
  - Configure blob lifecycle management
  - Configure blob versioning
- 🔧 **Labs:**
  - Create Azure Files share with 100 GB quota
  - Mount file share on Windows VM
  - Create blob containers with access levels
  - Upload blobs and configure tiers
  - Enable blob versioning
  - Configure soft delete (7-day retention)
  - Create blob snapshots
  - Test blob recovery from soft delete
- ✅ **Deliverables:**
  - File share created and mounted
  - Blob containers with tiered content
  - Versioning and soft delete enabled
  - Snapshots created and restored

#### **Day 7: Module 7 - Deploy & Manage Virtual Machines (Part 1)**
- ⏱️ **Duration:** 5 hours
- 📚 **Topics:**
  - Interpret and modify ARM templates
  - Modify and deploy Bicep files
  - Create virtual machines
  - Configure encryption at host
  - Move VMs between resource groups/subscriptions/regions
  - Manage VM sizes and disks
- 🔧 **Labs:**
  - Deploy VM using ARM template
  - Export deployed VM as template
  - Modify Bicep file and deploy
  - Create VM with custom settings
  - Add/resize managed disks
  - Change VM size
  - Move VM to different resource group
- ✅ **Deliverables:**
  - 2 VMs deployed (one from template, one from Bicep)
  - VM with 2 data disks attached
  - VM moved to different resource group
  - Template exported and modified

---

### **WEEK 3: Azure Compute & Networking (Modules 8-11)**

#### **Day 8: Module 8 - Virtual Machines Availability & Containers**
- ⏱️ **Duration:** 5 hours
- 📚 **Topics:**
  - Deploy VMs to availability zones and sets
  - Deploy and configure Virtual Machine Scale Sets
  - Create and manage Azure Container Registry
  - Provision containers with Azure Container Instances
  - Provision containers with Azure Container Apps
  - Manage sizing and scaling for containers
- 🔧 **Labs:**
  - Create availability set with 2 VMs
  - Create VMs in availability zones
  - Deploy VM scale set with 3 instances
  - Configure auto-scale rules
  - Create container registry
  - Push Docker image to ACR
  - Deploy container from ACR to Container Instances
  - Deploy app to Container Apps
- ✅ **Deliverables:**
  - High-availability setup with 3+ VMs
  - VM scale set with auto-scaling active
  - Container registry with 2+ images
  - Container running in production

#### **Day 9: Module 9 - Azure App Service**
- ⏱️ **Duration:** 5 hours
- 📚 **Topics:**
  - Provision and configure App Service plans
  - Configure scaling for App Service plans
  - Create and configure App Service
  - Configure certificates and TLS
  - Map custom DNS name to App Service
  - Configure backup for App Service
  - Configure networking settings
  - Configure deployment slots
- 🔧 **Labs:**
  - Create App Service plan (S1 tier)
  - Deploy web app to App Service
  - Configure auto-scale rules
  - Upload SSL certificate
  - Map custom domain
  - Create backup policy
  - Configure network security
  - Create staging deployment slot
- ✅ **Deliverables:**
  - App Service with scaling enabled
  - SSL certificate installed
  - Custom domain configured
  - Backup policy active
  - Staging slot created

#### **Day 10: Module 10 - Virtual Networking - Part 1**
- ⏱️ **Duration:** 5 hours
- 📚 **Topics:**
  - Create and configure virtual networks
  - Create and configure subnets
  - Create and configure virtual network peering
  - Configure public IP addresses
  - Configure user-defined routes
  - Troubleshoot network connectivity
- 🔧 **Labs:**
  - Create VNet with multiple subnets
  - Create peering between two VNets
  - Configure user-defined route table
  - Create route to on-premises network
  - Assign public IPs to VMs
  - Test connectivity between subnets
  - Troubleshoot routing issues
- ✅ **Deliverables:**
  - VNet created with 3+ subnets
  - VNet peering established
  - Route tables configured
  - Network connectivity verified

#### **Day 11: Module 11 - Virtual Networking - Part 2 (Security & DNS)**
- ⏱️ **Duration:** 5 hours
- 📚 **Topics:**
  - Create and configure network security groups (NSGs)
  - Create application security groups
  - Evaluate effective security rules
  - Implement Azure Bastion
  - Configure service endpoints for PaaS
  - Configure private endpoints for PaaS
  - Configure Azure DNS
  - Configure load balancers (internal and public)
- 🔧 **Labs:**
  - Create NSG with inbound/outbound rules
  - Create application security group
  - Configure NSG for web servers
  - Deploy Azure Bastion for VM access
  - Configure service endpoint for storage account
  - Create private endpoint for Key Vault
  - Create Azure DNS zone
  - Add DNS records
  - Deploy public load balancer with backend pool
- ✅ **Deliverables:**
  - NSG with 5+ security rules
  - Application security group with members
  - Azure Bastion deployed and tested
  - Private endpoint operational
  - DNS zone configured
  - Load balancer with health probes

---

### **WEEK 4: Monitoring & Maintenance (Modules 12-15)**

#### **Day 12: Module 12 - Azure Monitor & Insights**
- ⏱️ **Duration:** 5 hours
- 📚 **Topics:**
  - Interpret metrics in Azure Monitor
  - Configure log settings in Azure Monitor
  - Query and analyze logs using KQL
  - Set up alert rules and action groups
  - Configure monitoring for VMs, storage, networks
  - Use Azure Network Watcher
  - Use Connection Monitor
- 🔧 **Labs:**
  - Create metric alert on CPU
  - Create log alert for failed logins
  - Create action group with email notification
  - Query logs using Kusto Query Language (KQL)
  - Enable VM insights on test VMs
  - Configure network flow logs
  - Run connection monitor tests
- ✅ **Deliverables:**
  - 3+ alert rules configured
  - Action group created and tested
  - KQL queries for common scenarios
  - VM Insights enabled
  - Network monitoring active

#### **Day 13: Module 13 - Backup & Recovery Part 1**
- ⏱️ **Duration:** 5 hours
- 📚 **Topics:**
  - Create Recovery Services vault
  - Create Azure Backup vault
  - Create and configure backup policies
  - Perform backup and restore operations
  - Backup strategies (daily, weekly, monthly, yearly)
  - Retention policies
  - Backup reports and alerts
- 🔧 **Labs:**
  - Create Recovery Services vault
  - Configure backup for VM
  - Create backup policy (daily + weekly)
  - Perform on-demand backup
  - Restore file from backup
  - Create Azure Backup vault
  - Backup blob storage data
  - Configure backup alerts
- ✅ **Deliverables:**
  - VM backup configured and completed
  - File restore tested
  - Backup retention verified
  - Multiple backup policies active

#### **Day 14: Module 14 - Backup & Recovery Part 2 (Site Recovery)**
- ⏱️ **Duration:** 5 hours
- 📚 **Topics:**
  - Configure Azure Site Recovery
  - Replicate Azure VMs to secondary region
  - Test failover procedures
  - Perform failover to secondary region
  - Configure recovery plans
  - Failback operations
  - Site Recovery reports and alerts
- 🔧 **Labs:**
  - Enable replication for test VM
  - Configure Site Recovery policy
  - Create recovery plan
  - Perform test failover
  - Monitor replication status
  - Create alert for replication failures
  - Document failover procedure
- ✅ **Deliverables:**
  - VM replication active
  - Recovery plan created
  - Test failover completed successfully
  - Replication health verified

#### **Day 15: Module 15 - Comprehensive Review & Practice Exam**
- ⏱️ **Duration:** 5 hours
- 📚 **Topics:**
  - Review all 5 skill domains
  - Practice exam with 50 questions
  - Identify weak areas
  - Re-study challenging topics
  - Final Q&A and certification readiness
- 🔧 **Activities:**
  - Take official practice assessment
  - Review performance by skill domain
  - Re-do failed lab exercises
  - Prepare notes for weak areas
  - Mock exam in exam format
- ✅ **Deliverables:**
  - Practice exam score: 70%+ target
  - Performance analysis document
  - Weak area study notes
  - Readiness checklist

---

## 📚 Module Overview Table

| Day | Module | Topic | Skill Domain | Status |
|-----|--------|-------|--------------|--------|
| 1 | 1 | Microsoft Entra Users & Groups | Identities (20-25%) | ⬜ |
| 2 | 2 | Access Control & RBAC | Identities (20-25%) | ⬜ |
| 3 | 3 | Subscriptions & Governance | Identities (20-25%) | ⬜ |
| 4 | 4 | Storage Access & Security | Storage (15-20%) | ⬜ |
| 5 | 5 | Storage Accounts & Redundancy | Storage (15-20%) | ⬜ |
| 6 | 6 | Azure Files & Blob Storage | Storage (15-20%) | ⬜ |
| 7 | 7 | Deploy Virtual Machines (Pt 1) | Compute (20-25%) | ⬜ |
| 8 | 8 | VM Availability & Containers | Compute (20-25%) | ⬜ |
| 9 | 9 | Azure App Service | Compute (20-25%) | ⬜ |
| 10 | 10 | Virtual Networking (Pt 1) | Networking (15-20%) | ⬜ |
| 11 | 11 | Virtual Networking (Pt 2) | Networking (15-20%) | ⬜ |
| 12 | 12 | Azure Monitor & Insights | Monitoring (10-15%) | ⬜ |
| 13 | 13 | Backup & Recovery (Pt 1) | Monitoring (10-15%) | ⬜ |
| 14 | 14 | Backup & Recovery (Pt 2) | Monitoring (10-15%) | ⬜ |
| 15 | 15 | Comprehensive Review & Practice | All Domains | ⬜ |

---

## 🎯 Daily Study Structure (Each Module)

```
MODULE STRUCTURE (5 hours per day):

1. THEORY & CONCEPTS (60 minutes)
   - Read theoretical concepts
   - Watch Microsoft Learn videos
   - Understand key principles
   - Review Azure documentation

2. LAB SETUP (30 minutes)
   - Create test resources
   - Prepare lab environment
   - Ensure all prerequisites met
   - Review lab objectives

3. HANDS-ON LABS (180 minutes)
   - Follow step-by-step lab exercises
   - Document results and outputs
   - Test each feature thoroughly
   - Troubleshoot issues as they arise

4. REVIEW & SUMMARY (30 minutes)
   - Review key takeaways
   - Complete self-assessment
   - Note areas for further study
   - Prepare for next day's module
```

---

## 📊 Study Resources by Module

### Required Resources
```
✅ Azure Subscription (Free tier acceptable for most labs)
✅ Azure Portal (portal.azure.com)
✅ Microsoft Entra Admin Center (entra.microsoft.com)
✅ PowerShell with Az module
✅ Azure CLI
✅ Visual Studio Code
✅ Microsoft Learn modules (free)
```

### Essential Documentation URLs
```
- Azure Documentation: https://learn.microsoft.com/en-us/azure/
- Microsoft Entra ID: https://learn.microsoft.com/en-us/azure/active-directory/
- Azure Storage: https://learn.microsoft.com/en-us/azure/storage/
- Azure Compute: https://learn.microsoft.com/en-us/azure/virtual-machines/
- Azure Networking: https://learn.microsoft.com/en-us/azure/virtual-network/
- Azure Monitor: https://learn.microsoft.com/en-us/azure/azure-monitor/
- Azure Backup: https://learn.microsoft.com/en-us/azure/backup/
- ARM Templates: https://learn.microsoft.com/en-us/azure/azure-resource-manager/templates/
```

---

## ✅ Pre-Exam Checklist

**Before taking the AZ-104 exam, verify you can:**

### Module 1-3 (Identities & Governance) - 20-25%
- [ ] Create cloud users and manage properties
- [ ] Create dynamic groups with membership rules
- [ ] Assign Microsoft 365 licenses
- [ ] Configure SSPR
- [ ] Explain RBAC model (Principal + Role + Scope)
- [ ] Assign roles at different scopes
- [ ] Create custom roles
- [ ] Interpret effective permissions
- [ ] Create and assign Azure Policies
- [ ] Apply resource locks
- [ ] Manage tags on resources
- [ ] Create management groups

### Module 4-6 (Storage) - 15-20%
- [ ] Configure storage firewalls and VNets
- [ ] Create and use SAS tokens
- [ ] Configure stored access policies
- [ ] Manage storage account access keys
- [ ] Configure storage redundancy
- [ ] Set up object replication
- [ ] Create file shares and blob containers
- [ ] Configure storage tiers and lifecycle
- [ ] Enable soft delete and versioning
- [ ] Use Azure Storage Explorer and AzCopy

### Module 7-9 (Compute) - 20-25%
- [ ] Deploy VMs from templates and Bicep
- [ ] Create VMs with custom configuration
- [ ] Add and resize disks
- [ ] Move VMs between resource groups
- [ ] Deploy VMs to availability zones/sets
- [ ] Create VM scale sets with auto-scaling
- [ ] Create and manage container registries
- [ ] Deploy containers to ACI/ACA
- [ ] Create App Service plans and web apps
- [ ] Configure auto-scaling for App Service
- [ ] Map custom domains
- [ ] Configure SSL/TLS certificates
- [ ] Set up backup policies

### Module 10-11 (Networking) - 15-20%
- [ ] Create VNets and subnets
- [ ] Configure VNet peering
- [ ] Assign public IPs
- [ ] Create user-defined routes
- [ ] Create and configure NSGs
- [ ] Create application security groups
- [ ] Implement Azure Bastion
- [ ] Configure service endpoints
- [ ] Create private endpoints
- [ ] Configure Azure DNS
- [ ] Deploy load balancers

### Module 12-15 (Monitoring & Maintenance) - 10-15%
- [ ] Create metric and log alerts
- [ ] Configure action groups
- [ ] Write KQL queries
- [ ] Enable VM Insights
- [ ] Configure Azure Monitor for resources
- [ ] Use Network Watcher
- [ ] Create backup policies
- [ ] Perform backup and restore
- [ ] Configure Site Recovery
- [ ] Perform failover operations

---

## 📈 Success Metrics

**By end of Week 1:**
- ✅ 10+ users and groups created
- ✅ RBAC fully understood and implemented
- ✅ 3+ policies assigned and tested
- ✅ Resource locks protecting critical resources

**By end of Week 2:**
- ✅ Storage accounts created with multiple features
- ✅ Blob and file services configured
- ✅ 2+ VMs deployed and running
- ✅ Container registry with images

**By end of Week 3:**
- ✅ Full VNet architecture deployed
- ✅ NSGs with security rules configured
- ✅ Load balancer with health checks
- ✅ DNS zone created

**By end of Week 4:**
- ✅ Monitoring and alerts active
- ✅ Backup policies configured
- ✅ Site Recovery replicated
- ✅ Practice exam score 70%+

---

## 🚀 Exam Readiness Criteria

### Minimum Competency Level
- [ ] Can explain every skill in objectives
- [ ] Can perform every lab exercise independently
- [ ] Score 70% on practice assessments
- [ ] Understand troubleshooting procedures
- [ ] Know when to use which service

### Advanced Preparation
- [ ] Can design solutions for given scenarios
- [ ] Understand trade-offs between options
- [ ] Know security best practices
- [ ] Can optimize costs
- [ ] Understand performance implications

---

## 💡 Study Tips

1. **Hands-on First** - Don't just watch videos, do the labs
2. **Document Everything** - Keep notes on what you learn
3. **Repeat Failing Labs** - Redo exercises where you got stuck
4. **Use Different Methods** - Learn via Portal, PowerShell, and CLI
5. **Read the Docs** - Microsoft docs are authoritative
6. **Join Communities** - Reddit r/Azure, Microsoft Q&A, Forums
7. **Teach Others** - Explaining to others solidifies knowledge
8. **Review Regularly** - Spend last day reviewing weak areas
9. **Get Rest** - Don't cram night before exam
10. **Manage Time** - 85 questions in 120 minutes = 1.4 min per question

---

## 📞 Support Resources

**Need Help?**
- Microsoft Learn: https://learn.microsoft.com
- Microsoft Q&A: https://learn.microsoft.com/en-us/answers/
- Azure Community Support: https://azure.microsoft.com/support/community/
- Stack Overflow: https://stackoverflow.com/questions/tagged/azure
- Official Azure Blog: https://azure.microsoft.com/blog/

---

## 🎓 Certification Path

```
AZ-104: Azure Administrator
    ↓
AZ-305: Azure Solutions Architect Expert
    ↓
Advanced Specialties (Security, Data, etc.)
```

---

**Good luck with your AZ-104 certification journey! Remember: Consistency and hands-on practice are the keys to success.**

**Created:** $(date)  
**Study Plan Version:** 1.0  
**Based on:** Microsoft Learn Study Guide (Updated April 17, 2026)

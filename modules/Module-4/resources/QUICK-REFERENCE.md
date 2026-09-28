# Module 3: Subscriptions & Governance - Quick Reference Guide

**Quick lookup for policies, locks, tags, management groups, and governance best practices**

---

## 🎯 Governance Framework at a Glance

```
Azure Governance Structure:
┌────────────────────────────────────────────────────────────┐
│ Management Groups (Organize subscriptions & apply policy)  │
│                                                            │
│  ├─ Production Environment                                │
│  │  ├─ Apps Subscription                                  │
│  │  └─ Data Subscription                                  │
│  │                                                        │
│  └─ Development Environment                               │
│     └─ Dev Subscription                                   │
│                                                            │
│  ← Policies inherited at all levels                        │
└────────────────────────────────────────────────────────────┘
```

---

## 📋 Azure Policy Essentials

### What is Azure Policy?

```
Azure Policy = Rules for Azure Resources

Enforce = Automatically enforces rules
Audit = Checks compliance but allows creation
Deny = Blocks resource creation if violates

Examples:
  ✓ Enforce: "Storage must be encrypted"
  ✓ Audit: "VM must have backup"
  ✓ Deny: "Can only create in US regions"
```

### Built-in Policy Categories

| Category | Example | Effect |
|----------|---------|--------|
| **Compute** | VM images only from approved list | Deny |
| **Storage** | Storage must have encryption | Deny |
| **Network** | NSG must exist on subnet | Deny |
| **Monitoring** | All resources must have tags | Deny |
| **Security** | No public storage access | Deny |
| **Cost** | Only Standard tier VMs | Deny |

### Policy Structure

```
Policy = Rule + Effect

IF: condition is met
THEN: apply effect

Example:
IF: Storage account encryption = false
THEN: deny creation
```

---

## 🔐 Resource Locks at a Glance

### Lock Types

```
┌─────────────────────────────────────────────────────────┐
│              RESOURCE LOCKS                             │
├─────────────────────────────────────────────────────────┤
│                                                         │
│ CanNotDelete Lock:                                      │
│   Can read ✓       | Can modify ✓  | Can delete ✗     │
│                                                         │
│ ReadOnly Lock:                                          │
│   Can read ✓       | Can modify ✗  | Can delete ✗     │
│                                                         │
│ Usage: Prevent accidental changes to critical resources │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

### When to Use Locks

```
✅ USE CanNotDelete:
  - Production resource groups
  - Critical databases
  - Backup storage accounts
  - Production VMs
  
  Effect: Prevent accidents; prevent /delete

✅ USE ReadOnly:
  - Archived resources
  - Reference data
  - Compliance resources
  - Audit logs storage
  
  Effect: Prevent all changes; read-only mode

❌ DON'T OVERUSE:
  - Development environments (slows iteration)
  - Test resources
  - Learning environments
```

---

## 🏷️ Tags & Tagging Strategy

### Essential Tags

```
┌──────────────────────────────────────────┐
│      MINIMUM TAG SET FOR EVERY RESOURCE  │
├──────────────────────────────────────────┤
│ Environment     → Production / Dev / Test│
│ CostCenter      → IT-001 / Sales-002 / HR│
│ Owner           → john.smith / team-name │
│ Project         → ProjectName            │
│ ManagedBy       → Manual / Automation    │
└──────────────────────────────────────────┘
```

### Tag Usage Examples

| Use Case | Tag Key | Tag Value | Purpose |
|----------|---------|-----------|---------|
| **Billing** | CostCenter | IT-001 | Cost allocation |
| **Compliance** | Compliance | PCI-DSS | Track regulated resources |
| **Automation** | ManagedBy | Terraform | Track management method |
| **Organization** | Environment | Production | Identify environment type |
| **Support** | Owner | john.smith | Track responsibility |
| **Lifecycle** | CreatedDate | 2025-01-15 | Track resource age |

### Tag Format Best Practices

```
✅ GOOD:
  Key: "Environment"      Value: "Production"
  Key: "CostCenter"       Value: "IT-001"
  Key: "CreatedBy"        Value: "john.smith"

❌ BAD:
  Key: "env"              Value: "prod"         (too abbreviated)
  Key: "Cost_Center"      Value: "IT 001"       (inconsistent format)
  Key: "Unnecessary"      Value: "Yes"          (not used)
  Key: "CreatedOnDate"    Value: "1/15/2025"    (inconsistent date)
```

---

## 🏢 Management Groups Structure

### Typical Hierarchy

```
Tenant Root
│
├─ Production (MG)
│  ├─ Apps Subscription
│  └─ Data Subscription
│
├─ Development (MG)
│  ├─ Dev Subscription
│  └─ Sandbox Subscription
│
└─ Shared Services (MG)
   ├─ Networking Subscription
   └─ Security Subscription

Policies applied at Management Group level
propagate to all child subscriptions
```

### Management Group Benefits

```
✅ Centralized governance at scale
✅ Apply policies once, affect many subscriptions
✅ Organize by environment/department/project
✅ Consistent compliance across organization
✅ Simplified user access management
✅ Cleaner billing and cost allocation
```

---

## ⚡ Quick Commands

### Policy Commands

```bash
# List all policies
az policy definition list --query "[].{name:name, type:type}"

# Assign policy
az policy assignment create --name "MyPolicy" \
                            --policy "Allowed Locations"

# Get compliance state
az policy state list --filter "complianceState eq 'NonCompliant'"

# Remove policy
az policy assignment delete --name "MyPolicy"
```

### Lock Commands

```bash
# Create lock
az lock create --name "Protect-RG" \
               --lock-type CanNotDelete \
               --resource-group rg-name

# List locks
az lock list --resource-group rg-name

# Remove lock
az lock delete --name "Protect-RG" \
               --resource-group rg-name
```

### Tag Commands

```bash
# Add tags
az tag create --resource-id $resourceId \
              --tags Environment=Production CostCenter=IT-001

# Find by tag
az resource list --query "[?tags.Environment=='Production']"

# Update tags
az tag update --resource-id $resourceId \
              --operation Merge \
              --tags Owner=john.smith
```

---

## 🎯 Common Governance Patterns

### Pattern 1: Enforce Location & Encryption

```
Policy 1: Allowed Locations
  - Restrict to US regions only
  - Scope: Entire organization (tenant root)
  
Policy 2: Storage Encryption
  - Require encryption on all storage
  - Scope: Production management group
  
Result: Production resources limited to US + encrypted
```

### Pattern 2: Cost Control with Tags

```
Tags Applied:
  - CostCenter: Department code
  - Project: Project name
  - Environment: Prod/Dev/Test

Cost Analysis:
  ✓ Filter costs by CostCenter
  ✓ Identify project spending
  ✓ Track environment costs
```

### Pattern 3: Protect Production Resources

```
Locks Applied:
  - Management Group: Production (ReadOnly on sensitive)
  - Resource Group: Prod-RG (CanNotDelete)
  - Database: CustomerDB (ReadOnly)
  
Result: Prevent accidental changes/deletes in production
```

---

## ⚠️ Important Rules & Best Practices

### ✅ DO

- [ ] Tag ALL resources immediately upon creation
- [ ] Use consistent tag naming across organization
- [ ] Apply locks to production resources
- [ ] Create management group hierarchy early
- [ ] Test policies in non-production first
- [ ] Use built-in policies when available
- [ ] Audit policy compliance regularly
- [ ] Document tagging standards
- [ ] Review locks quarterly
- [ ] Keep management group structure simple

### ❌ DON'T

- [ ] Skip tagging "we'll tag later" (you won't)
- [ ] Create locks on development resources
- [ ] Forget to remove audit policies (cost $)
- [ ] Create policies with no exclusions (breaks things)
- [ ] Tag with too many custom tags (maintenance burden)
- [ ] Use Management Groups as "catch-all" buckets
- [ ] Apply ReadOnly locks to resources needing updates
- [ ] Leave orphaned policies assigned
- [ ] Mix tagging conventions
- [ ] Ignore policy compliance reports

### Policy Audit Impact

```
⚠️ IMPORTANT: Audit policies = $$$ costs

Every policy evaluation = API call = $ cost

Solution:
  1. Use Compliance view (batched queries)
  2. Don't create too many audit policies
  3. Focus on critical compliance areas
  4. Review policy assignments regularly
```

---

## 🔍 Troubleshooting Guide

### "Policy Violation - Can't create resource"

**Problem:** Getting "Policy violation" error when creating resource

**Causes & Solutions:**
```
1. Resource type not allowed
   → Check policy allowed types
   → Resource type may not be whitelisted
   
2. Location not allowed
   → Check allowed regions
   → Try US East instead of South Central
   
3. Tag missing
   → Policy requires tags
   → Add Environment=Production before creating
   
4. Configuration not compliant
   → Storage must be encrypted
   → Enable encryption in settings first

Solution:
Get-AzPolicyState -Filter "complianceState eq 'NonCompliant'"
```

---

### "Can't delete because of lock"

**Problem:** "Cannot delete - resource is locked"

**Solution:**
```
1. Identify lock
   az lock list --resource-group rg-name
   
2. Check lock type
   - CanNotDelete: can modify, just can't delete
   - ReadOnly: can't modify or delete
   
3. Remove lock if needed
   az lock delete --name lock-name \
                  --resource-group rg-name
   
4. Try operation again
```

---

### "Policy not enforcing"

**Problem:** Created policy but it's not blocking resources

**Causes:**
```
1. Policy effect is "Audit" not "Deny"
   → Audit only logs; doesn't block
   → Change to Deny effect
   
2. Policy not assigned to correct scope
   → Check assignment scope
   → Verify subscription/RG in scope
   
3. Resource excluded from policy
   → Check NotScopes
   → Resource might be in excluded RG
   
4. Policy condition too narrow
   → Test condition against resources
   → May need to broaden rule
```

---

## 📊 Governance Checklist

Before deploying resources in production:

- [ ] **Tags Applied**: All required tags on resources
- [ ] **Locks Applied**: Critical resources protected
- [ ] **Policies Compliant**: Resources pass all policy checks
- [ ] **Access Controlled**: RBAC roles assigned correctly
- [ ] **Cost Tags**: CostCenter tags for billing
- [ ] **Owner Identified**: Owner tag on all resources
- [ ] **Compliance Met**: All compliance tags applied
- [ ] **Documentation**: Reason for each tag documented
- [ ] **Reviewed**: Governance reviewed by team lead
- [ ] **Monitored**: Setup alerts for non-compliance

---

## 🎓 Key Concepts Recap

| Concept | Purpose | Example |
|---------|---------|---------|
| **Policy** | Rules for Azure resources | Require encryption, limit locations |
| **Lock** | Prevent changes/deletion | CanNotDelete, ReadOnly |
| **Tag** | Categorize & track resources | Environment, CostCenter, Owner |
| **Management Group** | Organize subscriptions | Production, Development groups |
| **Compliance** | State of policy adherence | Compliant or NonCompliant |
| **Effect** | What policy does | Deny, Audit, Modify, DeployIfNotExists |
| **Scope** | Where policy applies | Subscription, Resource Group, Resource |

---

## 🚀 Governance Strategy Summary

```
┌─────────────────────────────────────────────────────────────┐
│         COMPLETE GOVERNANCE IMPLEMENTATION                  │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│ 1. ORGANIZE (Management Groups)                            │
│    └─ Production, Development, Shared Services             │
│                                                             │
│ 2. CONTROL (Policies)                                       │
│    └─ Location restrictions, encryption requirements       │
│                                                             │
│ 3. PROTECT (Locks)                                          │
│    └─ CanNotDelete on production, ReadOnly on sensitive    │
│                                                             │
│ 4. TRACK (Tags)                                             │
│    └─ Environment, CostCenter, Owner on all resources      │
│                                                             │
│ 5. COMPLY (Audit & Reporting)                              │
│    └─ Monitor compliance, fix violations                   │
│                                                             │
│ Result: Well-governed, secure, tracked Azure environment   │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

---

## 📈 Next Steps

After mastering governance:
1. ✅ Create management group hierarchy for your organization
2. ✅ Define tag standards for your teams
3. ✅ Create policies for your industry/compliance
4. ✅ Implement locks on production resources
5. ✅ Set up compliance monitoring & alerts
6. ✅ Regular governance audits (quarterly)
7. ✅ Move to Module 4: Networking

---

**You've mastered Azure Governance! Keep resources organized and compliant! 🎯**


# Module 3: Manage Azure Subscriptions and Governance (Policies, Locks, Tags, Cost Management)

**Day:** 3 | **Duration:** 5 hours | **Skill Domain:** Manage Azure subscriptions and governance (20-25%)

---

## 📚 Learning Objectives

By the end of this module, you will be able to:
- Implement and manage Azure Policy
- Configure resource locks (read-only and delete locks)
- Apply and manage tags on resources
- Manage resource groups effectively
- Manage subscriptions and management groups
- Control costs using alerts, budgets, and Azure Advisor
- Configure management groups

---

## 📖 Theory & Concepts

### 3.1 Azure Policy Fundamentals

**What is Azure Policy?**
- Service for enforcing organizational standards
- Creates, assigns, and manages policies
- Ensures compliance across resources
- Can audit or enforce policy compliance

**Policy Components:**
```
Policy Definition → Policy Assignment → Compliance Evaluation
```

**Policy Types:**

1. **Built-in Policies** - Microsoft-provided policies for common scenarios
   - Enforce location restrictions
   - Require tags
   - Enforce encryption
   - Control VM sizes

2. **Custom Policies** - Create policies specific to your organization
   - JSON format
   - Define custom rules

3. **Policy Initiatives (Definition Sets)** - Collections of related policies
   - Example: "Security Hardening Initiative" includes multiple security policies
   - Deploy multiple policies with one assignment

**Policy Effects:**

| Effect | Behavior |
|--------|----------|
| Deny | Prevents non-compliant resource creation |
| Audit | Logs non-compliant resources (no blocking) |
| Modify | Changes resource configuration to comply |
| AuditIfNotExists | Audits if extension/setting doesn't exist |
| DeployIfNotExists | Automatically deploys remedy if non-compliant |
| Disabled | Policy not enforced |

**Example Policy - Require Location:**
```json
{
  "mode": "Indexed",
  "policyRule": {
    "if": {
      "field": "location",
      "notIn": [
        "eastus",
        "westus"
      ]
    },
    "then": {
      "effect": "Deny"
    }
  },
  "parameters": {
    "allowedLocations": {
      "type": "array",
      "description": "Allowed resource locations"
    }
  }
}
```

### 3.2 Resource Locks

**What are Resource Locks?**
- Mechanism to prevent accidental changes/deletion
- Applied at resource, resource group, or subscription level
- Inherited from parent scopes

**Lock Types:**

1. **CanNotDelete Lock**
   - Prevents deletion of resource
   - Allows modifications
   - **Use case:** Critical databases, production storage

2. **ReadOnly Lock**
   - Prevents all modifications
   - Prevents deletion
   - Prevents configuration changes
   - **Use case:** Production configurations, compliance requirements

**Lock Scope Hierarchy:**
```
Management Group Lock
    ├── Affects all subscriptions
    └── Affects all resources below
    
Subscription Lock
    ├── Affects all resource groups
    └── Affects all resources
    
Resource Group Lock
    ├── Affects all resources in group
    └── New resources inherit lock
    
Resource Lock
    └── Affects only this resource
```

**Lock Considerations:**
- Requires Owner or User Access Administrator role
- Cannot be bypassed by regular users
- Can be inherited (child locks don't override parent)
- Delete lock: User can still read/modify
- Read-only lock: More restrictive

### 3.3 Tags for Resource Organization

**What are Tags?**
- Key-value pairs for organizing resources
- Support searching, filtering, reporting
- Help with cost allocation
- No limit on tag count per resource

**Common Tag Patterns:**

```
Environment: Production, Staging, Development
Cost Center: CC-1234, Finance, Engineering
Owner: john.smith@contoso.com
Application: HR-System, CRM-Platform
Data Classification: Public, Internal, Confidential
```

**Tag Strategy:**
```
Recommended Minimum Tags:
- Environment (Prod/Staging/Dev)
- Owner (Team/Person responsible)
- Cost Center (For billing)
- Application (What it's used for)
```

**Tag Enforcement via Policy:**
```json
{
  "mode": "Indexed",
  "policyRule": {
    "if": {
      "field": "tags[Environment]",
      "exists": "false"
    },
    "then": {
      "effect": "Deny"
    }
  }
}
```

### 3.4 Management Groups

**What are Management Groups?**
- Hierarchy above subscriptions
- Enable governance at scale
- Support policy inheritance
- 6-level depth supported

**Management Group Structure:**
```
Root Management Group
├── IT Management Group
│   ├── Production Subscriptions
│   └── Non-Production Subscriptions
├── Finance Management Group
│   ├── Financial Systems Subscriptions
│   └── Billing Subscriptions
└── Engineering Management Group
    ├── Development Subscriptions
    └── Testing Subscriptions
```

**Benefits:**
- Single policy assignment affects all subscriptions in group
- Simplify governance
- Centralized billing
- Cross-subscription RBAC

### 3.5 Resource Groups Management

**Resource Group Best Practices:**
- Group by application/workload
- Consider lifecycle (create/delete together)
- Organize by business/team
- Use naming conventions

**Resource Group Naming Convention:**
```
{Environment}-{Application}-{Function}-rg
Example: prod-crm-database-rg
Example: dev-webapp-api-rg
```

### 3.6 Cost Management & Budgets

**Cost Management Tools:**

1. **Budgets**
   - Set spending limits
   - Receive alerts when approaching limit
   - Can stop resources automatically
   - Monthly/quarterly/yearly budgets

2. **Cost Alerts**
   - Anomaly alerts (unusual spending)
   - Budget alerts (approaching limit)
   - Credit alert (credits running low)

3. **Azure Advisor Recommendations**
   - Identifies underutilized resources
   - Recommends cost optimizations
   - Security recommendations
   - Performance improvements

**Cost Analysis:**
- Breakdown by resource type, location, department
- Filter by tags, subscriptions, resource groups
- Export data for analysis

---

## 🔧 Lab Notes & Environment Setup

### Prerequisites
- Azure subscription
- Owner or Contributor role
- Test resource group created

### Lab Preparation Resources
```
Create these resources for lab exercises:
- Resource Group: "rg-governance-lab"
- Storage Account: "storagegov001"
- Virtual Network: "vnet-governance-lab"
- Virtual Machine: "vm-governance-lab" (optional, for demo)
```

---

## 💻 Lab Exercise 1: Implement Azure Policy

### Exercise 3.1: Apply Built-in Policy - Enforce Resource Location

**Objective:** Enforce that all resources must be created in specific regions

**Scenario:**
```
Policy: Only allow East US and West US regions
Effect: Deny (prevent creation outside these regions)
Scope: Resource Group level
```

**Steps:**

1. **Navigate to Azure Policy**
   ```
   Azure Portal → Search "Policy" → Azure Policy
   ```

2. **Find Built-in Policy**
   - Click "Definitions" in left panel
   - Search: "allowed locations"
   - Select "Allowed locations"
   - Review policy definition

3. **Create Assignment**
   - Click "Assign"
   - Scope: Select your subscription
   - Exclude: Leave empty
   - Assignment Name: "Enforce-EastUS-WestUS-Locations"
   - Description: "Enforce resources created only in East US and West US"
   - Policy Enforcement: "Enabled"

4. **Configure Parameters**
   - Allowed locations: ["eastus", "westus"]
   - Click "Next"

5. **Review and Create**
   - Click "Review + Create"
   - Click "Create"

**Expected Output:**
```
✅ Policy Assignment Created
Name: Enforce-EastUS-WestUS-Locations
Policy: Allowed locations
Scope: /subscriptions/{subscriptionId}
Effect: Deny
Status: Enabled
Compliance: Will evaluate on next scan
```

**Verification:**
- Try creating a resource in "Central US" → Should be denied
- Create a resource in "East US" → Should succeed

---

### Exercise 3.2: Create Custom Policy - Require Environment Tag

**Objective:** Create and assign a policy requiring "Environment" tag on all resources

**Steps:**

1. **Navigate to Policy Definitions**
   ```
   Azure Policy → Definitions → Create Policy Definition
   ```

2. **Write Custom Policy**
   - Copy the following policy definition:

```json
{
  "mode": "Indexed",
  "policyRule": {
    "if": {
      "field": "tags[Environment]",
      "exists": "false"
    },
    "then": {
      "effect": "Deny"
    }
  },
  "parameters": {}
}
```

3. **Save Policy**
   - Name: "Require-Environment-Tag"
   - Description: "Enforce Environment tag on all resources"
   - Category: "Tags"
   - Click "Save"

4. **Assign Policy**
   - Navigate to "Assignments"
   - Click "Assign policy"
   - Search: "Require-Environment-Tag"
   - Scope: Your resource group
   - Click "Assign"

**Expected Output:**
```
✅ Custom Policy Created
Name: Require-Environment-Tag
Type: Custom
Effect: Deny (prevents resource creation without tag)
Status: Assigned

✅ Policy Assignment Created
Scope: /subscriptions/{subscriptionId}/resourcegroups/rg-governance-lab
Compliance: Evaluating
```

**Verification:**
- Try creating storage account without "Environment" tag → Denied
- Create storage account with "Environment=Production" tag → Allowed

---

### Exercise 3.3: Apply Resource Locks

**Objective:** Apply locks to prevent accidental deletion and modification

**Scenario:**
```
Resource: Production Database (storage account)
Lock Type: CanNotDelete (prevent accidental deletion)

Resource: Configuration Storage
Lock Type: ReadOnly (prevent all changes)
```

**Steps for CanNotDelete Lock:**

1. **Navigate to Storage Account**
   ```
   Azure Portal → Storage Accounts → storagegov001
   ```

2. **Add Lock**
   - Click "Locks" (in Settings section)
   - Click "Add"
   - Lock name: "prevent-storage-deletion"
   - Lock type: "Delete"
   - Notes: "Production storage - prevent accidental deletion"
   - Click "OK"

3. **Verify Lock**
   - Lock appears in locks list
   - Try to delete storage account
   - Error message appears: "Resource locked"

**Expected Output:**
```
✅ Lock Applied
Resource: storagegov001
Lock Type: CanNotDelete
Scope: Resource
Status: Active

❌ Deletion Blocked:
Error: "The resource 'storagegov001' cannot be deleted because it has a lock"
```

**Steps for ReadOnly Lock:**

1. **Create Another Storage Account**
   ```
   Name: "storageconfig001"
   Or use existing storage account if available
   ```

2. **Add ReadOnly Lock**
   - Click "Locks"
   - Click "Add"
   - Lock name: "prevent-config-changes"
   - Lock type: "ReadOnly"
   - Notes: "Configuration storage - prevent all changes"
   - Click "OK"

3. **Verify Lock**
   - Try to modify storage account settings
   - Error: "Not authorized to perform action"
   - Try to add containers
   - Error: "Cannot modify locked resource"

**Expected Output:**
```
✅ Lock Applied
Resource: storageconfig001
Lock Type: ReadOnly
Scope: Resource
Status: Active

❌ Modification Blocked:
Error: "Locked resources cannot be modified"
```

---

### Exercise 3.4: Apply and Manage Tags

**Objective:** Add tags to resources and create policy for tag enforcement

**Steps:**

1. **Navigate to Storage Account**
   ```
   Azure Portal → storagegov001 → Tags
   ```

2. **Add Tags**
   - Click "Edit"
   - Add tags:
     | Key | Value |
     |-----|-------|
     | Environment | Production |
     | Owner | john.smith@contoso.com |
     | CostCenter | CC-1234 |
     | Application | DataLake |
   - Click "Save"

3. **Tag Virtual Network**
   - Navigate to Virtual Network: "vnet-governance-lab"
   - Click "Tags"
   - Add same tags as storage account
   - Click "Save"

4. **Filter Resources by Tag**
   - Azure Portal home → Search
   - Click "Resource groups"
   - Click "Manage view" → "Add filter"
   - Filter: "Tags" → "Environment = Production"
   - View filtered resources

**Expected Output:**
```
✅ Tags Applied
Resource: storagegov001
Tags:
  - Environment: Production
  - Owner: john.smith@contoso.com
  - CostCenter: CC-1234
  - Application: DataLake

✅ Filtered View Created
Resources with Environment=Production tag: 2
- storagegov001
- vnet-governance-lab
```

---

### Exercise 3.5: Configure Management Groups (Optional Advanced)

**Objective:** Create management group hierarchy and apply policies

**Steps:**

1. **Navigate to Management Groups**
   ```
   Azure Portal → Search "Management Groups" → Management groups
   ```

2. **Create Management Groups**
   - Root MG appears (generated for tenant)
   - Create new: "Lab-Production"
   - Create new: "Lab-Non-Production"

3. **Move Subscriptions**
   - Move test subscription to "Lab-Non-Production"
   - Verify subscription appears under management group

4. **Apply Policy at MG Level**
   - Select "Lab-Production" MG
   - Click "Policies" → "Assign policy"
   - Assign "Allowed Locations" policy
   - Effect cascades to all subscriptions in group

**Expected Output:**
```
✅ Management Groups Created
- Lab-Production (contains prod subscriptions)
- Lab-Non-Production (contains dev/test subscriptions)

✅ Policy Applied at MG Level
Policy cascades to all subscriptions and resources below
```

---

## 📋 Quick Reference - PowerShell Commands

```powershell
# Connect to Azure
Connect-AzAccount

# ===== AZURE POLICY =====

# Get all policy definitions
Get-AzPolicyDefinition | Select-Object Name, DisplayName

# Get specific policy
Get-AzPolicyDefinition -Name "AllowedLocations"

# Create custom policy
$Policy = @{
  Mode = "Indexed"
  DisplayName = "Require Environment Tag"
  PolicyRule = @{
    if = @{
      field = "tags[Environment]"
      exists = "false"
    }
    then = @{
      effect = "Deny"
    }
  }
}
New-AzPolicyDefinition -Name "Require-Environment-Tag" -Policy $Policy

# Assign policy
$rg = Get-AzResourceGroup -Name "rg-governance-lab"
$policy = Get-AzPolicyDefinition -Name "Allowed locations"
New-AzPolicyAssignment -Name "Enforce-Locations" `
                       -PolicyDefinition $policy `
                       -Scope $rg.ResourceId

# Check policy compliance
Get-AzPolicyState | Select-Object ResourceId, ComplianceState

# ===== RESOURCE LOCKS =====

# Apply delete lock
$rg = Get-AzResourceGroup -Name "rg-governance-lab"
New-AzManagementLock -LockLevel CanNotDelete `
                     -LockName "prevent-deletion" `
                     -ResourceGroupName $rg.ResourceGroupName

# Apply read-only lock
New-AzManagementLock -LockLevel ReadOnly `
                     -LockName "prevent-changes" `
                     -ResourceGroupName $rg.ResourceGroupName

# List locks
Get-AzManagementLock -ResourceGroupName "rg-governance-lab"

# Remove lock
Remove-AzManagementLock -LockName "prevent-deletion" `
                        -ResourceGroupName "rg-governance-lab"

# ===== TAGS =====

# Get resource with tags
$resource = Get-AzResource -Name "storagegov001"
$resource.Tags

# Add tags to resource
$tags = @{
  Environment = "Production"
  Owner = "john.smith@contoso.com"
  CostCenter = "CC-1234"
}
Update-AzTag -ResourceId $resource.ResourceId -Tag $tags -Operation Merge

# Find resources by tag
Find-AzResource -TagKey "Environment" -TagValue "Production"

# ===== MANAGEMENT GROUPS =====

# Create management group
New-AzManagementGroup -GroupName "Lab-Production"

# List management groups
Get-AzManagementGroup

# Move subscription to management group
New-AzManagementGroupSubscription -GroupName "Lab-Production" `
                                   -SubscriptionId "subscription-id"
```

---

## ✅ Quick Fact Check

- [ ] Understand Azure Policy fundamentals (Definition, Assignment, Effect)
- [ ] Know difference between Deny and Audit effects
- [ ] Can create and assign built-in policies
- [ ] Understand resource locks (CanNotDelete vs ReadOnly)
- [ ] Know when to use each lock type
- [ ] Can apply and filter resources by tags
- [ ] Understand tag naming conventions
- [ ] Know management group hierarchy benefits

---

## 📝 Lab Summary Table

| Exercise | Task | Resource | Lock Type | Status |
|----------|------|----------|-----------|--------|
| 3.1 | Enforce Location Policy | Subscription | N/A | ⬜ |
| 3.2 | Require Tag Policy | RG | N/A | ⬜ |
| 3.3a | Apply CanNotDelete Lock | storagegov001 | Delete | ⬜ |
| 3.3b | Apply ReadOnly Lock | storageconfig001 | ReadOnly | ⬜ |
| 3.4 | Apply Tags | Multiple RGs | N/A | ⬜ |
| 3.5 | Create Management Groups | Subscription | N/A | ⬜ |

---

## 🎯 Key Takeaways

1. **Azure Policy for Compliance**
   - Audit: Monitor compliance without blocking
   - Deny: Prevent non-compliant resource creation
   - Modify: Auto-remediate resources to comply

2. **Resource Locks Prevent Accidents**
   - CanNotDelete: Allows modifications, prevents deletion
   - ReadOnly: Prevents all changes (most restrictive)
   - Always document why lock is applied

3. **Tags Enable Organization & Cost Tracking**
   - Minimum tags: Environment, Owner, CostCenter
   - Use policy to enforce tag application
   - Filter/search by tags for reporting

4. **Management Groups Scale Governance**
   - One policy at MG level = applied to all subscriptions
   - Organize by business unit/environment
   - Support 6 levels of hierarchy

5. **Cost Management Strategy**
   - Set budgets at subscription/resource group level
   - Use Azure Advisor for optimization
   - Track costs by tags and departments

---

## 🔍 Common Scenarios

### Scenario 1: Production Environment Protection
```
✅ Denied Locations Policy: Only eastus, westus
✅ CanNotDelete Locks: On critical databases and storage
✅ Comprehensive Tags: Full tracking and cost allocation
✅ ReadOnly Lock: On configuration storage (if needed)
```

### Scenario 2: Multi-Tenant Organization
```
Management Group Hierarchy:
├── Production MG → Enforce-Locations Policy
│   └── Deny non-compliant resources
├── Development MG → Require-Tags Policy
│   └── Enforce naming standards
└── Finance MG → Budget Alerts
    └── Monitor spending per department
```

### Scenario 3: Cost Optimization
```
✅ Budget Alert: When 80% of monthly budget reached
✅ Advisor Recommendations: Remove unused resources
✅ Tag Tracking: Allocate costs to departments
✅ Policy: Enforce resource type restrictions (e.g., VM sizes)
```

---

## 📚 Additional Resources

- [Azure Policy Documentation](https://learn.microsoft.com/en-us/azure/governance/policy/)
- [Built-in Policy Definitions](https://learn.microsoft.com/en-us/azure/governance/policy/samples/built-in-policies)
- [Resource Locks](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/lock-resources)
- [Tag Resources](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/tag-resources)
- [Management Groups](https://learn.microsoft.com/en-us/azure/governance/management-groups/overview)
- [Cost Management + Billing](https://learn.microsoft.com/en-us/azure/cost-management-billing/)
- [Azure Advisor](https://learn.microsoft.com/en-us/azure/advisor/advisor-overview)

---

## 📊 Self-Assessment

**Rate your understanding (1-5):**
- Azure Policy concepts and effects: __ / 5
- Creating and assigning policies: __ / 5
- Resource locks usage: __ / 5
- Tag strategies and application: __ / 5
- Management groups hierarchy: __ / 5
- Cost management and budgets: __ / 5

---

**Next Module:** Implement and Manage Storage - Part 1 (Storage Accounts & Access Control)

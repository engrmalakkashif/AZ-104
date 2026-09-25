# Module 3: Lab Exercises - Subscriptions & Governance

**Complete all 5 exercises in order**  
**Total Time:** 3 hours (30 min + 30 min + 45 min + 30 min + 30 min)  
**Difficulty:** Intermediate

---

## 📝 Exercise 3.1: Enforce Location Policy

### Objective
Create and assign an Azure Policy that restricts resource creation to specific regions (US East, US West, and West Europe).

### Duration
30 minutes

### Prerequisites
- ✅ Owner role or Policy Contributor
- ✅ Completed Modules 1 & 2
- ✅ Test resource group: `rg-governance-lab`

### Step-by-Step Instructions

#### Method 1: Using Azure Portal

**Step 1: Navigate to Policy Service**

```
1. Open: https://portal.azure.com
2. Search for: "Policy"
3. Click: "Policy" service
```

**Step 2: Create Policy Definition**

```
1. In Policy menu, click: "Definitions"
2. Click: "+ Policy definition" (top)
3. Configure:
   Definition location: Subscription
   Name: "Allowed Locations"
   Description: "Restrict resources to specific regions"
   Category: "Compliance"
```

**Step 3: Define Policy Rule**

```
In "Policy rule" section, use this JSON:

{
  "mode": "Indexed",
  "policyRule": {
    "if": {
      "allOf": [
        {
          "field": "type",
          "equals": "Microsoft.Resources/subscriptions/resourceGroups"
        },
        {
          "field": "location",
          "notIn": [
            "eastus",
            "westus",
            "westeurope"
          ]
        }
      ]
    },
    "then": {
      "effect": "deny"
    }
  },
  "parameters": {}
}
```

**Step 4: Create Policy**

```
1. Click: "Save"
2. Wait for success notification
3. Policy now appears in Definitions list
```

**Step 5: Assign Policy**

```
1. Go back to Policy main page
2. Click: "Assignments"
3. Click: "+ Assign policy"
4. Configure:
   Scope: Your subscription
   Exclusions: None (for now)
   Policy definition: Select "Allowed Locations"
   Assignment name: "Enforce US Locations Only"
   Enforcement: Enabled
5. Click: "Review + create"
6. Click: "Create"
```

#### Method 2: Using PowerShell

```powershell
# Connect to Azure
Connect-AzAccount
$subscriptionId = (Get-AzContext).Subscription.Id

# Create policy rule
$policyRule = @{
    "if" = @{
        "allOf" = @(
            @{
                "field" = "type"
                "equals" = "Microsoft.Resources/subscriptions/resourceGroups"
            },
            @{
                "field" = "location"
                "notIn" = @("eastus", "westus", "westeurope")
            }
        )
    }
    "then" = @{
        "effect" = "deny"
    }
} | ConvertTo-Json -Depth 10

# Create policy definition
$policyDef = New-AzPolicyDefinition -Name "Allowed Locations" `
                                    -DisplayName "Allowed Locations Policy" `
                                    -Description "Restrict resources to specific regions" `
                                    -Policy $policyRule `
                                    -Mode "Indexed"

# Assign policy
New-AzPolicyAssignment -Name "Enforce US Locations Only" `
                       -DisplayName "Enforce US Locations Only" `
                       -PolicyDefinition $policyDef `
                       -Scope "/subscriptions/$subscriptionId"
```

### Expected Output

```
✅ LOCATION POLICY CREATED AND ASSIGNED

Policy Definition:
  Name: Allowed Locations
  Type: Custom
  Mode: Indexed
  Status: ✅ ACTIVE

Policy Rule:
  Effect: Deny
  Allowed Locations:
    ✓ eastus (East US)
    ✓ westus (West US)
    ✓ westeurope (West Europe)
  
Policy Assignment:
  Name: Enforce US Locations Only
  Scope: /subscriptions/{subscriptionId}
  Enforcement: Enabled ✅
  
Verification:
  ✅ Policy appears in Definitions list
  ✅ Assignment shows as "Compliant"
  ✅ Attempting to create resource in southcentralus will fail
```

### Verification Checklist

- [ ] Policy definition created successfully
- [ ] Policy rule has correct JSON
- [ ] Policy assigned to subscription
- [ ] Assignment status shows "Enabled"
- [ ] Can see policy in assignments list
- [ ] Policy prevents resources in non-allowed regions

### Test the Policy

```powershell
# Try creating resource in non-allowed location (should fail)
New-AzResourceGroup -Name "test-southcentral" -Location "southcentralus"

# Result: 
# New-AzResourceGroup : The template deployment 'rg_deployment' 
# is not valid according to the template schema. The template 
# schema validation failed with error: Policy violation...

# Try in allowed location (should succeed)
New-AzResourceGroup -Name "test-eastus" -Location "eastus"

# Result:
# ✅ Successfully created resource group
```

---

## 📝 Exercise 3.2: Create Tag Policy

### Objective
Create a policy that requires specific tags on all resources (Environment and CostCenter).

### Duration
30 minutes

### Prerequisites
- ✅ Completed Exercise 3.1
- ✅ Policy Contributor role

### Step-by-Step Instructions

#### Method 1: Using Azure Portal

**Step 1: Create Tag Policy Definition**

```
1. Navigate to: Policy > Definitions
2. Click: "+ Policy definition"
3. Configure:
   Definition location: Subscription
   Name: "Require Tags"
   Description: "Require Environment and CostCenter tags"
   Category: "Tags"
```

**Step 2: Define Tag Policy Rule**

```
In "Policy rule" section, use this JSON:

{
  "mode": "All",
  "policyRule": {
    "if": {
      "field": "[concat('tags[', parameters('tagName'), ']')]",
      "exists": "false"
    },
    "then": {
      "effect": "deny"
    }
  },
  "parameters": {
    "tagName": {
      "type": "String",
      "metadata": {
        "description": "Name of the tag to enforce"
      }
    }
  }
}
```

**Step 3: Add Parameters**

```
Parameters section:
  Name: tagName
  Type: String
  Default value: Environment
  Description: "Name of the tag to enforce"
```

**Step 4: Create and Assign Policy**

```
1. Click: "Save"
2. Go to: Policy > Assignments
3. Click: "+ Assign policy"
4. Configure:
   Scope: Your subscription
   Policy: "Require Tags"
   Assignment name: "Enforce Required Tags"
   Tag name parameter: "Environment"
   Enforcement: Enabled
5. Click: "Create"
```

#### Method 2: Using PowerShell

```powershell
# Create tag enforcement policy
$tagPolicy = @{
    "mode" = "All"
    "policyRule" = @{
        "if" = @{
            "field" = "[concat('tags[', parameters('tagName'), ']')]"
            "exists" = "false"
        }
        "then" = @{
            "effect" = "deny"
        }
    }
    "parameters" = @{
        "tagName" = @{
            "type" = "String"
            "metadata" = @{
                "description" = "Name of the tag to enforce"
            }
        }
    }
} | ConvertTo-Json -Depth 10

# Create policy definition
$policyDef = New-AzPolicyDefinition -Name "Require Tags" `
                                    -DisplayName "Require Tags Policy" `
                                    -Description "Require Environment and CostCenter tags" `
                                    -Policy $tagPolicy `
                                    -Parameter '{"tagName":{"type":"String"}}' `
                                    -Mode "All"

# Assign policy with parameters
$subscriptionId = (Get-AzContext).Subscription.Id
New-AzPolicyAssignment -Name "Enforce Required Tags" `
                       -DisplayName "Enforce Required Tags" `
                       -PolicyDefinition $policyDef `
                       -Scope "/subscriptions/$subscriptionId" `
                       -PolicyParameterObject @{"tagName"=@("Environment")}
```

### Expected Output

```
✅ TAG POLICY CREATED AND ASSIGNED

Policy Definition:
  Name: Require Tags
  Type: Custom
  Mode: All
  Status: ✅ ACTIVE

Policy Rule:
  Effect: Deny when tag missing
  Required Tags:
    ✓ Environment (enforced via policy)
    ✓ CostCenter (recommended to add)

Policy Assignment:
  Name: Enforce Required Tags
  Scope: /subscriptions/{subscriptionId}
  Parameter: tagName = "Environment"
  Enforcement: Enabled ✅

Verification:
  ✅ Policy prevents resources without required tags
  ✅ Resources created with tags pass compliance
  ✅ Non-compliant resources shown in Policy Compliance
```

### Verification Checklist

- [ ] Tag policy definition created
- [ ] Policy rule contains tag enforcement logic
- [ ] Policy assigned to subscription
- [ ] Assignment active and enabled
- [ ] Can see policy in assignments
- [ ] Creating resource without tag fails

### Test the Policy

```powershell
# Try creating resource without tag (should fail)
New-AzResource -ResourceGroupName "rg-governance-lab" `
               -ResourceName "testresource" `
               -ResourceType "Microsoft.Storage/storageAccounts" `
               -Location "eastus"

# Result:
# Error: Policy violation - missing required tag "Environment"

# Try with tag (should succeed)
$tags = @{
    "Environment" = "Test"
    "CostCenter" = "12345"
}

New-AzStorageAccount -ResourceGroupName "rg-governance-lab" `
                     -Name "taggedstorageacct" `
                     -Location "eastus" `
                     -SkuName "Standard_LRS" `
                     -Tag $tags

# Result:
# ✅ Successfully created resource with tags
```

---

## 📝 Exercise 3.3: Apply Resource Locks

### Objective
Apply CanNotDelete and ReadOnly locks to critical resources to prevent accidental changes or deletion.

### Duration
45 minutes

### Prerequisites
- ✅ Completed Exercise 3.2
- ✅ Owner or Lock Contributor role
- ✅ Test resources in `rg-governance-lab`

### Step-by-Step Instructions

#### Method 1: Using Azure Portal

**Step 1: Apply CanNotDelete Lock to Resource Group**

```
1. Navigate to: Resource Groups > rg-governance-lab
2. Click: "Locks" (in left panel)
3. Click: "+ Add"
4. Configure:
   Lock name: "Protect-RG"
   Lock type: "Delete"
5. Click: "OK"
```

**Step 2: Verify CanNotDelete Lock**

```
✅ CanNotDelete Lock Applied:
  Users CAN still: Read, modify resources
  Users CANNOT: Delete resource group

Portal shows:
  ✓ Lock icon appears on RG
  ✓ Lock listed in "Locks" section
  ✓ Type shows "Delete"
```

**Step 3: Apply ReadOnly Lock to Storage Account**

```
1. Navigate to: Storage Accounts > storagerbaclab
2. Click: "Locks" (in left panel)
3. Click: "+ Add"
4. Configure:
   Lock name: "Protect-Storage-ReadOnly"
   Lock type: "Read-only"
5. Click: "OK"
```

**Step 4: Verify ReadOnly Lock**

```
✅ ReadOnly Lock Applied:
  Users CAN: View/read data
  Users CANNOT: Modify or delete

Portal shows:
  ✓ Lock appears on storage account
  ✓ Type shows "Read-only"
  ✓ Attempts to modify show error
```

**Step 5: Test Lock Enforcement**

```
1. Try to delete resource group
   Result: ❌ Error - "Resource group has lock"
   
2. Try to modify storage account settings
   Result: ❌ Error - "Resource is read-only"
   
3. Try to read storage data
   Result: ✅ Success - locks don't prevent read
```

#### Method 2: Using PowerShell

```powershell
# Connect to Azure
Connect-AzAccount

# Variables
$resourceGroupName = "rg-governance-lab"
$storageAccountName = "storagerbaclab"
$subscriptionId = (Get-AzContext).Subscription.Id

# Apply CanNotDelete lock to Resource Group
$lockName = "Protect-RG"
New-AzManagementLock -LockName $lockName `
                     -LockLevel "CanNotDelete" `
                     -ResourceGroupName $resourceGroupName

Write-Host "✅ CanNotDelete lock applied to RG" -ForegroundColor Green

# Apply ReadOnly lock to Storage Account
$storageAccount = Get-AzStorageAccount -ResourceGroupName $resourceGroupName `
                                       -Name $storageAccountName

$lockName = "Protect-Storage-ReadOnly"
New-AzManagementLock -LockName $lockName `
                     -LockLevel "ReadOnly" `
                     -ResourceId $storageAccount.Id

Write-Host "✅ ReadOnly lock applied to storage account" -ForegroundColor Green

# List all locks on resource group
Write-Host "`n=== LOCKS ON RESOURCE GROUP ===" -ForegroundColor Cyan
Get-AzManagementLock -ResourceGroupName $resourceGroupName | 
    Format-Table Name, LockLevel, ResourceId

# List all locks on specific resource
Write-Host "`n=== LOCKS ON STORAGE ACCOUNT ===" -ForegroundColor Cyan
Get-AzManagementLock -ResourceId $storageAccount.Id | 
    Format-Table Name, LockLevel
```

### Expected Output

```
╔══════════════════════════════════════════════════════════════════╗
║                  RESOURCE LOCKS APPLIED                          ║
╠══════════════════════════════════════════════════════════════════╣
║                                                                  ║
║ RESOURCE GROUP LOCK:                                             ║
║   Name: Protect-RG                                               ║
║   Type: CanNotDelete                                             ║
║   Scope: /subscriptions/{subId}/resourceGroups/rg-governance-lab║
║   Status: ✅ ACTIVE                                              ║
║                                                                  ║
║   Effects:                                                       ║
║   ✓ Cannot delete resource group                               ║
║   ✓ Can create resources inside                                ║
║   ✓ Can modify resources inside                                ║
║   ✗ Cannot remove this lock (needs Owner + remove lock)       ║
║                                                                  ║
║ STORAGE ACCOUNT LOCK:                                            ║
║   Name: Protect-Storage-ReadOnly                                ║
║   Type: ReadOnly                                                 ║
║   Scope: /subscriptions/{subId}/resourceGroups/rg-governance... ║
║           /providers/Microsoft.Storage/storageAccounts/storage..║
║   Status: ✅ ACTIVE                                              ║
║                                                                  ║
║   Effects:                                                       ║
║   ✓ Can read blobs                                              ║
║   ✓ Can view settings                                           ║
║   ✗ Cannot upload/delete blobs                                 ║
║   ✗ Cannot modify storage settings                             ║
║   ✗ Cannot delete storage account                              ║
║                                                                  ║
║ Status: ✅ ALL LOCKS ACTIVE AND PROTECTING RESOURCES            ║
╚══════════════════════════════════════════════════════════════════╝
```

### Verification Checklist

- [ ] CanNotDelete lock applied to resource group
- [ ] ReadOnly lock applied to storage account
- [ ] Both locks visible in portal "Locks" section
- [ ] Attempt to delete RG fails with lock error
- [ ] Attempt to modify storage account fails
- [ ] Reading data from storage still works
- [ ] Locks cannot be removed without authorization

### Lock Removal (For Cleanup)

```powershell
# List locks to find ID
$lock = Get-AzManagementLock -ResourceGroupName "rg-governance-lab" | 
        Where-Object { $_.Name -eq "Protect-RG" }

# Remove lock
Remove-AzManagementLock -LockId $lock.LockId -Force

Write-Host "✅ Lock removed" -ForegroundColor Green
```

---

## 📝 Exercise 3.4: Apply Tags

### Objective
Tag resources with Environment, CostCenter, and Owner information for organization, billing, and access tracking.

### Duration
30 minutes

### Prerequisites
- ✅ Completed Exercise 3.3
- ✅ Resources in `rg-governance-lab`

### Step-by-Step Instructions

#### Method 1: Using Azure Portal

**Step 1: Tag Resource Group**

```
1. Navigate to: Resource Groups > rg-governance-lab
2. Click: "Tags" (in left panel)
3. Add tags:
   Key: "Environment"  | Value: "Production"
   Key: "CostCenter"   | Value: "IT-001"
   Key: "Owner"        | Value: "John Smith"
   Key: "Project"      | Value: "Governance Lab"
4. Click: "Apply"
```

**Step 2: Tag Storage Account**

```
1. Navigate to: Storage Accounts > storagerbaclab
2. Click: "Tags" (in settings)
3. Add same tags
4. Click: "Save"
```

**Step 3: Tag Virtual Network (if exists)**

```
1. Navigate to: Virtual Networks > test-vnet
2. Click: "Tags"
3. Add same tags
4. Click: "Save"
```

#### Method 2: Using PowerShell

```powershell
# Define tag set
$tags = @{
    "Environment" = "Production"
    "CostCenter" = "IT-001"
    "Owner" = "John Smith"
    "Project" = "Governance Lab"
    "ManagedBy" = "Azure Automation"
}

# Tag Resource Group
$rg = Get-AzResourceGroup -Name "rg-governance-lab"
Update-AzTag -ResourceId $rg.ResourceId `
             -Tag $tags `
             -Operation Merge

Write-Host "✅ Tags applied to resource group" -ForegroundColor Green

# Tag Storage Account
$storageAccount = Get-AzStorageAccount -ResourceGroupName "rg-governance-lab" `
                                       -Name "storagerbaclab"
Update-AzTag -ResourceId $storageAccount.Id `
             -Tag $tags `
             -Operation Merge

Write-Host "✅ Tags applied to storage account" -ForegroundColor Green

# Verify tags on resource
Write-Host "`n=== RESOURCE GROUP TAGS ===" -ForegroundColor Cyan
(Get-AzResourceGroup -Name "rg-governance-lab").Tags | Format-Table

# Find resources by tag
Write-Host "`n=== RESOURCES WITH ENVIRONMENT=PRODUCTION ===" -ForegroundColor Cyan
Get-AzResource -TagName "Environment" -TagValue "Production" | 
    Select-Object Name, ResourceType, ResourceGroupName
```

### Expected Output

```
✅ TAGS APPLIED TO RESOURCES

Resource Group: rg-governance-lab
  Tags Applied:
    ✓ Environment: Production
    ✓ CostCenter: IT-001
    ✓ Owner: John Smith
    ✓ Project: Governance Lab
    ✓ ManagedBy: Azure Automation

Storage Account: storagerbaclab
  Tags Applied:
    ✓ Environment: Production
    ✓ CostCenter: IT-001
    ✓ Owner: John Smith
    ✓ Project: Governance Lab
    ✓ ManagedBy: Azure Automation

Verification:
  ✅ Tags visible in portal
  ✅ Can filter by tags
  ✅ Cost reports use tags
  ✅ Tags inherited in some views
```

### Verification Checklist

- [ ] Environment tag applied to all resources
- [ ] CostCenter tag applied to all resources
- [ ] Owner tag applied to all resources
- [ ] Project tag applied to all resources
- [ ] Tags visible in portal
- [ ] Can search/filter by tags
- [ ] No syntax errors in tag names/values

### Tag Usage Examples

```powershell
# Find all resources with specific tag
Get-AzResource -TagName "Environment" -TagValue "Production"

# Find resources by multiple tags
$resources = Get-AzResource | Where-Object {
    $_.Tags.Environment -eq "Production" -and 
    $_.Tags.CostCenter -eq "IT-001"
}

# Update tags on all resources in RG
Get-AzResource -ResourceGroupName "rg-governance-lab" | 
    ForEach-Object {
        Update-AzTag -ResourceId $_.Id `
                     -Tag @{"Reviewed" = "Yes"} `
                     -Operation Merge
    }
```

---

## 📝 Exercise 3.5: Management Groups (Optional Advanced)

### Objective
Create a management group hierarchy to organize subscriptions and apply policies/permissions at higher levels.

### Duration
30 minutes

### Prerequisites
- ✅ Completed Exercise 3.4
- ✅ Owner role or Management Group Contributor
- ✅ At least 2 subscriptions (or test with 1)

### Step-by-Step Instructions

#### Method 1: Using Azure Portal

**Step 1: Create Management Group**

```
1. Navigate to: Management Groups
2. Click: "+ Add management group"
3. Configure:
   Management group ID: "prod-env"
   Display name: "Production Environment"
4. Click: "Save"
```

**Step 2: Create Sub-Management Group**

```
1. Click: "prod-env"
2. Click: "+ Add sub-group" or Create child group
3. Configure:
   ID: "prod-apps"
   Display name: "Production Apps"
   Parent: "prod-env"
4. Click: "Save"
```

**Step 3: Add Subscription to Management Group**

```
1. In Management Groups, click: "prod-apps"
2. Click: "Subscriptions"
3. Click: "+ Add"
4. Select: Your test subscription
5. Click: "Save"
```

**Step 4: Apply Policy at Management Group Level**

```
1. Click: "prod-env" (parent group)
2. Click: "Policies"
3. Click: "+ Assign policy"
4. Select: "Allowed Locations" policy
5. Scope: prod-env (applies to all children)
6. Click: "Assign"
```

#### Method 2: Using PowerShell

```powershell
# Connect to Azure
Connect-AzAccount

# Create parent management group
New-AzManagementGroup -GroupName "prod-env" `
                      -DisplayName "Production Environment"

# Create child management group
New-AzManagementGroup -GroupName "prod-apps" `
                      -DisplayName "Production Apps" `
                      -ParentId "/providers/Microsoft.Management/managementGroups/prod-env"

# Get subscription and add to management group
$subscription = Get-AzSubscription | Select-Object -First 1
New-AzManagementGroupSubscription -GroupName "prod-apps" `
                                  -SubscriptionId $subscription.Id

# List management group hierarchy
$mg = Get-AzManagementGroup -GroupName "prod-env" -Expand -Recurse
$mg | ConvertTo-Json | Write-Output

Write-Host "✅ Management group hierarchy created" -ForegroundColor Green
```

### Expected Output

```
╔═══════════════════════════════════════════════════════════════════════╗
║              MANAGEMENT GROUP HIERARCHY CREATED                       ║
╠═══════════════════════════════════════════════════════════════════════╣
║                                                                       ║
║ Tenant Root Group                                                     ║
║ └── prod-env (Production Environment)                                ║
║     └── prod-apps (Production Apps)                                  ║
║         └── Subscriptions:                                           ║
║             ✓ [Your Test Subscription]                              ║
║                                                                       ║
║ Management Group Structure:                                           ║
║   ID: prod-env                                                        ║
║   Display Name: Production Environment                               ║
║   Children: 1 (prod-apps)                                            ║
║   Subscriptions: 0 (attached at child level)                         ║
║                                                                       ║
║   ID: prod-apps                                                       ║
║   Display Name: Production Apps                                      ║
║   Parent: prod-env                                                    ║
║   Subscriptions: 1 (your test subscription)                          ║
║                                                                       ║
║ Policy Inheritance:                                                   ║
║   ✅ Policies assigned at prod-env apply to all children             ║
║   ✅ Subscriptions inherit policies from parent groups                ║
║   ✅ Management group structure enables hierarchical governance       ║
║                                                                       ║
║ Status: ✅ HIERARCHY READY FOR GOVERNANCE                             ║
╚═══════════════════════════════════════════════════════════════════════╝
```

### Verification Checklist

- [ ] Parent management group created (prod-env)
- [ ] Child management group created (prod-apps)
- [ ] Subscription added to child group
- [ ] Hierarchy visible in portal
- [ ] Can assign policies at group level
- [ ] Policies inherited by child groups/subscriptions

---

## 📊 Summary of All Exercises

| Exercise | Task | Time | Status |
|----------|------|------|--------|
| 3.1 | Enforce Location Policy | 30 min | ⬜ |
| 3.2 | Create Tag Policy | 30 min | ⬜ |
| 3.3 | Apply Resource Locks | 45 min | ⬜ |
| 3.4 | Apply Tags | 30 min | ⬜ |
| 3.5 | Management Groups (Optional) | 30 min | ⬜ |
| **Total** | **All 5 exercises** | **3 hrs** | |

---

## ✅ Module Completion Verification

**Before moving to Module 4, verify:**

- [ ] Exercise 3.1 completed (policy created)
- [ ] Exercise 3.2 completed (tag policy enforced)
- [ ] Exercise 3.3 completed (locks applied)
- [ ] Exercise 3.4 completed (tags applied)
- [ ] Exercise 3.5 completed (optional - MGs created)
- [ ] All expected outputs verified
- [ ] Can explain governance concepts
- [ ] No errors encountered

---

## 🎓 What You've Learned

After completing all 5 exercises, you understand:
1. How to create and assign Azure Policies
2. How to enforce resource location restrictions
3. How to require tags on resources
4. How to protect resources with locks
5. How to organize resources with tags
6. How management groups enable governance hierarchy
7. Both Portal and PowerShell methods for governance

---

**Excellent! You're mastering Azure governance! Move to Module 4! 🚀**

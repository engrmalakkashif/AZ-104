# Module 2: Lab Exercises - Access Control & RBAC

**Complete all 4 exercises in order**  
**Total Time:** 2.75 hours (45 min + 30 min + 45 min + 15 min)  
**Difficulty:** Intermediate

---

## 📝 Exercise 2.1: Assign Roles at Different Scopes

### Objective
Assign Azure roles (Contributor, Storage Contributor, Reader) at different scopes (Resource Group, Storage Account, Subscription) to understand scope hierarchy.

### Duration
45 minutes

### Prerequisites
- ✅ Completed Module 1 (users created)
- ✅ Owner or User Access Administrator role
- ✅ Test resource group: `rg-rbac-lab`
- ✅ Test storage account: `storagerbaclab`
- ✅ Test user: John Smith (from Module 1)

### Step-by-Step Instructions

#### Method 1: Using Azure Portal (Recommended)

**Step 1: Create Test Resources (if not exists)**

```bash
# Create resource group
az group create --name rg-rbac-lab --location eastus

# Create storage account
az storage account create --name storagerbaclab \
                          --resource-group rg-rbac-lab \
                          --location eastus \
                          --sku Standard_LRS
```

**Step 2: Assign Role at Resource Group Level**

```
1. Navigate to: Azure Portal > Resource Groups
2. Click: "rg-rbac-lab"
3. In left panel, click: "Access Control (IAM)"
4. Click: "+ Add" > "Add role assignment"
5. Configure:
   Role: Select "Contributor"
   Assign access to: "User, group, or service principal"
   Select members: Search "John Smith" and select
6. Click: "Next" > "Review + assign"
7. Click: "Assign"
```

**Expected Output:**
```
✅ ROLE ASSIGNMENT CREATED AT RG SCOPE

Assignment Details:
  Principal: John Smith (john.smith@yourtenant.onmicrosoft.com)
  Role: Contributor
  Scope: /subscriptions/{subId}/resourceGroups/rg-rbac-lab
  Type: Direct
  Status: Active ✅

Verification in Portal:
  ✅ Role appears in "Role assignments" tab
  ✅ Scope shows as "rg-rbac-lab" (Resource Group)
  ✅ Type shows as "Direct"
  ✅ John Smith can manage resources in this RG
```

**Step 3: Assign Role at Storage Account Level**

```
1. Navigate to: Azure Portal > Storage Accounts
2. Click: "storagerbaclab"
3. In left panel, click: "Access Control (IAM)"
4. Click: "+ Add" > "Add role assignment"
5. Configure:
   Role: Select "Storage Blob Data Contributor"
   Assign access to: "User, group, or service principal"
   Select members: Search "John Smith" and select
6. Click: "Next" > "Review + assign"
7. Click: "Assign"
```

**Expected Output:**
```
✅ ROLE ASSIGNMENT CREATED AT STORAGE ACCOUNT SCOPE

Assignment Details:
  Principal: John Smith
  Role: Storage Blob Data Contributor
  Scope: /subscriptions/{subId}/resourceGroups/rg-rbac-lab/providers/Microsoft.Storage/storageAccounts/storagerbaclab
  Type: Direct
  Status: Active ✅

Verification:
  ✅ Assignment visible in storage account IAM
  ✅ Scope is more specific than RG level
  ✅ John Smith can manage blobs in this storage account
```

**Step 4: Assign Role at Subscription Level**

```
1. Navigate to: Azure Portal > Subscriptions
2. Click: Your subscription name
3. In left panel, click: "Access Control (IAM)"
4. Click: "+ Add" > "Add role assignment"
5. Configure:
   Role: Select "Reader"
   Assign access to: "User, group, or service principal"
   Select members: Search "John Smith" and select
6. Click: "Next" > "Review + assign"
7. Click: "Assign"
```

**Expected Output:**
```
✅ ROLE ASSIGNMENT CREATED AT SUBSCRIPTION SCOPE

Assignment Details:
  Principal: John Smith
  Role: Reader
  Scope: /subscriptions/{subscriptionId}
  Type: Direct
  Status: Active ✅

Verification:
  ✅ Assignment visible in subscription IAM
  ✅ Broadest scope in this exercise
  ✅ John Smith can view (but not modify) all resources in subscription
  ✅ All 3 assignments now active for John Smith
```

#### Method 2: Using PowerShell

```powershell
# Connect to Azure
Connect-AzAccount

# Variables
$resourceGroupName = "rg-rbac-lab"
$storageAccountName = "storagerbaclab"
$userPrincipal = "john.smith@yourtenant.onmicrosoft.com"

# Get user object ID
$user = Get-AzADUser -Filter "userPrincipalName eq '$userPrincipal'"
$userId = $user.Id

# 1. Assign Contributor at RG level
New-AzRoleAssignment -ObjectId $userId `
                     -RoleDefinitionName "Contributor" `
                     -ResourceGroupName $resourceGroupName

# 2. Assign Storage Blob Data Contributor at storage account level
$storageAccount = Get-AzStorageAccount -ResourceGroupName $resourceGroupName `
                                       -Name $storageAccountName

New-AzRoleAssignment -ObjectId $userId `
                     -RoleDefinitionName "Storage Blob Data Contributor" `
                     -Scope $storageAccount.Id

# 3. Assign Reader at subscription level
$subscriptionId = (Get-AzContext).Subscription.Id

New-AzRoleAssignment -ObjectId $userId `
                     -RoleDefinitionName "Reader" `
                     -Scope "/subscriptions/$subscriptionId"

# Verify all assignments
Get-AzRoleAssignment -ObjectId $userId | Format-Table RoleDefinitionName, Scope, ResourceGroupName
```

### Verification Checklist

- [ ] Assignment 1 created: Contributor at RG level
- [ ] Assignment 2 created: Storage Blob Data Contributor at storage level
- [ ] Assignment 3 created: Reader at subscription level
- [ ] All 3 assignments visible in portal
- [ ] Scopes are different (RG → Storage → Subscription)
- [ ] All assignments show as "Direct" type
- [ ] No errors in assignment process

### Expected Results

```
╔═══════════════════════════════════════════════════════════════╗
║            ROLE ASSIGNMENTS SUMMARY - ALL 3 SCOPES            ║
╠═══════════════════════════════════════════════════════════════╣
║ Principal: John Smith (john.smith@yourtenant.onmicrosoft.com) ║
║                                                               ║
║ Assignment 1 - RESOURCE GROUP LEVEL:                          ║
║   Role: Contributor                                           ║
║   Scope: rg-rbac-lab (Resource Group)                        ║
║   Access: Full management of resources in this RG            ║
║                                                               ║
║ Assignment 2 - STORAGE ACCOUNT LEVEL:                         ║
║   Role: Storage Blob Data Contributor                        ║
║   Scope: storagerbaclab (Storage Account)                    ║
║   Access: Can manage blobs in this storage account           ║
║                                                               ║
║ Assignment 3 - SUBSCRIPTION LEVEL:                            ║
║   Role: Reader                                                ║
║   Scope: /subscriptions/{subscriptionId}                     ║
║   Access: Read-only view of all resources in subscription    ║
║                                                               ║
║ Status: ✅ ALL ASSIGNMENTS ACTIVE                            ║
╚═══════════════════════════════════════════════════════════════╝
```

---

## 📝 Exercise 2.2: Check Effective Permissions

### Objective
Verify what permissions a user actually has by using Azure Portal's "Check access" feature and understand inherited vs. direct assignments.

### Duration
30 minutes

### Prerequisites
- ✅ Completed Exercise 2.1 (all 3 role assignments active)
- ✅ Test user: John Smith

### Step-by-Step Instructions

#### Method 1: Using Azure Portal

**Step 1: Check Access at Subscription Level**

```
1. Navigate to: Azure Portal > Subscriptions
2. Click: Your subscription
3. Click: "Access Control (IAM)"
4. Click: "Check access" tab
5. Search for: "John Smith"
6. Click on user in results
```

**Step 2: Review Effective Permissions**

```
Portal shows:
  Direct assignments:
    ✓ Reader (at subscription scope)
  
  Inherited assignments:
    (none at subscription level)
  
  Effective access:
    Can view all resources (read-only)
    Cannot modify any resources
    Cannot assign roles
```

**Step 3: Check Access at Resource Group Level**

```
1. Navigate to: Resource Groups > rg-rbac-lab
2. Click: "Access Control (IAM)"
3. Click: "Check access" tab
4. Search for: "John Smith"
```

**Step 4: Review Permissions at RG**

```
Portal shows:
  Direct assignments:
    ✓ Contributor (at rg-rbac-lab scope)
  
  Inherited assignments:
    ✓ Reader (inherited from subscription)
  
  Effective access:
    Can create/modify/delete resources in RG
    Can manage access (assign roles)
    More permissions than subscription-level Reader
    
Explanation:
  More specific scope (RG) = More permissions
  Assignment at RG overrides subscription-level Reader
```

**Step 5: Check Access at Storage Account Level**

```
1. Navigate to: Storage Accounts > storagerbaclab
2. Click: "Access Control (IAM)"
3. Click: "Check access" tab
4. Search for: "John Smith"
```

**Step 6: Review Permissions at Storage**

```
Portal shows:
  Direct assignments:
    ✓ Storage Blob Data Contributor (at storage account)
  
  Inherited assignments:
    ✓ Contributor (inherited from parent RG)
    ✓ Reader (inherited from subscription)
  
  Effective access:
    Can upload/read/delete blobs
    Can manage storage access
    Most specific scope = Most applicable permissions
```

#### Method 2: Using PowerShell

```powershell
# Connect to Azure
Connect-AzAccount

# Variables
$userPrincipal = "john.smith@yourtenant.onmicrosoft.com"
$resourceGroupName = "rg-rbac-lab"
$storageAccountName = "storagerbaclab"
$subscriptionId = (Get-AzContext).Subscription.Id

# Get user
$user = Get-AzADUser -Filter "userPrincipalName eq '$userPrincipal'"
$userId = $user.Id

# Check effective assignments at subscription level
Write-Host "=== SUBSCRIPTION LEVEL ASSIGNMENTS ===" -ForegroundColor Green
Get-AzRoleAssignment -ObjectId $userId -Scope "/subscriptions/$subscriptionId" | 
  Format-Table RoleDefinitionName, Scope, ResourceGroupName

# Check effective assignments at RG level
Write-Host "`n=== RESOURCE GROUP LEVEL ASSIGNMENTS ===" -ForegroundColor Green
Get-AzRoleAssignment -ObjectId $userId -ResourceGroupName $resourceGroupName | 
  Format-Table RoleDefinitionName, Scope, ResourceGroupName

# Check effective assignments at storage level
Write-Host "`n=== STORAGE ACCOUNT LEVEL ASSIGNMENTS ===" -ForegroundColor Green
$storageAccount = Get-AzStorageAccount -ResourceGroupName $resourceGroupName `
                                       -Name $storageAccountName
Get-AzRoleAssignment -ObjectId $userId -Scope $storageAccount.Id | 
  Format-Table RoleDefinitionName, Scope, ResourceGroupName

# Get all assignments for user (all scopes)
Write-Host "`n=== ALL ASSIGNMENTS FOR USER ===" -ForegroundColor Cyan
Get-AzRoleAssignment -ObjectId $userId | 
  Format-Table RoleDefinitionName, Scope, @{Label="Type";Expression={if($_.Scope -like "*subscriptions*") {"Subscription"} elseif($_.Scope -like "*resourceGroups*") {"Resource Group"} else {"Resource"}}}
```

### Expected Output

```
╔════════════════════════════════════════════════════════════════════╗
║          EFFECTIVE PERMISSIONS - JOHN SMITH                        ║
║  (All permissions across all scopes where roles assigned)          ║
╠════════════════════════════════════════════════════════════════════╣
║                                                                    ║
║ SUBSCRIPTION LEVEL (Inherited at lower scopes):                    ║
║   Role: Reader                                                     ║
║   Permissions: View all resources (read-only)                     ║
║                                                                    ║
║ RESOURCE GROUP: rg-rbac-lab (Overrides subscription):             ║
║   Role: Contributor                                                ║
║   Permissions:                                                     ║
║     ✓ Create/read/update/delete resources                        ║
║     ✓ Manage role assignments                                    ║
║     ✓ Delete resource group                                       ║
║     ✗ Manage access at subscription level                        ║
║                                                                    ║
║ STORAGE ACCOUNT: storagerbaclab (Most specific):                  ║
║   Role: Storage Blob Data Contributor                            ║
║   Permissions:                                                     ║
║     ✓ Read blobs                                                  ║
║     ✓ Write/delete blobs                                          ║
║     ✓ Manage blob access                                          ║
║     ✗ Delete storage account (needs higher role)                 ║
║                                                                    ║
║ INHERITANCE RULE:                                                  ║
║   More specific scope = More applicable/limiting permissions      ║
║   Storage assignment > RG assignment > Subscription assignment    ║
║                                                                    ║
║ Status: ✅ PERMISSIONS VERIFIED                                    ║
╚════════════════════════════════════════════════════════════════════╝
```

### Verification Checklist

- [ ] Can see all 3 assignments in "Check access" results
- [ ] Understand which are direct vs. inherited
- [ ] Recognize that more specific scope provides more specific permissions
- [ ] Can explain why "Contributor" at RG level is more powerful than "Reader" at subscription
- [ ] Understand inheritance hierarchy
- [ ] No errors when checking access

### Key Concepts Verified

```
✅ Role Assignment Scope Hierarchy:
   Subscription (broadest, least privilege)
        ↓ (inherited to)
   Resource Group (medium scope)
        ↓ (inherited to)
   Resource (most specific, most control)

✅ Permission Precedence:
   More specific scope = Overrides broader scopes
   Example: Contributor at RG > Reader at subscription

✅ Assignment Types:
   Direct: Assigned directly at that scope
   Inherited: Assigned at parent scope, flows down

✅ Access Control Logic:
   Effective permissions = All roles at all scopes + most permissive
```

---

## 📝 Exercise 2.3: Create Custom Role

### Objective
Create a custom role named "VM Operator" that allows users to start, stop, and restart VMs without other permissions.

### Duration
45 minutes

### Prerequisites
- ✅ Owner or User Access Administrator role
- ✅ Completed Exercise 2.2
- ✅ Permissions to create custom roles at subscription level

### Step-by-Step Instructions

#### Method 1: Using Azure Portal (Advanced)

**Note:** Azure Portal doesn't have direct custom role creation UI. Use PowerShell instead (Method 2).

#### Method 2: Using PowerShell (Recommended)

**Step 1: Connect to Azure**

```powershell
Connect-AzAccount
$subscriptionId = (Get-AzContext).Subscription.Id
```

**Step 2: Create Role Definition JSON**

```powershell
# Define custom role
$customRoleDef = @{
    Name = "VM Operator"
    IsCustom = $true
    Description = "Allows start, stop, and restart of VMs but cannot create or delete"
    Actions = @(
        "Microsoft.Compute/virtualMachines/start/action",
        "Microsoft.Compute/virtualMachines/stop/action",
        "Microsoft.Compute/virtualMachines/restart/action",
        "Microsoft.Compute/virtualMachines/read",
        "Microsoft.Resources/subscriptions/resourceGroups/read"
    )
    NotActions = @()
    AssignableScopes = @(
        "/subscriptions/$subscriptionId"
    )
}

# Convert to JSON
$roleJson = @{
    Name                 = $customRoleDef.Name
    IsCustom             = $true
    Description          = $customRoleDef.Description
    Actions              = $customRoleDef.Actions
    NotActions           = $customRoleDef.NotActions
    AssignableScopes     = $customRoleDef.AssignableScopes
} | ConvertTo-Json -Depth 10

Write-Host "Role Definition:`n$roleJson"
```

**Step 3: Create the Custom Role**

```powershell
# Create custom role
$role = New-AzRoleDefinition -InputObject (ConvertFrom-Json $roleJson)

Write-Host "✅ Custom role created successfully!" -ForegroundColor Green
Write-Host "Role ID: $($role.Id)" -ForegroundColor Green
Write-Host "Role Name: $($role.Name)" -ForegroundColor Green
```

**Step 4: Verify Role Creation**

```powershell
# Get the custom role
$vmOperatorRole = Get-AzRoleDefinition -Name "VM Operator"

Write-Host "=== CUSTOM ROLE DETAILS ===" -ForegroundColor Cyan
Write-Host "Name: $($vmOperatorRole.Name)"
Write-Host "ID: $($vmOperatorRole.Id)"
Write-Host "Type: Custom"
Write-Host "Description: $($vmOperatorRole.Description)"
Write-Host "`nActions:"
$vmOperatorRole.Actions | ForEach-Object { Write-Host "  - $_" }
Write-Host "`nAssignable Scopes:"
$vmOperatorRole.AssignableScopes | ForEach-Object { Write-Host "  - $_" }
```

**Step 5: Assign Custom Role to User**

```powershell
# Get user
$userPrincipal = "john.smith@yourtenant.onmicrosoft.com"
$user = Get-AzADUser -Filter "userPrincipalName eq '$userPrincipal'"

# Assign VM Operator role at subscription level
New-AzRoleAssignment -ObjectId $user.Id `
                     -RoleDefinitionName "VM Operator" `
                     -Scope "/subscriptions/$subscriptionId"

Write-Host "✅ VM Operator role assigned to $userPrincipal" -ForegroundColor Green
```

### Expected Output

```
╔══════════════════════════════════════════════════════════════════════╗
║              CUSTOM ROLE CREATION - VM OPERATOR                      ║
╠══════════════════════════════════════════════════════════════════════╣
║                                                                      ║
║ Role Name: VM Operator                                               ║
║ Role ID: /subscriptions/{subId}/providers/Microsoft.Authorization/  ║
║          roleDefinitions/{roleId}                                   ║
║ Type: Custom (not built-in)                                          ║
║ Status: ✅ ACTIVE                                                     ║
║                                                                      ║
║ Permissions Included:                                                ║
║   ✓ Start VM                                                         ║
║   ✓ Stop VM                                                          ║
║   ✓ Restart VM                                                       ║
║   ✓ Read VM properties                                              ║
║   ✓ Read resource groups                                            ║
║                                                                      ║
║ Permissions Excluded (denied):                                       ║
║   ✗ Create VMs                                                       ║
║   ✗ Delete VMs                                                       ║
║   ✗ Modify VM settings                                              ║
║   ✗ Manage other resources                                          ║
║                                                                      ║
║ Assignable Scope: Subscription level                                ║
║                                                                      ║
║ Assignment: john.smith@yourtenant.onmicrosoft.com ✅               ║
║                                                                      ║
║ Status: ✅ CUSTOM ROLE READY FOR USE                                 ║
╚══════════════════════════════════════════════════════════════════════╝
```

### Verification Checklist

- [ ] Custom role created successfully (no errors)
- [ ] Role name: "VM Operator"
- [ ] Role type: Custom (not built-in)
- [ ] Actions include: start/action, stop/action, restart/action
- [ ] Role is assignable at subscription scope
- [ ] Role assigned to John Smith
- [ ] Can see custom role in portal (Role Definitions list)
- [ ] Can assign role to other users (testable)

### Advanced: Modifying Custom Roles

```powershell
# To update custom role (add more actions)
$vmOperatorRole = Get-AzRoleDefinition -Name "VM Operator"
$vmOperatorRole.Actions.Add("Microsoft.Compute/virtualMachines/deallocate/action")
Update-AzRoleDefinition -InputObject $vmOperatorRole

# To delete custom role (must unassign first)
Remove-AzRoleDefinition -Id $vmOperatorRole.Id -Force
```

---

## 📝 Exercise 2.4: Remove Access (Cleanup)

### Objective
Clean up by removing all test role assignments and the custom role created in previous exercises.

### Duration
15 minutes

### Prerequisites
- ✅ Completed Exercise 2.3 (custom role assigned)
- ✅ Owner or User Access Administrator role

### Step-by-Step Instructions

#### Method 1: Using Azure Portal

**Step 1: Remove RG-level Assignment**

```
1. Navigate to: Resource Groups > rg-rbac-lab
2. Click: "Access Control (IAM)"
3. Click: "Role assignments" tab
4. Find: "John Smith" with "Contributor" role
5. Click on the assignment
6. Click: "Delete" or remove button
7. Confirm deletion
```

**Step 2: Remove Storage Account-level Assignment**

```
1. Navigate to: Storage Accounts > storagerbaclab
2. Click: "Access Control (IAM)"
3. Find: "John Smith" with "Storage Blob Data Contributor"
4. Click: "Delete" or remove button
5. Confirm deletion
```

**Step 3: Remove Subscription-level Assignments**

```
1. Navigate to: Subscriptions > Your subscription
2. Click: "Access Control (IAM)"
3. Find all "John Smith" assignments (Reader, VM Operator)
4. Delete each assignment individually
5. Verify all removed
```

#### Method 2: Using PowerShell (Cleaner)

```powershell
# Connect to Azure
Connect-AzAccount

# Variables
$userPrincipal = "john.smith@yourtenant.onmicrosoft.com"
$resourceGroupName = "rg-rbac-lab"
$storageAccountName = "storagerbaclab"
$subscriptionId = (Get-AzContext).Subscription.Id

# Get user
$user = Get-AzADUser -Filter "userPrincipalName eq '$userPrincipal'"
$userId = $user.Id

# Remove all role assignments for this user
Write-Host "Removing all role assignments for $userPrincipal..." -ForegroundColor Yellow

# Get all assignments
$assignments = Get-AzRoleAssignment -ObjectId $userId

# Remove each assignment
foreach ($assignment in $assignments) {
    Remove-AzRoleAssignment -ObjectId $userId `
                           -RoleDefinitionName $assignment.RoleDefinitionName `
                           -Scope $assignment.Scope `
                           -Confirm:$false
    Write-Host "✓ Removed: $($assignment.RoleDefinitionName) at scope: $($assignment.Scope)"
}

Write-Host "`n✅ All role assignments removed!" -ForegroundColor Green

# Verify all assignments removed
$remaining = Get-AzRoleAssignment -ObjectId $userId
if ($remaining.Count -eq 0) {
    Write-Host "✅ Verification: No assignments remaining for user" -ForegroundColor Green
} else {
    Write-Host "⚠️ Warning: User still has $($remaining.Count) assignments" -ForegroundColor Yellow
}
```

**Step 4: Delete Custom Role**

```powershell
# Get custom role
$vmOperatorRole = Get-AzRoleDefinition -Name "VM Operator"

# Delete custom role
Remove-AzRoleDefinition -Id $vmOperatorRole.Id -Force

Write-Host "✅ Custom role 'VM Operator' deleted successfully" -ForegroundColor Green
```

### Expected Output

```
╔════════════════════════════════════════════════════════════════════╗
║                    CLEANUP COMPLETED                               ║
╠════════════════════════════════════════════════════════════════════╣
║                                                                    ║
║ Assignments Removed:                                               ║
║   ✓ Contributor (rg-rbac-lab scope)                               ║
║   ✓ Storage Blob Data Contributor (storagerbaclab scope)         ║
║   ✓ Reader (subscription scope)                                   ║
║   ✓ VM Operator (subscription scope)                              ║
║                                                                    ║
║ Custom Role Deleted:                                               ║
║   ✓ VM Operator (custom role removed from directory)             ║
║                                                                    ║
║ Test Resources Status:                                             ║
║   - rg-rbac-lab: ✓ Still exists (for other labs)                 ║
║   - storagerbaclab: ✓ Still exists (for other labs)              ║
║                                                                    ║
║ User Status: John Smith                                            ║
║   ✓ Has 0 role assignments now                                    ║
║   ✓ Cleanup complete                                              ║
║                                                                    ║
║ Status: ✅ ALL CLEANUP COMPLETED SUCCESSFULLY                      ║
╚════════════════════════════════════════════════════════════════════╝
```

### Verification Checklist

- [ ] All 4 role assignments removed for John Smith
- [ ] Custom role "VM Operator" deleted
- [ ] User shows 0 role assignments
- [ ] Portal confirms no test assignments remaining
- [ ] Test resources still exist (don't delete)
- [ ] No errors during cleanup

### Final Verification Script

```powershell
# Run this to verify complete cleanup
$user = Get-AzADUser -Filter "userPrincipalName eq 'john.smith@yourtenant.onmicrosoft.com'"
$assignments = Get-AzRoleAssignment -ObjectId $user.Id

Write-Host "CLEANUP VERIFICATION" -ForegroundColor Cyan
Write-Host "===================" -ForegroundColor Cyan
Write-Host "User: john.smith@yourtenant.onmicrosoft.com"
Write-Host "Total Assignments: $($assignments.Count)"

if ($assignments.Count -eq 0) {
    Write-Host "Status: ✅ CLEANUP SUCCESSFUL - No assignments found" -ForegroundColor Green
} else {
    Write-Host "Status: ⚠️ CLEANUP INCOMPLETE - Assignments still found:" -ForegroundColor Yellow
    $assignments | Format-Table RoleDefinitionName, Scope
}

# Check custom role deleted
$customRole = Get-AzRoleDefinition -Name "VM Operator" -ErrorAction SilentlyContinue
if ($null -eq $customRole) {
    Write-Host "Custom Role Status: ✅ VM Operator role deleted" -ForegroundColor Green
} else {
    Write-Host "Custom Role Status: ⚠️ VM Operator role still exists" -ForegroundColor Yellow
}
```

---

## 📊 Summary of All Exercises

| Exercise | Task | Time | Status |
|----------|------|------|--------|
| 2.1 | Assign Roles at Different Scopes | 45 min | ⬜ |
| 2.2 | Check Effective Permissions | 30 min | ⬜ |
| 2.3 | Create Custom Role | 45 min | ⬜ |
| 2.4 | Remove Access (Cleanup) | 15 min | ⬜ |
| **Total** | **All 4 exercises** | **2.75 hrs** | |

---

## ✅ Module Completion Verification

**Before moving to Module 3, verify:**

- [ ] Exercise 2.1 completed (all 3 role assignments created)
- [ ] Exercise 2.2 completed (understood effective permissions)
- [ ] Exercise 2.3 completed (custom role created and assigned)
- [ ] Exercise 2.4 completed (cleanup successful)
- [ ] All expected outputs verified
- [ ] Can explain RBAC concepts: Principal, Role, Scope
- [ ] Understand role inheritance and precedence
- [ ] No errors encountered

---

## 🎓 What You've Learned

After completing all 4 exercises, you understand:
1. How to assign roles at different scopes
2. How scope hierarchy works (subscription → RG → resource)
3. How to check effective permissions
4. How to create custom roles with specific permissions
5. RBAC model: Principal + Role + Scope
6. Role inheritance and permission precedence
7. Both Portal and PowerShell methods for RBAC management

---

**Excellent work! You're mastering Azure access control! Move to Module 3! 🚀**

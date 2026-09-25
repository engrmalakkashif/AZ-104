# Module 2: Manage Azure Identities and Governance - Part 2 (Access Control & RBAC)

**Day:** 2 | **Duration:** 5 hours | **Skill Domain:** Manage access to Azure resources (20-25%)

---

## 📚 Learning Objectives

By the end of this module, you will be able to:
- Understand Azure role-based access control (RBAC)
- Assign built-in Azure roles
- Manage role assignments at different scopes
- Interpret effective access assignments
- Implement least privilege access
- Troubleshoot access issues

---

## 📖 Theory & Concepts

### 2.1 Azure RBAC Fundamentals

**What is RBAC?**
- Role-Based Access Control for Azure resources
- Determines who has access to what resources
- Controls what actions users can perform
- Built on three key components: Security Principal, Role Definition, Scope

**RBAC Model Components:**
```
Security Principal (WHO) + Role Definition (WHAT) + Scope (WHERE) = Access
```

### 2.2 Security Principals

**Types of Security Principals:**

1. **User** - Individual with Microsoft Entra ID account
2. **Group** - Collection of users
3. **Service Principal** - Application identity for automation
4. **Managed Identity** - Service principal for Azure services (System or User-assigned)

**Example:**
```
User: john.smith@contoso.com
Service Principal: myApp-prod-sp
Managed Identity: myVM-identity
```

### 2.3 Role Definitions

**Built-in Roles (Common):**

| Role | Permissions | Use Case |
|------|-------------|----------|
| Owner | Full access to all resources | Administrative tasks |
| Contributor | Create/manage resources, no access assignment | Development teams |
| Reader | View resources only | Audit/monitoring roles |
| User Access Administrator | Manage role assignments only | Access governance |
| Virtual Machine Contributor | Manage VMs (not access) | VM administrators |
| Storage Account Contributor | Manage storage accounts | Storage admins |
| Key Vault Administrator | Full key vault management | Security teams |

**Custom Roles:**
- Create tailored roles for specific needs
- Define custom permissions (actions/not-actions)
- Assign like built-in roles

**Role Structure:**
```json
{
  "Name": "Virtual Machine Operator",
  "Id": "88d8e3c3-8684-4b8f-af2d-b123456789ab",
  "Type": "CustomRole",
  "Permissions": [
    {
      "Actions": [
        "Microsoft.Compute/virtualMachines/start/action",
        "Microsoft.Compute/virtualMachines/stop/action"
      ],
      "NotActions": [],
      "DataActions": [],
      "NotDataActions": []
    }
  ]
}
```

### 2.4 Scope Hierarchy

**Azure Scope Levels (Top to Bottom):**

```
Management Group (Root)
    ├── Subscription 1
    │   ├── Resource Group A
    │   │   ├── VM (Virtual Machine)
    │   │   └── Storage Account
    │   └── Resource Group B
    │       └── App Service
    └── Subscription 2
        └── Resource Group C
            └── Key Vault
```

**Scope Details:**

| Scope | Level | Example |
|-------|-------|---------|
| Management Group | Highest - Multiple subscriptions | /subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName} |
| Subscription | Entire subscription | /subscriptions/{subscriptionId} |
| Resource Group | Container for resources | /subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName} |
| Resource | Individual resource | /subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachines/{vmName} |

**Inheritance:**
- Access at Management Group level → inherited by all subscriptions
- Access at Subscription level → inherited by all resource groups
- Access at Resource Group level → inherited by all resources

### 2.5 Deny Assignments

**What is a Deny?**
- Explicitly blocks actions at specified scope
- Takes precedence over allow assignments
- Cannot be created by users (created by Azure)

**Example Scenarios:**
```
Allow: User can read all storage accounts
Deny: User cannot delete storage account "critical-data-sa"
Result: User can read but NOT delete that specific storage
```

### 2.6 Access Review & Compliance

**Why Access Reviews?**
- Verify access is still needed
- Remove unnecessary permissions
- Meet compliance requirements
- Reduce security risks

---

## 🔧 Lab Notes & Environment Setup

### Prerequisites
- Azure subscription
- Owner or User Access Administrator role
- Test user and resource group created

### Lab Preparation
```
Create test resources:
- Resource Group: "rg-rbac-lab"
- Storage Account: "storagerbaclab"
- Virtual Machine: "vmrbaclab"
```

---

## 💻 Lab Exercise 1: Implement RBAC and Role Assignments

### Exercise 2.1: Assign Built-in Roles at Different Scopes

**Objective:** Assign roles to users at subscription and resource group levels

**Scenario:**
```
- Jane (Dev Team Lead) → Contributor at Resource Group scope
- Bob (Storage Admin) → Storage Account Contributor at storage account scope
- Sarah (Auditor) → Reader at Subscription scope
```

**Steps for Jane (Contributor at RG level):**

1. **Navigate to Resource Group**
   ```
   Azure Portal → Resource Groups → rg-rbac-lab
   ```

2. **Add Role Assignment**
   - Click "Access Control (IAM)"
   - Click "Add" → "Add role assignment"
   - Role: "Contributor"
   - Assign access to: "User, group, or service principal"
   - Select members: jane@yourtenant.onmicrosoft.com
   - Click "Review + Assign"

3. **Verify Assignment**
   - View "Role assignments" tab
   - Confirm "Contributor" appears for jane@yourtenant.onmicrosoft.com

**Expected Output:**
```
✅ Role Assignment Created
Scope: /subscriptions/{subscriptionId}/resourcegroups/rg-rbac-lab
Principal: jane@yourtenant.onmicrosoft.com
Role: Contributor
Effective Date: Today
```

**Steps for Bob (Storage Contributor at storage account scope):**

1. **Navigate to Storage Account**
   ```
   Azure Portal → Storage Accounts → storagerbaclab
   ```

2. **Add Role Assignment**
   - Click "Access Control (IAM)"
   - Click "Add" → "Add role assignment"
   - Role: "Storage Account Contributor"
   - Select members: bob@yourtenant.onmicrosoft.com
   - Click "Review + Assign"

**Expected Output:**
```
✅ Role Assignment Created
Scope: /subscriptions/{subscriptionId}/resourcegroups/rg-rbac-lab/providers/Microsoft.Storage/storageAccounts/storagerbaclab
Principal: bob@yourtenant.onmicrosoft.com
Role: Storage Account Contributor
```

**Steps for Sarah (Reader at Subscription level):**

1. **Navigate to Subscriptions**
   ```
   Azure Portal → Subscriptions → Your Subscription
   ```

2. **Add Role Assignment**
   - Click "Access Control (IAM)"
   - Click "Add" → "Add role assignment"
   - Role: "Reader"
   - Select members: sarah@yourtenant.onmicrosoft.com
   - Click "Review + Assign"

**Expected Output:**
```
✅ Role Assignment Created
Scope: /subscriptions/{subscriptionId}
Principal: sarah@yourtenant.onmicrosoft.com
Role: Reader
Inheritance: All resource groups and resources
```

---

### Exercise 2.2: Review Effective Access

**Objective:** Check what permissions users actually have

**Steps:**

1. **Navigate to Resource Group IAM**
   ```
   rg-rbac-lab → Access Control (IAM)
   ```

2. **Check Effective Permissions**
   - Click "Check access" tab
   - Enter user name: jane@yourtenant.onmicrosoft.com
   - View list of all permissions Jane has (from all scopes above)

3. **Document Results**
   - Take note of inherited permissions
   - Identify direct and inherited roles

**Expected Output:**
```
✅ Effective Access for jane@yourtenant.onmicrosoft.com:

Direct Assignments:
- Contributor (rg-rbac-lab resource group)

Inherited Assignments:
- (None, if no subscription/management group roles)

Effective Permissions:
- Create resources in this RG
- Modify existing resources
- Delete resources in this RG
- Cannot assign roles
```

---

### Exercise 2.3: Create a Custom Role

**Objective:** Create a custom role for VM operators (start/stop only)

**Steps:**

1. **Navigate to Custom Roles**
   ```
   Any Resource → Access Control (IAM) → Roles
   Click "Create a custom role"
   ```

2. **Configure Custom Role**
   - Name: "VM Operator"
   - Description: "Can start, stop, and restart VMs"
   - Base-in role: Start with "Virtual Machine Contributor"
   - Or click "Next" to start from scratch

3. **Add Permissions**
   - Click "Add permissions"
   - Search: "Microsoft.Compute/virtualMachines"
   - Select actions:
     ```
     ✓ Microsoft.Compute/virtualMachines/start/action
     ✓ Microsoft.Compute/virtualMachines/powerOff/action
     ✓ Microsoft.Compute/virtualMachines/restart/action
     ✓ Microsoft.Compute/virtualMachines/read
     ```
   - Remove delete actions if present

4. **Review and Create**
   - Click "Review + Create"
   - Click "Create"

**Expected Output:**
```
✅ Custom Role Created
Name: VM Operator
Type: CustomRole
Assignable Scopes: /subscriptions/{subscriptionId}
Permissions:
  - start/action
  - powerOff/action
  - restart/action
  - read
```

---

### Exercise 2.4: Remove Access (Cleanup)

**Objective:** Remove an unnecessary role assignment

**Steps:**

1. **Navigate to IAM**
   ```
   rg-rbac-lab → Access Control (IAM)
   ```

2. **Find and Remove Assignment**
   - Click "Role assignments" tab
   - Find bob@yourtenant.onmicrosoft.com
   - Click "Remove" (three dots menu)
   - Confirm removal

**Expected Output:**
```
✅ Role Assignment Removed
Principal: bob@yourtenant.onmicrosoft.com
Previous Role: Storage Account Contributor
Status: Removed
```

---

## 📋 Quick Reference - PowerShell Commands

```powershell
# Connect to Azure
Connect-AzAccount

# Get all role definitions
Get-AzRoleDefinition | Select-Object Name, Id | Head -10

# Get specific role
Get-AzRoleDefinition -Name "Contributor"

# Get all role assignments for a resource group
Get-AzRoleAssignment -ResourceGroupName "rg-rbac-lab"

# Assign role to user
New-AzRoleAssignment -ObjectId "user-object-id" `
                     -RoleDefinitionName "Contributor" `
                     -ResourceGroupName "rg-rbac-lab"

# Get effective permissions for a user
Get-AzRoleAssignment -SignInName "jane@yourtenant.onmicrosoft.com"

# Create custom role
$role = Get-AzRoleDefinition -Name "Virtual Machine Contributor"
$role.Id = $null
$role.Name = "VM Operator"
$role.Description = "Can start, stop, restart VMs"
$role.AssignableScopes = @("/subscriptions/{subscriptionId}")
New-AzRoleDefinition -Role $role

# Remove role assignment
Remove-AzRoleAssignment -ObjectId "user-object-id" `
                        -RoleDefinitionName "Storage Account Contributor" `
                        -ResourceName "storagerbaclab" `
                        -ResourceType "Microsoft.Storage/storageAccounts"
```

---

## ✅ Quick Fact Check

- [ ] Understand RBAC model (Principal + Role + Scope)
- [ ] Know difference between built-in and custom roles
- [ ] Understand scope hierarchy and inheritance
- [ ] Can assign roles at different scopes
- [ ] Know how to check effective permissions
- [ ] Understand least privilege principle

---

## 📝 Lab Summary Table

| Exercise | Scenario | Role | Scope | Status |
|----------|----------|------|-------|--------|
| 2.1a | Jane (Dev) | Contributor | Resource Group | ⬜ |
| 2.1b | Bob (Storage) | Storage Contributor | Storage Account | ⬜ |
| 2.1c | Sarah (Audit) | Reader | Subscription | ⬜ |
| 2.2 | Check Jane's access | N/A | Multi-level | ⬜ |
| 2.3 | VM Operator role | Custom | Subscription | ⬜ |
| 2.4 | Remove Bob's access | N/A | Storage Account | ⬜ |

---

## 🎯 Key Takeaways

1. **RBAC = Security Principal + Role Definition + Scope**
   - Always define all three components clearly

2. **Scope Inheritance is Critical**
   - Assignment at Management Group → flows to all subscriptions
   - Assignment at Subscription → flows to all resource groups
   - Assignment at Resource Group → flows to all resources

3. **Least Privilege Principle**
   - Assign minimum permissions needed
   - Use specific scopes (resource level when possible)
   - Regularly review and audit access

4. **Built-in vs. Custom Roles**
   - Use built-in roles for common scenarios (Contributor, Reader, Owner)
   - Create custom roles only for specific business needs

5. **Regular Access Reviews**
   - Remove unused assignments
   - Verify access is still necessary
   - Document who has what access

---

## 🔍 Common Scenarios

### Scenario 1: Developer Team Setup
```
Dev Team (Group) → Contributor at RG-Dev scope
Finance (Group) → Reader at subscription scope
DB Admin → SQL DB Contributor at Database scope
```

### Scenario 2: Principle of Least Privilege
```
❌ NOT RECOMMENDED: Owner at subscription level for all developers
✅ RECOMMENDED: Contributor at specific resource group level for dev team
✅ RECOMMENDED: Storage Blob Data Contributor only for data team
```

### Scenario 3: Service Principal Access
```
App Service Managed Identity → 
  - Storage Account Contributor (for data access)
  - Key Vault Secrets User (for connection strings)
```

---

## 📚 Additional Resources

- [Azure RBAC Documentation](https://learn.microsoft.com/en-us/azure/role-based-access-control/overview)
- [Built-in Azure Roles](https://learn.microsoft.com/en-us/azure/role-based-access-control/built-in-roles)
- [Create Custom Roles](https://learn.microsoft.com/en-us/azure/role-based-access-control/custom-roles)
- [Best Practices for RBAC](https://learn.microsoft.com/en-us/azure/role-based-access-control/best-practices)
- [RBAC Troubleshooting](https://learn.microsoft.com/en-us/azure/role-based-access-control/troubleshooting)

---

## 📊 Self-Assessment

**Rate your understanding (1-5):**
- RBAC fundamentals (Principal + Role + Scope): __ / 5
- Built-in role types and permissions: __ / 5
- Scope hierarchy and inheritance: __ / 5
- Assigning roles at different scopes: __ / 5
- Creating custom roles: __ / 5
- Checking effective permissions: __ / 5

---

**Next Module:** Manage Azure Subscriptions and Governance (Azure Policy, Locks, Tags)

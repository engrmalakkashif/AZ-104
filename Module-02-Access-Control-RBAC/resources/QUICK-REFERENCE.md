# Module 2: RBAC & Access Control - Quick Reference Guide

**Quick lookup for common RBAC operations, built-in roles, and troubleshooting**

---

## 🎯 RBAC Model at a Glance

```
RBAC = Security Principal + Role Definition + Scope

┌─────────────────────────────────────────────────────────────┐
│ WHO?                  WHAT?              WHERE?             │
│ ────────────────────────────────────────────────────────── │
│ User                  Contributor        Subscription       │
│ Group                 Reader              Resource Group    │
│ Service Principal     Owner               Resource          │
│ Managed Identity      Custom Role         Management Group  │
└─────────────────────────────────────────────────────────────┘

Result: User/Group has Contributor permissions on RG "sales-rg"
```

---

## 📊 Scope Hierarchy

```
Management Group (Broadest scope)
    ↓ (assignments inherited)
Subscription
    ↓ (assignments inherited)
Resource Group
    ↓ (assignments inherited)
Resource (Most specific)

Key Principle: More specific scope = Overrides broader scopes
Example: VM role at Resource > RG role at Resource Group > Subscription role
```

---

## 🔑 Built-in Roles Cheat Sheet

### Subscription-Level Roles

| Role | Use Case | Key Permissions |
|------|----------|-----------------|
| **Owner** | Full admin | Create, modify, delete, assign roles |
| **Contributor** | Full access (no roles) | Create, modify, delete (but not assign RBAC) |
| **User Access Administrator** | RBAC management | Assign and remove roles (but not create resources) |
| **Reader** | Read-only | View all resources (no modify) |
| **Monitoring Reader** | View metrics | Read monitoring data |

### Resource-Level Roles

| Role | Service | Key Permissions |
|------|---------|-----------------|
| **Virtual Machine Contributor** | VMs | Create, modify, manage VMs (not access) |
| **Virtual Machine User Login** | VMs | Login to VMs as regular user |
| **Storage Blob Data Contributor** | Storage | Read, write, delete blobs |
| **Storage Blob Data Reader** | Storage | Read blobs only |
| **Storage Account Contributor** | Storage | Manage storage accounts |
| **Cosmos DB Account Reader** | Cosmos DB | Read account data |
| **SQL Server Contributor** | SQL | Manage SQL servers (not access) |
| **App Service Contributor** | App Service | Manage app services |
| **Website Contributor** | Web Apps | Manage web app resources |

### Data vs. Management Plane

```
Management Plane (Control Plane):
  - Create/delete resources
  - Modify configurations
  - Assign access
  Roles: Contributor, Owner, VM Contributor

Data Plane (Access Plane):
  - Read/write actual data
  - Access data in storage/databases
  Roles: Storage Blob Data Reader/Contributor

Example: 
  - Contributor at RG level = can manage VM (management)
  - VM User Login = can login to VM and access OS (data)
```

---

## ⚡ Quick Commands

### Check Access
```bash
# Who has what role?
az role assignment list --query "[].{assignee:principalName, role:roleDefinitionName}"

# What roles does user have?
az role assignment list --assignee john.smith@contoso.com

# What access to specific resource?
az role assignment list --scope /subscriptions/{subId}/resourceGroups/rg-name
```

### Assign Access
```bash
# Grant Contributor role to user at RG level
az role assignment create --assignee john.smith@contoso.com \
                          --role Contributor \
                          --resource-group rg-name

# Grant Reader at subscription level
az role assignment create --assignee john.smith@contoso.com \
                          --role Reader \
                          --scope /subscriptions/{subscriptionId}
```

### Remove Access
```bash
# Remove Contributor role from user
az role assignment delete --assignee john.smith@contoso.com \
                          --role Contributor \
                          --resource-group rg-name
```

---

## 🎯 Common RBAC Patterns

### Pattern 1: Developer Access
```
WHO: Dev-Team group
WHAT: Contributor role (can create/modify resources)
WHERE: Development resource group only
Result: Team can self-serve in dev environment
```

**Command:**
```powershell
$group = Get-AzADGroup -Filter "displayName eq 'Dev-Team'"
New-AzRoleAssignment -ObjectId $group.Id `
                     -RoleDefinitionName "Contributor" `
                     -ResourceGroupName "rg-dev"
```

### Pattern 2: Limited VM Management
```
WHO: Operations team
WHAT: VM Operator (custom role: start/stop/restart only)
WHERE: Production resource group
Result: Team can manage VMs but cannot delete/create
```

**PowerShell:**
```powershell
$role = Get-AzRoleDefinition -Name "VM Operator"
New-AzRoleAssignment -ObjectId $user.Id `
                     -RoleDefinitionName "VM Operator" `
                     -ResourceGroupName "rg-prod"
```

### Pattern 3: Storage Data Access
```
WHO: Data analyst user
WHAT: Storage Blob Data Reader (read blobs only)
WHERE: Analytics storage account only
Result: User can read data but cannot modify
```

**Command:**
```powershell
New-AzRoleAssignment -ObjectId $user.Id `
                     -RoleDefinitionName "Storage Blob Data Reader" `
                     -Scope $storageAccount.Id
```

### Pattern 4: Full Application Access
```
WHO: App Service Managed Identity
WHAT: Multiple roles (Storage, SQL, Cosmos)
WHERE: Multiple resources
Result: App can access all required services
```

**PowerShell:**
```powershell
$sp = Get-AzADServicePrincipal -DisplayName "MyApp"

# Storage access
New-AzRoleAssignment -ObjectId $sp.Id `
                     -RoleDefinitionName "Storage Blob Data Contributor" `
                     -Scope $storageAccount.Id

# Database access
New-AzRoleAssignment -ObjectId $sp.Id `
                     -RoleDefinitionName "SQL DB Contributor" `
                     -Scope $database.Id
```

---

## ⚠️ Important Rules & Best Practices

### ✅ DO

- [ ] Use groups instead of individual user assignments
- [ ] Assign roles at most specific scope (Resource, not Subscription)
- [ ] Use built-in roles when possible
- [ ] Regularly audit who has what access
- [ ] Remove access when no longer needed
- [ ] Use managed identities for applications
- [ ] Enable PIM (Privileged Identity Management) for Admin roles
- [ ] Document why each role assignment exists

### ❌ DON'T

- [ ] Assign Owner role to users (use Contributor + UAA separately)
- [ ] Assign roles at subscription level to regular users (too broad)
- [ ] Create custom roles when built-in role exists
- [ ] Leave test users with permanent access
- [ ] Assign roles without business justification
- [ ] Forget to remove access during offboarding
- [ ] Use shared accounts/service principals without audit
- [ ] Assign broadly if specific role exists (principle of least privilege)

### Principle of Least Privilege

```
NOT THIS:                    DO THIS:
┌────────────────┐          ┌────────────────┐
│ User: Owner    │  ----→   │ Role: Reader   │
│ Scope: Sub     │          │ Scope: App RG  │
│ Can do: ALL    │          │ Can do: VIEW   │
└────────────────┘          └────────────────┘

Too much access             Just enough access
```

---

## 🔍 Role Comparison Table

| Scenario | Use This | NOT This | Why |
|----------|----------|----------|-----|
| Allow team to manage VMs | Virtual Machine Contributor | Owner | Less privileged |
| Allow user to read data | Storage Blob Data Reader | Contributor | Least privilege |
| Allow dev team self-serve | Contributor (at RG level) | Owner (at subscription) | More specific scope |
| Allow data scientist access | Storage Blob Data Reader | Owner | Only needs read |
| Allow admin RBAC management | User Access Administrator | Owner | Specific task |
| Allow read-only auditor | Reader | Contributor | No modify needed |

---

## 🐛 Troubleshooting Guide

### "You don't have permission..."

**Problem:** Getting "Insufficient privileges" when trying to assign roles

**Causes & Solutions:**
```
1. Don't have User Access Administrator role
   → Request role from current subscription owner
   
2. Trying to assign role you don't have
   → Can only assign roles you already have
   
3. Role assignment at wrong scope
   → Verify you have admin at that specific scope
   
4. Service principal doesn't have permissions
   → Check managed identity has required role
```

**Verification:**
```powershell
# Check your current roles
Get-AzRoleAssignment -ObjectId (Get-AzADUser -Filter "userPrincipalName eq '$($context.Account.Id)").Id

# If you see "Owner" or "User Access Administrator" - you can assign roles
```

---

### "Role not appearing in dropdown"

**Problem:** Can't find role when creating assignment

**Causes & Solutions:**
```
1. Role name typed incorrectly
   → Use Get-AzRoleDefinition to find exact name
   
2. Searching in wrong scope
   → Some roles only available at certain scopes
   
3. Browser cache issue
   → Refresh page (F5 or Ctrl+Shift+R)
   
4. Role is custom and hidden
   → Filter shows custom roles separately
```

**Verification:**
```powershell
# List all available roles
Get-AzRoleDefinition | Select-Object Name | Sort-Object Name

# Search for specific role
Get-AzRoleDefinition -Name "*Storage*" | Select-Object Name
```

---

### "User still has access after removing role"

**Problem:** User can still perform actions after role was deleted

**Causes & Solutions:**
```
1. Role assigned at multiple scopes
   → Check subscription + RG + resource levels
   
2. Assigned through group membership
   → Check if user is in group with role
   
3. Inherited from higher scope
   → Role at subscription level affects RG level
   
4. Cached permissions in portal
   → Wait 5-10 minutes or logout/login
```

**Verification:**
```powershell
# Check all assignments for user
Get-AzRoleAssignment -ObjectId $user.Id -IncludeInherited | 
    Format-Table RoleDefinitionName, Scope

# Check group memberships
Get-AzADUserMembership -ObjectId $user.Id | 
    Select-Object DisplayName, GroupTypes
```

---

### "Custom role can't be deleted"

**Problem:** "Can't delete - role has active assignments"

**Solution:**
```
Custom roles CANNOT be deleted if assigned to principals.

Steps to delete:
1. Find all assignments for this role
2. Remove each assignment
3. Then delete the role

PowerShell:
$role = Get-AzRoleDefinition -Name "VM Operator"
Get-AzRoleAssignment -RoleDefinitionId $role.Id | 
    Remove-AzRoleAssignment
Remove-AzRoleDefinition -Id $role.Id
```

---

## 📋 Role Assignment Checklist

Before assigning a role, verify:

- [ ] **Principal exists** - User/group/service principal already created
- [ ] **Have admin rights** - You have Owner or User Access Administrator at target scope
- [ ] **Correct role** - Verified role name with Get-AzRoleDefinition
- [ ] **Right scope** - Subscription/RG/resource most appropriate
- [ ] **Least privilege** - No more permissions than necessary
- [ ] **Business justification** - Why does this principal need this role?
- [ ] **Document assignment** - Record who, what, where, why
- [ ] **No duplicates** - Not already assigned somewhere else
- [ ] **Test access** - Verify user can do expected actions
- [ ] **Remove when done** - Set reminder to remove test assignments

---

## 📊 RBAC Operations Summary

```
╔════════════════════════════════════════════════════════════╗
║           MOST COMMON RBAC OPERATIONS                      ║
╠════════════════════════════════════════════════════════════╣
║                                                            ║
║ 1. VIEW ROLE ASSIGNMENTS                                  ║
║    Portal: Resource → IAM → Role assignments             ║
║    PS: Get-AzRoleAssignment -ObjectId $user.Id           ║
║                                                            ║
║ 2. ASSIGN ROLE                                             ║
║    Portal: Resource → IAM → +Add → Role assignment       ║
║    PS: New-AzRoleAssignment -ObjectId $user.Id ...       ║
║                                                            ║
║ 3. REMOVE ROLE                                             ║
║    Portal: Resource → IAM → Select role → Delete         ║
║    PS: Remove-AzRoleAssignment -ObjectId $user.Id ...    ║
║                                                            ║
║ 4. CHECK PERMISSIONS                                       ║
║    Portal: Resource → IAM → Check access                 ║
║    PS: Get-AzRoleAssignment -ObjectId $user.Id -Inc...  ║
║                                                            ║
╚════════════════════════════════════════════════════════════╝
```

---

## 🎓 Key Concepts Recap

| Concept | Meaning | Example |
|---------|---------|---------|
| **Principal** | WHO gets access | User john.smith@contoso.com |
| **Role** | WHAT they can do | Reader (view), Contributor (modify) |
| **Scope** | WHERE they can do it | Resource group or storage account |
| **Assignment** | The connection | john.smith has Contributor on sales-rg |
| **Inheritance** | Child gets parent role | RG role applies to all resources in it |
| **Delegation** | Can assign others | User Access Administrator can assign |
| **Custom Role** | User-defined permissions | VM Operator (start/stop only) |

---

## 🚀 Next Steps

After mastering RBAC:
1. ✅ Practice role assignments in test environment
2. ✅ Create custom role for your organization
3. ✅ Audit current role assignments
4. ✅ Implement principle of least privilege
5. ✅ Set up Azure PIM for admin roles
6. ✅ Document RBAC strategy for your tenant
7. ✅ Move to Module 3: Subscriptions & Governance

---

**You've mastered RBAC fundamentals! Keep practicing! 🎯**


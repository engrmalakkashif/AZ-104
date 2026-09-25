# Module 2: RBAC & Access Control - PowerShell Commands Reference
# 50+ Essential PowerShell Commands for Managing Azure Access Control
# Last Updated: 2025
# Usage: Copy and paste individual commands or blocks into PowerShell ISE

# ============================================================================
# 1. AUTHENTICATION & CONNECTION
# ============================================================================

# Connect to Azure Account
Connect-AzAccount

# Connect to specific tenant (if multiple)
Connect-AzAccount -Tenant "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"

# Get current context
Get-AzContext

# List all subscriptions
Get-AzSubscription

# Set specific subscription
Set-AzContext -SubscriptionId "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"

# Disconnect from Azure
Disconnect-AzAccount

# ============================================================================
# 2. USER & PRINCIPAL OPERATIONS
# ============================================================================

# Get specific user by UPN
$user = Get-AzADUser -Filter "userPrincipalName eq 'john.smith@contoso.com'"

# Get user by display name
$user = Get-AzADUser -Filter "displayName eq 'John Smith'"

# Get user by mail
$user = Get-AzADUser -Filter "mail eq 'john@contoso.com'"

# Get all users
Get-AzADUser | Select-Object Id, UserPrincipalName, DisplayName

# Get user with ID
$user = Get-AzADUser -ObjectId "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"

# Get user groups
Get-AzADUserMembership -ObjectId $user.Id

# Get user's direct reports
Get-AzADUserDirectReport -ObjectId $user.Id

# Get managed identity
Get-AzADServicePrincipal -Filter "displayName eq 'MyManagedIdentity'"

# ============================================================================
# 3. ROLE ASSIGNMENT - VIEWING
# ============================================================================

# Get all role assignments in subscription
Get-AzRoleAssignment

# Get role assignments for specific user
Get-AzRoleAssignment -ObjectId $user.Id

# Get role assignments at specific resource group
Get-AzRoleAssignment -ResourceGroupName "rg-rbac-lab"

# Get role assignments at specific resource
$vm = Get-AzVM -ResourceGroupName "rg-rbac-lab" -Name "myvm"
Get-AzRoleAssignment -Scope $vm.Id

# Get role assignments for specific role
Get-AzRoleAssignment -RoleDefinitionName "Contributor"

# Get role assignments with filter
$assignments = Get-AzRoleAssignment | Where-Object { $_.RoleDefinitionName -eq "Owner" }

# Get assignments with all details
Get-AzRoleAssignment | Format-Table DisplayName, RoleDefinitionName, Scope, CanDelegate

# Count total role assignments
(Get-AzRoleAssignment).Count

# Get assignments for service principal
Get-AzRoleAssignment -ObjectId (Get-AzADServicePrincipal -DisplayName "MyApp").Id

# ============================================================================
# 4. ROLE ASSIGNMENT - CREATING
# ============================================================================

# Assign role to user at resource group level
New-AzRoleAssignment -ObjectId $user.Id `
                     -RoleDefinitionName "Contributor" `
                     -ResourceGroupName "rg-rbac-lab"

# Assign role to user at subscription level
$subscriptionId = (Get-AzContext).Subscription.Id
New-AzRoleAssignment -ObjectId $user.Id `
                     -RoleDefinitionName "Reader" `
                     -Scope "/subscriptions/$subscriptionId"

# Assign role to user at resource level
$storageAccount = Get-AzStorageAccount -ResourceGroupName "rg-rbac-lab" -Name "mystorageacct"
New-AzRoleAssignment -ObjectId $user.Id `
                     -RoleDefinitionName "Storage Blob Data Contributor" `
                     -Scope $storageAccount.Id

# Assign role with condition (attribute-based access control)
$condition = "@Resource[Microsoft.Storage/storageAccounts/blobServices/containers/name] StringEquals 'admin-container'"
New-AzRoleAssignment -ObjectId $user.Id `
                     -RoleDefinitionName "Storage Blob Data Contributor" `
                     -Scope $storageAccount.Id `
                     -Condition $condition

# Assign role to group
$group = Get-AzADGroup -Filter "displayName eq 'Sales-Team'"
New-AzRoleAssignment -ObjectId $group.Id `
                     -RoleDefinitionName "Contributor" `
                     -ResourceGroupName "rg-rbac-lab"

# Assign role to service principal
$sp = Get-AzADServicePrincipal -DisplayName "MyApp"
New-AzRoleAssignment -ObjectId $sp.Id `
                     -RoleDefinitionName "Virtual Machine Contributor" `
                     -ResourceGroupName "rg-rbac-lab"

# Assign multiple roles to same user
$roles = "Reader", "Monitoring Reader"
foreach ($role in $roles) {
    New-AzRoleAssignment -ObjectId $user.Id `
                         -RoleDefinitionName $role `
                         -Scope "/subscriptions/$subscriptionId"
}

# ============================================================================
# 5. ROLE ASSIGNMENT - REMOVING
# ============================================================================

# Remove role assignment
Remove-AzRoleAssignment -ObjectId $user.Id `
                        -RoleDefinitionName "Contributor" `
                        -ResourceGroupName "rg-rbac-lab"

# Remove by object with confirmation
$assignment = Get-AzRoleAssignment | Where-Object { $_.RoleDefinitionName -eq "Owner" } | Select-Object -First 1
Remove-AzRoleAssignment -InputObject $assignment

# Remove without confirmation
Remove-AzRoleAssignment -ObjectId $user.Id `
                        -RoleDefinitionName "Reader" `
                        -Scope "/subscriptions/$subscriptionId" `
                        -Confirm:$false

# Remove all roles for user at resource group
Get-AzRoleAssignment -ObjectId $user.Id -ResourceGroupName "rg-rbac-lab" | 
    Remove-AzRoleAssignment

# Remove all roles for user across all scopes
Get-AzRoleAssignment -ObjectId $user.Id | 
    Remove-AzRoleAssignment -Confirm:$false

# ============================================================================
# 6. ROLE DEFINITIONS - BUILT-IN ROLES
# ============================================================================

# Get all built-in roles
Get-AzRoleDefinition | Where-Object { -not $_.IsCustom }

# Get specific built-in role
Get-AzRoleDefinition -Name "Contributor"

# Get role by ID
Get-AzRoleDefinition -Id "b24988ac-6180-42a0-ab88-20f7382dd24c"

# Get all roles with search
Get-AzRoleDefinition | Where-Object { $_.Name -like "*Reader*" }

# Get role actions
$role = Get-AzRoleDefinition -Name "Virtual Machine Contributor"
$role.Actions | Sort-Object

# Get role not-actions (denied actions)
$role.NotActions

# Get role data actions
$role.DataActions

# Get role data not-actions
$role.DataNotActions

# Get roles assigned at specific scope
Get-AzRoleDefinition -Scope "/subscriptions/$subscriptionId"

# List all storage-related roles
Get-AzRoleDefinition | Where-Object { $_.Name -like "*Storage*" }

# ============================================================================
# 7. CUSTOM ROLE DEFINITIONS
# ============================================================================

# Get all custom roles
Get-AzRoleDefinition | Where-Object { $_.IsCustom }

# Create custom role from built-in role
$role = Get-AzRoleDefinition -Name "Virtual Machine Contributor"
$role.Id = $null
$role.Name = "VM Operator"
$role.Description = "Allows start, stop, restart of VMs"
$role.Actions = @(
    "Microsoft.Compute/virtualMachines/start/action",
    "Microsoft.Compute/virtualMachines/stop/action",
    "Microsoft.Compute/virtualMachines/restart/action",
    "Microsoft.Compute/virtualMachines/read"
)
$role.NotActions = @()
$role.AssignableScopes = @("/subscriptions/$subscriptionId")
New-AzRoleDefinition -InputObject $role

# Create custom role with specific permissions
$roleDefinition = @{
    Name                 = "VM Operator"
    Description          = "Allows VM start/stop/restart"
    Actions              = @(
        "Microsoft.Compute/virtualMachines/start/action",
        "Microsoft.Compute/virtualMachines/stop/action",
        "Microsoft.Compute/virtualMachines/restart/action",
        "Microsoft.Compute/virtualMachines/read",
        "Microsoft.Resources/subscriptions/resourceGroups/read"
    )
    NotActions           = @()
    DataActions          = @()
    DataNotActions       = @()
    AssignableScopes     = @("/subscriptions/$subscriptionId")
} | ConvertTo-Json | ConvertFrom-Json

New-AzRoleDefinition -InputObject $roleDefinition

# Get custom role
$customRole = Get-AzRoleDefinition -Name "VM Operator"

# Update custom role
$customRole.Actions.Add("Microsoft.Compute/virtualMachines/deallocate/action")
Update-AzRoleDefinition -InputObject $customRole

# Delete custom role
Remove-AzRoleDefinition -Id $customRole.Id -Force

# List custom roles with assignments
foreach ($role in (Get-AzRoleDefinition | Where-Object { $_.IsCustom })) {
    $assignments = Get-AzRoleAssignment -RoleDefinitionId $role.Id
    Write-Output "Role: $($role.Name) - Assignments: $($assignments.Count)"
}

# ============================================================================
# 8. EFFECTIVE PERMISSIONS & ACCESS REVIEW
# ============================================================================

# Get all role assignments for user
$userId = $user.Id
Get-AzRoleAssignment -ObjectId $userId | 
    Format-Table DisplayName, RoleDefinitionName, Scope

# Get user's inherited permissions
Get-AzRoleAssignment -ObjectId $userId -IncludeInherited |
    Format-Table RoleDefinitionName, Scope, ResourceGroupName, ResourceName

# Check if user has specific permission
$assignments = Get-AzRoleAssignment -ObjectId $userId
$hasContributorRole = $assignments | Where-Object { $_.RoleDefinitionName -eq "Contributor" }

if ($hasContributorRole) {
    Write-Output "User has Contributor role"
} else {
    Write-Output "User does not have Contributor role"
}

# Get all permissions from role
$role = Get-AzRoleDefinition -Name "Contributor"
$role.Actions | ForEach-Object { Write-Output "  $_" }

# Find all users with Owner role
Get-AzRoleAssignment -RoleDefinitionName "Owner" | 
    Select-Object DisplayName, Scope

# Find all users with access to specific resource group
Get-AzRoleAssignment -ResourceGroupName "rg-rbac-lab" |
    Format-Table DisplayName, RoleDefinitionName

# Check role assignment at different scopes
$userAssignments = @{
    Subscription = (Get-AzRoleAssignment -ObjectId $userId -Scope "/subscriptions/$subscriptionId" -IncludeInherited).Count
    ResourceGroup = (Get-AzRoleAssignment -ObjectId $userId -ResourceGroupName "rg-rbac-lab").Count
    Resource = (Get-AzRoleAssignment -ObjectId $userId -Scope $vm.Id).Count
}
$userAssignments

# ============================================================================
# 9. BATCH OPERATIONS
# ============================================================================

# Assign same role to multiple users
$users = Get-AzADUser | Where-Object { $_.DisplayName -like "*Smith*" }
foreach ($user in $users) {
    New-AzRoleAssignment -ObjectId $user.Id `
                         -RoleDefinitionName "Reader" `
                         -ResourceGroupName "rg-rbac-lab" `
                         -Confirm:$false
}

# Assign multiple roles to single user
$roles = @("Reader", "Monitoring Reader")
foreach ($role in $roles) {
    New-AzRoleAssignment -ObjectId $user.Id `
                         -RoleDefinitionName $role `
                         -ResourceGroupName "rg-rbac-lab"
}

# Remove all assignments for multiple users
$users = Get-AzADUser | Where-Object { $_.DisplayName -like "*Test*" }
foreach ($user in $users) {
    Get-AzRoleAssignment -ObjectId $user.Id | 
        Remove-AzRoleAssignment -Confirm:$false
}

# Audit: Find all Owner role assignments
$owners = Get-AzRoleAssignment -RoleDefinitionName "Owner" | 
    Select-Object DisplayName, ObjectType, Scope
Write-Output "Total Owners: $($owners.Count)"
$owners | Format-Table

# ============================================================================
# 10. SCOPE OPERATIONS
# ============================================================================

# Get subscriptions
$subscriptions = Get-AzSubscription
$subscriptions | Format-Table

# Get resource groups
$resourceGroups = Get-AzResourceGroup
$resourceGroups | Format-Table Name, Location

# Get specific resource group
$rg = Get-AzResourceGroup -Name "rg-rbac-lab"

# Get resources in resource group
$resources = Get-AzResource -ResourceGroupName "rg-rbac-lab"
$resources | Format-Table

# Get specific resource
$vm = Get-AzVM -ResourceGroupName "rg-rbac-lab" -Name "myvm"

# Get resource ID
$resourceId = $vm.Id

# Get assignments at each scope level
Write-Output "=== SUBSCRIPTION LEVEL ==="
Get-AzRoleAssignment -Scope "/subscriptions/$subscriptionId" | Measure-Object

Write-Output "=== RESOURCE GROUP LEVEL ==="
Get-AzRoleAssignment -ResourceGroupName "rg-rbac-lab" | Measure-Object

Write-Output "=== RESOURCE LEVEL ==="
Get-AzRoleAssignment -Scope $vm.Id | Measure-Object

# ============================================================================
# 11. MANAGEMENT GROUP OPERATIONS
# ============================================================================

# Get all management groups
Get-AzManagementGroup

# Get specific management group
$mg = Get-AzManagementGroup -GroupName "MyMgmtGroup"

# Assign role at management group scope
New-AzRoleAssignment -ObjectId $user.Id `
                     -RoleDefinitionName "Reader" `
                     -Scope "/providers/Microsoft.Management/managementGroups/$($mg.Name)"

# Get assignments at management group scope
Get-AzRoleAssignment -Scope "/providers/Microsoft.Management/managementGroups/$($mg.Name)"

# ============================================================================
# 12. ADVANCED QUERIES & REPORTING
# ============================================================================

# Generate RBAC audit report
$report = Get-AzRoleAssignment | Select-Object @{
    Name = "Principal"
    Expression = { $_.DisplayName }
}, @{
    Name = "Type"
    Expression = { $_.ObjectType }
}, @{
    Name = "Role"
    Expression = { $_.RoleDefinitionName }
}, @{
    Name = "Scope"
    Expression = { $_.Scope }
}, @{
    Name = "CanDelegate"
    Expression = { $_.CanDelegate }
}
$report | Export-Csv -Path "C:\rbac-audit-report.csv" -NoTypeInformation

# Find users with privileges escalation capability
Get-AzRoleAssignment | 
    Where-Object { $_.RoleDefinitionName -in @("Owner", "User Access Administrator") } |
    Select-Object DisplayName, RoleDefinitionName, Scope

# Find all service principals with roles
Get-AzRoleAssignment | Where-Object { $_.ObjectType -eq "ServicePrincipal" } |
    Select-Object DisplayName, RoleDefinitionName, Scope

# Find all groups with roles
Get-AzRoleAssignment | Where-Object { $_.ObjectType -eq "Group" } |
    Select-Object DisplayName, RoleDefinitionName, Scope

# ============================================================================
# 13. DENIAL OF ASSIGNMENTS
# ============================================================================

# Get all deny assignments
Get-AzDenyAssignment

# Get deny assignments for user
Get-AzDenyAssignment -ObjectId $user.Id

# Get deny assignments at resource group
Get-AzDenyAssignment -ResourceGroupName "rg-rbac-lab"

# ============================================================================
# 14. ROLE ASSIGNMENT CONDITIONS (ABAC)
# ============================================================================

# Create role assignment with condition
$condition = "@Resource[Microsoft.Storage/storageAccounts/blobServices/containers/name] StringEquals 'data-container'"
New-AzRoleAssignment -ObjectId $user.Id `
                     -RoleDefinitionName "Storage Blob Data Reader" `
                     -Scope $storageAccount.Id `
                     -Condition $condition

# Create condition OR
$condition = "@Resource[Microsoft.Storage/storageAccounts/blobServices/containers/name] StringEquals 'data-container' OR @Resource[Microsoft.Storage/storageAccounts/blobServices/containers/name] StringEquals 'backup-container'"
New-AzRoleAssignment -ObjectId $user.Id `
                     -RoleDefinitionName "Storage Blob Data Contributor" `
                     -Scope $storageAccount.Id `
                     -Condition $condition

# ============================================================================
# 15. HELPER FUNCTIONS & UTILITIES
# ============================================================================

# Function: Get user's total permissions overview
function Get-UserPermissionsOverview {
    param(
        [string]$UserPrincipal
    )
    
    $user = Get-AzADUser -Filter "userPrincipalName eq '$UserPrincipal'"
    $assignments = Get-AzRoleAssignment -ObjectId $user.Id -IncludeInherited
    
    Write-Output "=== USER PERMISSIONS OVERVIEW ==="
    Write-Output "User: $UserPrincipal"
    Write-Output "Total Assignments: $($assignments.Count)"
    Write-Output ""
    Write-Output "Assignments by Scope:"
    
    $assignments | Group-Object -Property Scope | ForEach-Object {
        Write-Output "`n  Scope: $($_.Name)"
        $_.Group | ForEach-Object {
            Write-Output "    - $($_.RoleDefinitionName)"
        }
    }
}

# Usage:
# Get-UserPermissionsOverview -UserPrincipal "john.smith@contoso.com"

# Function: Find role by action
function Find-RoleByAction {
    param(
        [string]$Action
    )
    
    Get-AzRoleDefinition | Where-Object { 
        $_.Actions -like "*$Action*" -or $_.DataActions -like "*$Action*"
    }
}

# Usage:
# Find-RoleByAction -Action "Start"

# ============================================================================
# QUICK REFERENCE COMMANDS
# ============================================================================

# Most used commands:
Connect-AzAccount
Set-AzContext -SubscriptionId "subscription-id"
Get-AzADUser -Filter "userPrincipalName eq 'user@domain.com'"
Get-AzRoleAssignment -ObjectId $user.Id
New-AzRoleAssignment -ObjectId $user.Id -RoleDefinitionName "Contributor" -ResourceGroupName "rg-name"
Remove-AzRoleAssignment -ObjectId $user.Id -RoleDefinitionName "Reader" -Scope "/subscriptions/sub-id"
Get-AzRoleDefinition -Name "Contributor"


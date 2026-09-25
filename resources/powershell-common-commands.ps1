# ==========================================
# AZ-104 Common PowerShell Commands
# ==========================================

# Connect to Azure
Connect-AzAccount

# Get subscription info
Get-AzSubscription
Set-AzContext -SubscriptionId "subscription-id"

# List resource groups
Get-AzResourceGroup

# Create resource group
New-AzResourceGroup -Name "rg-name" -Location "eastus"

# Delete resource group
Remove-AzResourceGroup -Name "rg-name" -Force

# Get all resources in RG
Get-AzResource -ResourceGroupName "rg-name"

# Module 1: Users and Groups
Connect-MgGraph -Scopes "User.ReadWrite.All", "Group.ReadWrite.All"

# Create user
New-MgUser -DisplayName "John Smith" -UserPrincipalName "john.smith@tenant.onmicrosoft.com" -MailNickname "johnsmith" -PasswordProfile @{Password="TempPassword@123"; ForceChangePasswordNextSignIn=$true} -AccountEnabled

# Get users
Get-MgUser | Select-Object DisplayName, UserPrincipalName

# Create group
New-MgGroup -DisplayName "Sales-Team" -MailNickname "salesteam" -GroupTypes "Unified" -SecurityEnabled

# Module 2: RBAC
Get-AzRoleDefinition | Select-Object Name, Id

# Assign role
New-AzRoleAssignment -ObjectId "user-object-id" -RoleDefinitionName "Contributor" -ResourceGroupName "rg-name"

# Get role assignments
Get-AzRoleAssignment -ResourceGroupName "rg-name"

# Remove role assignment
Remove-AzRoleAssignment -ObjectId "user-object-id" -RoleDefinitionName "Contributor" -ResourceGroupName "rg-name"

# Module 3: Governance
Get-AzPolicyAssignment
Get-AzPolicyDefinition

# Apply lock
New-AzManagementLock -LockLevel CanNotDelete -LockName "lock-name" -ResourceGroupName "rg-name"

# Get locks
Get-AzManagementLock -ResourceGroupName "rg-name"

# Remove lock
Remove-AzManagementLock -LockName "lock-name" -ResourceGroupName "rg-name"

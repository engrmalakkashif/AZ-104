# Module 3: Subscriptions & Governance - PowerShell Commands Reference
# 50+ Essential PowerShell Commands for Azure Policies, Locks, Tags, and Management Groups
# Last Updated: 2025
# Usage: Copy and paste individual commands or blocks into PowerShell ISE

# ============================================================================
# 1. AUTHENTICATION & CONTEXT
# ============================================================================

# Connect to Azure
Connect-AzAccount

# Connect to specific tenant
Connect-AzAccount -Tenant "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"

# Get current context
Get-AzContext

# List all subscriptions
Get-AzSubscription

# Set specific subscription
Set-AzContext -SubscriptionId "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"

# Get subscription details
Get-AzSubscription -SubscriptionId "sub-id" | Format-List

# ============================================================================
# 2. POLICY - DEFINITIONS
# ============================================================================

# Get all policy definitions
Get-AzPolicyDefinition

# Get built-in policies
Get-AzPolicyDefinition -Builtin

# Get custom policies
Get-AzPolicyDefinition | Where-Object { -not $_.IsBuiltIn }

# Get specific policy by name
Get-AzPolicyDefinition -Name "Allowed Locations"

# Get policy by category
Get-AzPolicyDefinition | Where-Object { $_.Properties.metadata.category -eq "Compute" }

# Search policies by keyword
Get-AzPolicyDefinition | Where-Object { $_.Name -like "*storage*" }

# Get policy details
$policy = Get-AzPolicyDefinition -Name "Allowed Locations"
$policy | Format-List

# View policy rule
$policy.Properties.policyRule | ConvertTo-Json

# View policy parameters
$policy.Properties.parameters | ConvertTo-Json

# ============================================================================
# 3. POLICY - CREATING CUSTOM POLICIES
# ============================================================================

# Create simple location restriction policy
$policyRule = @{
    "if" = @{
        "allOf" = @(
            @{
                "field" = "type"
                "equals" = "Microsoft.Resources/subscriptions/resourceGroups"
            },
            @{
                "field" = "location"
                "notIn" = @("eastus", "westus")
            }
        )
    }
    "then" = @{
        "effect" = "deny"
    }
} | ConvertTo-Json -Depth 10

New-AzPolicyDefinition -Name "Allowed Locations Policy" `
                       -DisplayName "Restrict to US regions" `
                       -Description "Only allow resources in US regions" `
                       -Policy $policyRule `
                       -Mode "Indexed"

# Create tag requirement policy
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
                "description" = "Name of tag to require"
            }
        }
    }
} | ConvertTo-Json -Depth 10

New-AzPolicyDefinition -Name "Require Tags" `
                       -DisplayName "Require specified tag" `
                       -Description "Resources must have tag" `
                       -Policy $tagPolicy `
                       -Parameter '{"tagName":{"type":"String"}}' `
                       -Mode "All"

# Create storage account encryption policy
$encryptPolicy = @{
    "mode" = "All"
    "policyRule" = @{
        "if" = @{
            "allOf" = @(
                @{
                    "field" = "type"
                    "equals" = "Microsoft.Storage/storageAccounts"
                },
                @{
                    "field" = "Microsoft.Storage/storageAccounts/encryption.services.blob.enabled"
                    "notEquals" = "true"
                }
            )
        }
        "then" = @{
            "effect" = "deny"
        }
    }
} | ConvertTo-Json -Depth 10

New-AzPolicyDefinition -Name "Require Storage Encryption" `
                       -DisplayName "Storage must have encryption" `
                       -Description "Enforce encryption on storage accounts" `
                       -Policy $encryptPolicy `
                       -Mode "All"

# ============================================================================
# 4. POLICY - ASSIGNMENTS
# ============================================================================

# Get all policy assignments
Get-AzPolicyAssignment

# Get assignments at specific scope
Get-AzPolicyAssignment -Scope "/subscriptions/sub-id"

# Get assignments at resource group
Get-AzPolicyAssignment -ResourceGroupName "rg-name"

# Get specific policy assignment
Get-AzPolicyAssignment -Name "Enforce Locations"

# Assign policy to subscription
$subscriptionId = (Get-AzContext).Subscription.Id
$policyDef = Get-AzPolicyDefinition -Name "Allowed Locations Policy"

New-AzPolicyAssignment -Name "Enforce Locations" `
                       -DisplayName "Enforce Location Policy" `
                       -PolicyDefinition $policyDef `
                       -Scope "/subscriptions/$subscriptionId"

# Assign policy to resource group
New-AzPolicyAssignment -Name "Enforce Tags RG" `
                       -DisplayName "Enforce Tags at RG" `
                       -PolicyDefinition $policyDef `
                       -ResourceGroupName "rg-name"

# Assign policy with parameters
$policyDef = Get-AzPolicyDefinition -Name "Require Tags"
New-AzPolicyAssignment -Name "Require Environment Tag" `
                       -PolicyDefinition $policyDef `
                       -Scope "/subscriptions/$subscriptionId" `
                       -PolicyParameterObject @{"tagName"=@("Environment")}

# Assign policy with exclusions
$policyDef = Get-AzPolicyDefinition -Name "Allowed Locations Policy"
New-AzPolicyAssignment -Name "Enforce with Exclusions" `
                       -PolicyDefinition $policyDef `
                       -Scope "/subscriptions/$subscriptionId" `
                       -NotScopes "/subscriptions/$subscriptionId/resourceGroups/exempt-rg"

# ============================================================================
# 5. POLICY - COMPLIANCE & REVIEW
# ============================================================================

# Get policy compliance state
Get-AzPolicyStateSummary

# Get compliance for specific assignment
Get-PolicyComplianceState -SubscriptionId $subscriptionId

# Get non-compliant resources
Get-AzPolicyState | Where-Object { $_.ComplianceState -eq "NonCompliant" } | 
    Format-Table ResourceId, PolicyDefinitionName, ComplianceState

# Get compliance summary by policy
Get-AzPolicyState | Group-Object -Property PolicyDefinitionName | 
    Select-Object Name, Count, @{
        Name = "NonCompliant"
        Expression = { ($_.Group | Where-Object ComplianceState -eq "NonCompliant").Count }
    }

# Get policy events (audit log)
Get-AzPolicyEvent

# Evaluate resource compliance
Invoke-AzPolicyCompliance -AsJob

# ============================================================================
# 6. POLICY - UPDATE & DELETE
# ============================================================================

# Update policy definition
$policyDef = Get-AzPolicyDefinition -Name "Allowed Locations Policy"
$policyDef.Properties.description = "Updated description"
Set-AzPolicyDefinition -InputObject $policyDef

# Remove policy assignment
Remove-AzPolicyAssignment -Name "Enforce Locations"

# Remove policy assignment by scope
Get-AzPolicyAssignment -Scope "/subscriptions/$subscriptionId" | 
    Remove-AzPolicyAssignment

# Delete custom policy definition
Remove-AzPolicyDefinition -Name "Allowed Locations Policy" -Force

# ============================================================================
# 7. RESOURCE LOCKS - CREATE
# ============================================================================

# Create CanNotDelete lock on resource group
New-AzManagementLock -LockName "Protect-RG" `
                     -LockLevel "CanNotDelete" `
                     -ResourceGroupName "rg-name"

# Create ReadOnly lock on resource
$vm = Get-AzVM -ResourceGroupName "rg-name" -Name "vm-name"
New-AzManagementLock -LockName "Protect-VM" `
                     -LockLevel "ReadOnly" `
                     -ResourceId $vm.Id

# Create lock on resource via resource ID
New-AzManagementLock -LockName "Protect-Storage" `
                     -LockLevel "CanNotDelete" `
                     -ResourceId "/subscriptions/sub-id/resourceGroups/rg-name/providers/Microsoft.Storage/storageAccounts/storage-name"

# Create lock on subscription
New-AzManagementLock -LockName "Protect-Subscription" `
                     -LockLevel "ReadOnly" `
                     -Scope "/subscriptions/$subscriptionId"

# ============================================================================
# 8. RESOURCE LOCKS - VIEWING
# ============================================================================

# Get all locks in subscription
Get-AzManagementLock

# Get locks on resource group
Get-AzManagementLock -ResourceGroupName "rg-name"

# Get locks on specific resource
$vm = Get-AzVM -ResourceGroupName "rg-name" -Name "vm-name"
Get-AzManagementLock -ResourceId $vm.Id

# Get locks by scope
Get-AzManagementLock -Scope "/subscriptions/$subscriptionId"

# Find all CanNotDelete locks
Get-AzManagementLock | Where-Object { $_.LockLevel -eq "CanNotDelete" }

# Find all ReadOnly locks
Get-AzManagementLock | Where-Object { $_.LockLevel -eq "ReadOnly" }

# Count locks by type
Get-AzManagementLock | Group-Object -Property LockLevel | 
    Select-Object Name, Count

# ============================================================================
# 9. RESOURCE LOCKS - REMOVE
# ============================================================================

# Remove lock by name and resource group
Remove-AzManagementLock -LockName "Protect-RG" `
                        -ResourceGroupName "rg-name" `
                        -Force

# Remove lock by resource ID
$lock = Get-AzManagementLock -ResourceId $resourceId | Select-Object -First 1
Remove-AzManagementLock -LockId $lock.LockId -Force

# Remove all locks on resource group
Get-AzManagementLock -ResourceGroupName "rg-name" | 
    Remove-AzManagementLock -Force

# Remove specific lock by finding
$lock = Get-AzManagementLock -Scope "/subscriptions/$subscriptionId" | 
        Where-Object { $_.Name -eq "Protect-VM" }
Remove-AzManagementLock -LockId $lock.LockId -Force

# ============================================================================
# 10. TAGS - APPLY
# ============================================================================

# Get resource group
$rg = Get-AzResourceGroup -Name "rg-name"

# Add tags to resource group
$tags = @{
    "Environment" = "Production"
    "CostCenter" = "IT-001"
    "Owner" = "John Smith"
}
Update-AzTag -ResourceId $rg.ResourceId `
             -Tag $tags `
             -Operation Merge

# Add tags to resource
$storageAccount = Get-AzStorageAccount -ResourceGroupName "rg-name" -Name "storage-name"
Update-AzTag -ResourceId $storageAccount.Id `
             -Tag $tags `
             -Operation Merge

# Replace all tags (remove existing)
Update-AzTag -ResourceId $rg.ResourceId `
             -Tag @{"NewTag" = "Value"} `
             -Operation Replace

# Delete specific tags
Update-AzTag -ResourceId $rg.ResourceId `
             -Tag @{"OldTag" = $null} `
             -Operation Merge

# ============================================================================
# 11. TAGS - VIEWING & SEARCHING
# ============================================================================

# Get tags on resource group
$rg = Get-AzResourceGroup -Name "rg-name"
$rg.Tags

# Get tags on resource
$storage = Get-AzStorageAccount -ResourceGroupName "rg-name" -Name "storage-name"
$storage.Tags

# Find resources by tag
Get-AzResource -TagName "Environment" -TagValue "Production"

# Find resources by multiple tags
Get-AzResource | Where-Object {
    $_.Tags.Environment -eq "Production" -and 
    $_.Tags.Owner -eq "John Smith"
}

# Find all resources with specific tag (any value)
Get-AzResource -TagName "CostCenter" | 
    Select-Object Name, ResourceType, @{Name="CostCenter";Expression={$_.Tags.CostCenter}}

# List all tags in subscription
$allResources = Get-AzResource
$allTags = $allResources | ForEach-Object { $_.Tags.GetEnumerator() } | 
           Group-Object -Property Name
$allTags | Select-Object Name, Count

# ============================================================================
# 12. TAGS - BATCH OPERATIONS
# ============================================================================

# Add tags to all resources in resource group
Get-AzResource -ResourceGroupName "rg-name" | 
    ForEach-Object {
        Update-AzTag -ResourceId $_.Id `
                     -Tag @{"ReviewedBy" = "Admin"} `
                     -Operation Merge
    }

# Add tags to all VMs in resource group
Get-AzVM -ResourceGroupName "rg-name" | 
    ForEach-Object {
        Update-AzTag -ResourceId $_.Id `
                     -Tag @{"BackupSchedule" = "Daily"} `
                     -Operation Merge
    }

# Tag resources with cost center based on naming pattern
Get-AzResource | Where-Object { $_.Name -like "prod-*" } | 
    ForEach-Object {
        Update-AzTag -ResourceId $_.Id `
                     -Tag @{"CostCenter" = "Production"} `
                     -Operation Merge
    }

# ============================================================================
# 13. MANAGEMENT GROUPS - CREATE & ORGANIZE
# ============================================================================

# Create management group
New-AzManagementGroup -GroupName "prod-env" `
                      -DisplayName "Production Environment"

# Create child management group
New-AzManagementGroup -GroupName "prod-apps" `
                      -DisplayName "Production Apps" `
                      -ParentId "/providers/Microsoft.Management/managementGroups/prod-env"

# Get management group hierarchy
Get-AzManagementGroup -GroupName "prod-env" -Expand -Recurse

# Get all management groups
Get-AzManagementGroup

# Get specific management group
Get-AzManagementGroup -GroupName "prod-env"

# ============================================================================
# 14. MANAGEMENT GROUPS - SUBSCRIPTIONS
# ============================================================================

# Add subscription to management group
$subscription = Get-AzSubscription | Select-Object -First 1
New-AzManagementGroupSubscription -GroupName "prod-apps" `
                                  -SubscriptionId $subscription.Id

# Remove subscription from management group
Remove-AzManagementGroupSubscription -GroupName "prod-apps" `
                                     -SubscriptionId $subscription.Id

# Get subscriptions in management group
Get-AzManagementGroupSubscription -GroupName "prod-apps"

# Move subscription to different management group
$subscription = Get-AzSubscription | Select-Object -First 1
New-AzManagementGroupSubscription -GroupName "dev-env" `
                                  -SubscriptionId $subscription.Id

# ============================================================================
# 15. MANAGEMENT GROUPS - POLICIES
# ============================================================================

# Assign policy at management group level
$policyDef = Get-AzPolicyDefinition -Name "Allowed Locations Policy"
New-AzPolicyAssignment -Name "Enforce Locations Corp" `
                       -PolicyDefinition $policyDef `
                       -Scope "/providers/Microsoft.Management/managementGroups/prod-env"

# Get policy assignments at management group
Get-AzPolicyAssignment -Scope "/providers/Microsoft.Management/managementGroups/prod-env"

# ============================================================================
# 16. MANAGEMENT GROUPS - OPERATIONS
# ============================================================================

# Update management group
Update-AzManagementGroup -GroupName "prod-env" `
                         -DisplayName "Production Environment (Updated)"

# Delete management group (must be empty)
Remove-AzManagementGroup -GroupName "prod-apps"

# Get management group hierarchy in JSON
$mg = Get-AzManagementGroup -GroupName "prod-env" -Expand -Recurse
$mg | ConvertTo-Json -Depth 10

# ============================================================================
# 17. RESOURCE GROUPS
# ============================================================================

# Create resource group
New-AzResourceGroup -Name "rg-governance-lab" `
                    -Location "eastus"

# Get all resource groups
Get-AzResourceGroup

# Get specific resource group
Get-AzResourceGroup -Name "rg-governance-lab"

# Get resource group with tags
Get-AzResourceGroup -Name "rg-governance-lab" | 
    Select-Object Name, Location, Tags

# Move resource group to different subscription
Move-AzResourceGroup -DestinationSubscriptionId $destinationSubId `
                     -ResourceGroupName "rg-governance-lab"

# Delete resource group
Remove-AzResourceGroup -Name "rg-governance-lab" -Force

# ============================================================================
# 18. RESOURCES
# ============================================================================

# Get all resources
Get-AzResource

# Get resources in resource group
Get-AzResource -ResourceGroupName "rg-name"

# Get resource by type
Get-AzResource -ResourceType "Microsoft.Storage/storageAccounts"

# Get resources by name pattern
Get-AzResource | Where-Object { $_.Name -like "prod-*" }

# Get resource details
$resource = Get-AzResource -ResourceGroupName "rg-name" -Name "resource-name"
$resource | Format-List

# ============================================================================
# 19. COST MANAGEMENT & BUDGETS
# ============================================================================

# Create budget alert
New-AzConsumptionBudget -Name "Monthly Budget" `
                        -Category "Cost" `
                        -Limit 1000 `
                        -TimeGrain "Monthly" `
                        -StartDate "2025-01-01"

# Get budgets
Get-AzConsumptionBudget

# Get budget details
Get-AzConsumptionBudget -Name "Monthly Budget" | Format-List

# ============================================================================
# 20. HELPER FUNCTIONS & UTILITIES
# ============================================================================

# Function: Find all resources without required tags
function Find-UntaggedResources {
    param(
        [string[]]$RequiredTags
    )
    
    $untagged = @()
    $resources = Get-AzResource
    
    foreach ($resource in $resources) {
        $missingTags = @()
        foreach ($tag in $RequiredTags) {
            if (-not $resource.Tags -or -not $resource.Tags.ContainsKey($tag)) {
                $missingTags += $tag
            }
        }
        
        if ($missingTags.Count -gt 0) {
            $untagged += [PSCustomObject]@{
                ResourceName = $resource.Name
                ResourceType = $resource.ResourceType
                MissingTags = $missingTags -join ", "
            }
        }
    }
    
    return $untagged
}

# Usage:
# Find-UntaggedResources -RequiredTags @("Environment", "CostCenter", "Owner")

# Function: Get compliance report
function Get-ComplianceReport {
    $report = Get-AzPolicyState | Group-Object -Property PolicyDefinitionName | 
        Select-Object Name, Count, @{
            Name = "NonCompliant"
            Expression = { ($_.Group | Where-Object ComplianceState -eq "NonCompliant").Count }
        }, @{
            Name = "CompliantPercentage"
            Expression = { 
                $compliant = ($_.Group | Where-Object ComplianceState -eq "Compliant").Count
                [math]::Round(($compliant / $_.Count * 100), 2)
            }
        }
    
    return $report
}

# Usage:
# Get-ComplianceReport | Format-Table

# ============================================================================
# QUICK REFERENCE - MOST USED COMMANDS
# ============================================================================

# Governance Essentials:
Connect-AzAccount
Set-AzContext -SubscriptionId "sub-id"
New-AzPolicyDefinition -Name "policy-name" -Policy $policyRule -Mode "Indexed"
New-AzPolicyAssignment -Name "assignment-name" -PolicyDefinition $policyDef -Scope "/subscriptions/sub-id"
Get-AzPolicyState | Where-Object { $_.ComplianceState -eq "NonCompliant" }
New-AzManagementLock -LockName "lock-name" -LockLevel "CanNotDelete" -ResourceGroupName "rg-name"
Update-AzTag -ResourceId $resourceId -Tag @{"Key"="Value"} -Operation Merge
New-AzManagementGroup -GroupName "mg-name" -DisplayName "Display Name"


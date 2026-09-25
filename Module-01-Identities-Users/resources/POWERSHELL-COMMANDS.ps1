# Module 1: PowerShell Commands - Microsoft Entra Users & Groups
# ===========================================================

# ==========================================
# SETUP & AUTHENTICATION
# ==========================================

# Install required modules (run as admin)
Install-Module -Name Microsoft.Graph -Scope CurrentUser -Force

# Import module
Import-Module Microsoft.Graph

# Connect to Microsoft Graph
Connect-MgGraph -Scopes "User.ReadWrite.All", "Group.ReadWrite.All", "Directory.ReadWrite.All"

# Check current connection
Get-MgContext

# Disconnect when done
Disconnect-MgGraph


# ==========================================
# CREATE USERS
# ==========================================

# 1. Create a simple user
$PasswordProfile = @{
    Password = "TempPassword@12345"
    ForceChangePasswordNextSignIn = $true
}

New-MgUser -DisplayName "John Smith" `
           -UserPrincipalName "john.smith@yourtenant.onmicrosoft.com" `
           -MailNickname "johnsmith" `
           -PasswordProfile $PasswordProfile `
           -AccountEnabled


# 2. Create user with full profile
$PasswordProfile = @{
    Password = "TempPassword@12345"
    ForceChangePasswordNextSignIn = $true
}

New-MgUser -DisplayName "John Smith" `
           -UserPrincipalName "john.smith@yourtenant.onmicrosoft.com" `
           -MailNickname "johnsmith" `
           -PasswordProfile $PasswordProfile `
           -AccountEnabled `
           -JobTitle "Sales Manager" `
           -Department "Sales" `
           -OfficeLocation "New York" `
           -MobilePhone "+1-555-123-4567" `
           -CompanyName "Contoso Inc"


# 3. Create multiple users at once
$users = @(
    @{
        DisplayName     = "Jane Doe"
        UserPrincipalName = "jane.doe@yourtenant.onmicrosoft.com"
        Department      = "Marketing"
        JobTitle        = "Marketing Manager"
    },
    @{
        DisplayName     = "Bob Johnson"
        UserPrincipalName = "bob.johnson@yourtenant.onmicrosoft.com"
        Department      = "Sales"
        JobTitle        = "Sales Representative"
    }
)

foreach ($user in $users) {
    $PasswordProfile = @{
        Password = "TempPassword@12345"
        ForceChangePasswordNextSignIn = $true
    }
    
    New-MgUser -DisplayName $user.DisplayName `
               -UserPrincipalName $user.UserPrincipalName `
               -MailNickname ($user.UserPrincipalName.Split("@")[0]) `
               -PasswordProfile $PasswordProfile `
               -AccountEnabled `
               -Department $user.Department `
               -JobTitle $user.JobTitle
}


# ==========================================
# READ/GET USERS
# ==========================================

# Get all users
Get-MgUser -All

# Get specific user by UPN
Get-MgUser -Filter "userPrincipalName eq 'john.smith@yourtenant.onmicrosoft.com'"

# Get user by display name
Get-MgUser -Filter "displayName eq 'John Smith'"

# Get users by department
Get-MgUser -Filter "department eq 'Sales'" -All

# Get user count
(Get-MgUser -All).Count

# Get users with specific properties
Get-MgUser -Property "displayName,userPrincipalName,department,jobTitle" -All | Format-Table


# ==========================================
# UPDATE USERS
# ==========================================

# Update user properties
$userId = (Get-MgUser -Filter "userPrincipalName eq 'john.smith@yourtenant.onmicrosoft.com'").Id

Update-MgUser -UserId $userId `
              -JobTitle "Senior Sales Manager" `
              -Department "Sales - Premium" `
              -OfficeLocation "New York Office 2"

# Reset user password
$newPassword = @{
    Password                      = "NewPassword@12345"
    ForceChangePasswordNextSignIn = $true
}

Update-MgUser -UserId $userId -PasswordProfile $newPassword

# Disable user account
Update-MgUser -UserId $userId -AccountEnabled:$false

# Enable user account
Update-MgUser -UserId $userId -AccountEnabled:$true


# ==========================================
# DELETE USERS
# ==========================================

# Delete user (be careful!)
$userId = (Get-MgUser -Filter "userPrincipalName eq 'john.smith@yourtenant.onmicrosoft.com'").Id
Remove-MgUser -UserId $userId

# Soft delete (recoverable)
# Users are in recycle bin for 30 days


# ==========================================
# CREATE GROUPS
# ==========================================

# 1. Create security group with assigned membership
New-MgGroup -DisplayName "Sales-Team" `
            -Description "Sales team members" `
            -GroupTypes @() `
            -SecurityEnabled `
            -MailEnabled:$false


# 2. Create security group with dynamic membership
New-MgGroup -DisplayName "Sales-Department-Group" `
            -Description "All Sales department employees" `
            -GroupTypes "DynamicMembership" `
            -SecurityEnabled `
            -MembershipRule '(user.department -eq "Sales")' `
            -MembershipRuleProcessingState "On"


# 3. Create Microsoft 365 group
New-MgGroup -DisplayName "Engineering-Team" `
            -Description "Engineering team collaboration" `
            -GroupTypes "Unified" `
            -SecurityEnabled:$false `
            -MailEnabled:$true `
            -MailNickname "engineeringteam"


# 4. Create multiple groups
$groups = @(
    @{
        DisplayName  = "HR-Department"
        Description  = "Human Resources team"
        Department   = "HR"
    },
    @{
        DisplayName  = "Finance-Department"
        Description  = "Finance team"
        Department   = "Finance"
    }
)

foreach ($groupInfo in $groups) {
    $rule = "(user.department eq '{0}')" -f $groupInfo.Department
    
    New-MgGroup -DisplayName $groupInfo.DisplayName `
                -Description $groupInfo.Description `
                -GroupTypes "DynamicMembership" `
                -SecurityEnabled `
                -MembershipRule $rule `
                -MembershipRuleProcessingState "On"
}


# ==========================================
# READ/GET GROUPS
# ==========================================

# Get all groups
Get-MgGroup -All

# Get specific group by display name
Get-MgGroup -Filter "displayName eq 'Sales-Department-Group'"

# Get groups with dynamic membership
Get-MgGroup -All | Where-Object { $_.GroupTypes -contains "DynamicMembership" }

# Get group details
$groupId = (Get-MgGroup -Filter "displayName eq 'Sales-Department-Group'").Id
Get-MgGroup -GroupId $groupId


# ==========================================
# GROUP MEMBERS
# ==========================================

# Get group members
$groupId = (Get-MgGroup -Filter "displayName eq 'Sales-Department-Group'").Id
Get-MgGroupMember -GroupId $groupId

# Get group member count
(Get-MgGroupMember -GroupId $groupId).Count

# Add member to group (assigned membership only)
$userId = (Get-MgUser -Filter "userPrincipalName eq 'jane.doe@yourtenant.onmicrosoft.com'").Id
New-MgGroupMember -GroupId $groupId -DirectoryObjectId $userId

# Remove member from group
Remove-MgGroupMember -GroupId $groupId -DirectoryObjectId $userId

# Check if user is member of group
$isMember = $null -ne (Get-MgGroupMember -GroupId $groupId -Filter "id eq '$userId'")
Write-Output "User is member: $isMember"


# ==========================================
# UPDATE GROUPS
# ==========================================

# Update group properties
$groupId = (Get-MgGroup -Filter "displayName eq 'Sales-Team'").Id
Update-MgGroup -GroupId $groupId `
               -Description "Updated: Sales team for 2024"

# Update dynamic membership rule
Update-MgGroup -GroupId $groupId `
               -MembershipRule '(user.department -eq "Sales") -or (user.department -eq "Sales-Premium")'


# ==========================================
# DELETE GROUPS
# ==========================================

# Delete group (be careful!)
$groupId = (Get-MgGroup -Filter "displayName eq 'Old-Group'").Id
Remove-MgGroup -GroupId $groupId


# ==========================================
# LICENSE MANAGEMENT
# ==========================================

# Get available licenses (SKUs)
Get-MgSubscribedSku | Select-Object DisplayName, SkuId, ConsumedUnits

# Get specific license SKU
$licenseSku = Get-MgSubscribedSku -Filter "displayName eq 'Microsoft 365 Business Standard'"

# Get user's current licenses
$userId = (Get-MgUser -Filter "userPrincipalName eq 'john.smith@yourtenant.onmicrosoft.com'").Id
Get-MgUserLicenseDetail -UserId $userId

# Assign license to user
$licenseSku = Get-MgSubscribedSku -Filter "displayName eq 'Microsoft 365 Business Standard'"

Set-MgUserLicense -UserId $userId `
                   -AddLicenses @{SkuId = $licenseSku.SkuId} `
                   -RemoveLicenses @()

# Remove license from user
Set-MgUserLicense -UserId $userId `
                   -AddLicenses @() `
                   -RemoveLicenses @($licenseSku.SkuId)

# Assign license to multiple users
$userEmails = @(
    "john.smith@yourtenant.onmicrosoft.com"
    "jane.doe@yourtenant.onmicrosoft.com"
    "bob.johnson@yourtenant.onmicrosoft.com"
)

foreach ($email in $userEmails) {
    $user = Get-MgUser -Filter "userPrincipalName eq '$email'"
    
    # First set usage location
    Update-MgUser -UserId $user.Id -UsageLocation "US"
    
    # Then assign license
    Set-MgUserLicense -UserId $user.Id `
                       -AddLicenses @{SkuId = $licenseSku.SkuId} `
                       -RemoveLicenses @()
}


# ==========================================
# USAGE LOCATION
# ==========================================

# Set usage location (required for licensing)
$userId = (Get-MgUser -Filter "userPrincipalName eq 'john.smith@yourtenant.onmicrosoft.com'").Id
Update-MgUser -UserId $userId -UsageLocation "US"

# Get users without usage location
Get-MgUser -All | Where-Object { $null -eq $_.UsageLocation }

# Set usage location for all users
Get-MgUser -All | ForEach-Object {
    Update-MgUser -UserId $_.Id -UsageLocation "US"
}


# ==========================================
# BULK OPERATIONS
# ==========================================

# Bulk create users from CSV
$csvPath = "C:\users.csv"
$users = Import-Csv $csvPath

foreach ($user in $users) {
    $PasswordProfile = @{
        Password = "TempPassword@12345"
        ForceChangePasswordNextSignIn = $true
    }
    
    New-MgUser -DisplayName $user.DisplayName `
               -UserPrincipalName $user.UserPrincipalName `
               -MailNickname ($user.UserPrincipalName.Split("@")[0]) `
               -PasswordProfile $PasswordProfile `
               -AccountEnabled `
               -Department $user.Department `
               -JobTitle $user.JobTitle
}

# Export all users to CSV
Get-MgUser -All | Select-Object DisplayName, UserPrincipalName, Department, JobTitle | Export-Csv -Path "C:\export_users.csv" -NoTypeInformation


# ==========================================
# REPORTING & ANALYSIS
# ==========================================

# Count users by department
Get-MgUser -All | Group-Object Department | Select-Object Name, Count

# Find disabled users
Get-MgUser -All | Where-Object { $_.AccountEnabled -eq $false }

# Find users without usage location (can't license)
Get-MgUser -All | Where-Object { $null -eq $_.UsageLocation }

# Find groups with few members
Get-MgGroup -All | ForEach-Object {
    $memberCount = (Get-MgGroupMember -GroupId $_.Id).Count
    [PSCustomObject]@{
        GroupName = $_.DisplayName
        MemberCount = $memberCount
    }
} | Where-Object { $_.MemberCount -lt 5 }

# Get user sign-in activity
Get-MgUser -Filter "userPrincipalName eq 'john.smith@yourtenant.onmicrosoft.com'" | Select-Object DisplayName, SignInActivity


# ==========================================
# HELPFUL FUNCTIONS
# ==========================================

# Function to create user with defaults
function New-TestUser {
    param(
        [string]$FirstName,
        [string]$LastName,
        [string]$Department = "IT",
        [string]$JobTitle = "Engineer"
    )
    
    $displayName = "$FirstName $LastName"
    $mailNickname = "$FirstName.$LastName".ToLower()
    $upn = "$mailNickname@yourtenant.onmicrosoft.com"
    
    $PasswordProfile = @{
        Password = "TempPassword@12345"
        ForceChangePasswordNextSignIn = $true
    }
    
    New-MgUser -DisplayName $displayName `
               -UserPrincipalName $upn `
               -MailNickname $mailNickname `
               -PasswordProfile $PasswordProfile `
               -AccountEnabled `
               -Department $Department `
               -JobTitle $JobTitle
}

# Usage: New-TestUser -FirstName "John" -LastName "Doe" -Department "Sales"


# ==========================================
# ERROR HANDLING EXAMPLE
# ==========================================

try {
    $user = New-MgUser -DisplayName "Test User" `
                       -UserPrincipalName "duplicate@yourtenant.onmicrosoft.com" `
                       -MailNickname "testuser" `
                       -AccountEnabled
}
catch {
    Write-Error "Failed to create user: $_"
}


# ==========================================
# REFERENCE: Important Properties
# ==========================================

<#
User Properties:
  - DisplayName: User's full name
  - UserPrincipalName: Unique identifier (UPN)
  - MailNickname: Email prefix
  - Department: Department name
  - JobTitle: Job title
  - OfficeLocation: Office location
  - MobilePhone: Mobile phone number
  - CompanyName: Company name
  - UsageLocation: Country/region for licensing
  - AccountEnabled: True/false

Group Properties:
  - DisplayName: Group name
  - Description: Group description
  - SecurityEnabled: For security groups
  - MailEnabled: For email-enabled groups
  - GroupTypes: "DynamicMembership" for dynamic groups
  - MembershipRule: Rule for dynamic groups
#>

# ===========================================================
# End of Module 1 PowerShell Commands
# ===========================================================

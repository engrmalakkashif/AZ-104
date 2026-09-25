# Module 1: Manage Azure Identities and Governance - Part 1 (Microsoft Entra Users & Groups)

**Day:** 1 | **Duration:** 5 hours | **Skill Domain:** Manage Azure identities and governance (20-25%)

---

## 📚 Learning Objectives

By the end of this module, you will be able to:
- Create and manage users in Microsoft Entra ID
- Create and manage groups in Microsoft Entra ID
- Configure user and group properties
- Manage licenses in Microsoft Entra ID
- Understand external user management
- Configure self-service password reset (SSPR)

---

## 📖 Theory & Concepts

### 1.1 Microsoft Entra ID Overview
- **What is Microsoft Entra ID?** - Identity and access management service in Azure
- **Key Components:**
  - Users: Individual accounts representing people
  - Groups: Collections of users for easier management
  - Applications: SaaS apps and custom applications
  - Roles: RBAC for access control

### 1.2 Creating and Managing Users

**User Types:**
- **Cloud Users:** Created directly in Microsoft Entra ID
- **Hybrid Users:** Synchronized from on-premises Active Directory
- **Guest Users:** External users invited to your organization

**User Properties:**
- First Name, Last Name, Display Name
- Email Address (must be unique in tenant)
- Mobile Phone, Office Phone
- Job Title, Department
- Manager
- Usage Location (required for license assignment)

### 1.3 Groups in Microsoft Entra ID

**Group Types:**
1. **Security Groups** - Used to manage access to resources
2. **Microsoft 365 Groups** - For collaboration (Teams, SharePoint, etc.)

**Membership Types:**
1. **Assigned** - Manually add/remove members
2. **Dynamic User** - Auto-populate based on user properties
3. **Dynamic Device** - Auto-populate based on device properties

**Dynamic Group Rules Example:**
```
(user.department -eq "Sales") -and (user.country -eq "USA")
```

### 1.4 Licensing in Microsoft Entra ID

**License Types:**
- Free: Basic functionality
- Microsoft 365 Premium P1: Advanced features
- Microsoft 365 Premium P2: Identity protection & risk management
- Office 365 E1/E3/E5: Productivity licenses

**Assignment Methods:**
1. **Direct Assignment** - Assign licenses to individual users
2. **Group-Based Licensing** - Assign to groups (auto-assign to members)

### 1.5 External User Management

**Guest Accounts:**
- Invited via email
- Can access shared resources
- External identity required
- B2B collaboration feature

**Access Restrictions:**
- Share external sharing settings
- Configure which external identities can access resources

### 1.6 Self-Service Password Reset (SSPR)

**Benefits:**
- Reduces help desk tickets
- Users can reset own passwords
- Can include security questions
- Can use alternate contact methods

**Configuration:**
- Enable for selected groups or all users
- Configure authentication methods
- Set password writeback options (if hybrid)

---

## 🔧 Lab Notes & Environment Setup

### Prerequisites
- Azure subscription
- Access to Azure Portal
- Global Administrator or User Administrator role

### Lab Environment URLs
- Azure Portal: https://portal.azure.com
- Microsoft Entra Admin Center: https://entra.microsoft.com

---

## 💻 Lab Exercise 1: Create and Configure Users

### Exercise 1.1: Create a Cloud User

**Objective:** Create a new user in Microsoft Entra ID

**Steps:**

1. **Navigate to Microsoft Entra ID**
   ```
   Portal → Azure Services → Microsoft Entra ID
   ```

2. **Create New User**
   - Click "Users" → "New user" → "Create new user"
   - Fill in details:
     - User principal name: john.smith@yourtenant.onmicrosoft.com
     - Display name: John Smith
     - First name: John
     - Last name: Smith
     - Job title: Sales Manager
     - Department: Sales
     - Mobile number: +1-555-123-4567

3. **Password Settings**
   - Select "Auto-generate password"
   - Click "Show Password" and copy it
   - Note: User will need to change password on first login

4. **Click "Create"**

**Expected Output:**
```
✅ User successfully created
User: john.smith@yourtenant.onmicrosoft.com
Principal Name: john.smith@yourtenant.onmicrosoft.com
Status: Created
```

### Exercise 1.2: Create a Security Group with Dynamic Members

**Objective:** Create a group that auto-populates users from Sales department

**Steps:**

1. **Navigate to Groups**
   ```
   Microsoft Entra ID → Groups → New group
   ```

2. **Configure Group**
   - Group type: Security
   - Group name: Sales-Department-Group
   - Group description: Group for Sales department employees
   - Membership type: Dynamic User

3. **Add Dynamic Membership Rule**
   - Click "Add dynamic query"
   - Rule: `(user.department -eq "Sales")`

4. **Review and Create**

**Expected Output:**
```
✅ Group created: Sales-Department-Group
Type: Security Group
Membership: Dynamic User
Members: Auto-populated from department = "Sales"
```

### Exercise 1.3: Assign License to User

**Objective:** Assign Microsoft 365 P1 license to john.smith user

**Steps:**

1. **Navigate to User**
   ```
   Microsoft Entra ID → Users → john.smith@yourtenant.onmicrosoft.com
   ```

2. **Set Usage Location**
   - Click "Edit properties"
   - Set "Usage Location" to "United States"
   - Click "Save"

3. **Assign License**
   - Click "Licenses" in left panel
   - Click "Assignments" → "Add license assignment"
   - Select "Microsoft 365 P1"
   - Click "Save"

**Expected Output:**
```
✅ License assigned successfully
User: john.smith@yourtenant.onmicrosoft.com
License: Microsoft 365 P1
Effective Date: Today
```

---

## 📋 Quick Reference

### Common PowerShell Commands

```powershell
# Connect to Microsoft Graph
Connect-MgGraph -Scopes "User.ReadWrite.All", "Group.ReadWrite.All"

# Create User
$PasswordProfile = @{
    Password = "TempPassword@123"
    ForceChangePasswordNextSignIn = $true
}

New-MgUser -DisplayName "John Smith" `
           -MailNickname "johnsmith" `
           -UserPrincipalName "john.smith@yourtenant.onmicrosoft.com" `
           -PasswordProfile $PasswordProfile `
           -AccountEnabled

# Create Security Group
New-MgGroup -DisplayName "Sales-Department-Group" `
            -Description "Group for Sales department" `
            -GroupTypes "Unified" `
            -SecurityEnabled

# Assign License
Set-MgUserLicense -UserId john.smith@yourtenant.onmicrosoft.com `
                   -AddLicenses @{SkuId="05e9a617-0261-4cee-bb44-138d3b7a9d39"} `
                   -RemoveLicenses @()
```

---

## ✅ Quick Fact Check

- [ ] Can create cloud users in Microsoft Entra ID
- [ ] Understand difference between assigned and dynamic groups
- [ ] Know how to assign licenses with usage location
- [ ] Understand license types in Microsoft 365
- [ ] Know PowerShell equivalent for portal actions

---

## 📝 Lab Exercises Quick Ref

| Exercise | Task | Output | Status |
|----------|------|--------|--------|
| 1.1 | Create cloud user | john.smith@yourtenant.onmicrosoft.com | ⬜ |
| 1.2 | Create dynamic group | Sales-Department-Group | ⬜ |
| 1.3 | Assign license to user | P1 license assigned | ⬜ |

---

## 🎯 Key Takeaways

1. **User Creation**: Users in Microsoft Entra ID need unique UPN (User Principal Name) and proper configuration
2. **Groups for Efficiency**: Use dynamic groups to automatically manage group membership based on user properties
3. **Licensing**: Must set "Usage Location" before assigning Microsoft 365 licenses
4. **License Assignment**: Can assign to individual users or groups (group-based licensing)
5. **Security**: Always enforce strong passwords and MFA where applicable

---

## 📚 Additional Resources

- [Create users in Microsoft Entra ID](https://learn.microsoft.com/en-us/azure/active-directory/fundamentals/how-to-create-delete-users-azure-ad)
- [Create groups and manage members](https://learn.microsoft.com/en-us/azure/active-directory/fundamentals/how-to-manage-groups)
- [Assign or remove licenses](https://learn.microsoft.com/en-us/azure/active-directory/fundamentals/license-users-groups)
- [Dynamic group membership](https://learn.microsoft.com/en-us/azure/active-directory/enterprise-users/groups-dynamic-membership)

---

## 📊 Self-Assessment

**Rate your understanding (1-5):**
- Creating cloud users: __ / 5
- Managing groups: __ / 5
- Assigning licenses: __ / 5
- Understanding group types: __ / 5

---

**Next Module:** Manage Azure Identities and Governance - Part 2 (Access Control & Subscriptions)

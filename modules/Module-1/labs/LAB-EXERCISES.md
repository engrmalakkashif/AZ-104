# Module 1: Lab Exercises - Microsoft Entra Users & Groups

**Complete all 3 exercises in order**  
**Total Time:** 2 hours (30 min each + buffer)  
**Difficulty:** Beginner

---

## 📝 Exercise 1.1: Create Cloud User

### Objective
Create a new cloud user in Microsoft Entra ID with complete profile information.

### Duration
30 minutes

### Prerequisites
- ✅ Azure Portal access
- ✅ User Administrator role
- ✅ Test tenant access

### Step-by-Step Instructions

#### Method 1: Using Azure Portal (Recommended for beginners)

**Step 1: Navigate to Microsoft Entra ID**
```
1. Open: https://portal.azure.com
2. Search for: "Microsoft Entra ID"
3. Click: "Microsoft Entra ID" service
```

**Step 2: Create New User**
```
1. In left panel, click: "Users"
2. Top menu, click: "New user"
3. Select: "Create new user"
```

**Step 3: Fill User Information**
```
Field Name               | Value
User principal name      | john.smith@yourtenant.onmicrosoft.com
Mail nickname            | johnsmith
Display name             | John Smith
First name               | John
Last name                | Smith
Job title                | Sales Manager
Department               | Sales
Office location          | New York
Mobile phone             | +1-555-123-4567
Office phone             | +1-555-987-6543
```

**Step 4: Set Password**
```
✓ Check: "Auto-generate password"
✓ Check: "Show password" (copy it!)
Password: [Auto-generated, copy it]
Note: User will be forced to change on first login
```

**Step 5: Create User**
```
1. Click: "Create"
2. Wait for success notification
3. Verify: User appears in users list
```

#### Method 2: Using PowerShell (For advanced users)

```powershell
# Connect to Microsoft Graph
Connect-MgGraph -Scopes "User.ReadWrite.All"

# Create password profile
$PasswordProfile = @{
    Password = "TempPassword@12345"
    ForceChangePasswordNextSignIn = $true
}

# Create user
New-MgUser -DisplayName "John Smith" `
           -MailNickname "johnsmith" `
           -UserPrincipalName "john.smith@yourtenant.onmicrosoft.com" `
           -PasswordProfile $PasswordProfile `
           -AccountEnabled `
           -JobTitle "Sales Manager" `
           -Department "Sales" `
           -OfficeLocation "New York" `
           -MobilePhone "+1-555-123-4567"

# Verify creation
Get-MgUser -Filter "userPrincipalName eq 'john.smith@yourtenant.onmicrosoft.com'"
```

### Expected Output

```
✅ USER SUCCESSFULLY CREATED

User Details:
  Display Name: John Smith
  UPN: john.smith@yourtenant.onmicrosoft.com
  Mail: john.smith@yourtenant.onmicrosoft.com
  Department: Sales
  Job Title: Sales Manager
  Office Location: New York
  Mobile: +1-555-123-4567
  Status: Enabled ✅
  Created Date: [Today's Date]

Verification in Portal:
  ✅ User appears in Users list
  ✅ Profile information visible
  ✅ Status shows "Enabled"
  ✅ No errors in activity log
```

### Verification Checklist

- [ ] User created successfully (no errors)
- [ ] User appears in Microsoft Entra ID users list
- [ ] Display name shows correctly
- [ ] Department and job title populated
- [ ] Mobile phone number saved
- [ ] Account status is "Enabled"
- [ ] Can see "Last sign-in" is "Never" (first time)

### Troubleshooting

**Problem:** "Name already exists in the directory"
- **Cause:** UPN already used
- **Solution:** Use different email (add number/department code)

**Problem:** "Invalid email format"
- **Cause:** Email not matching tenant domain
- **Solution:** Use format: firstname.lastname@yourtenant.onmicrosoft.com

**Problem:** "Insufficient privileges"
- **Cause:** Don't have User Administrator role
- **Solution:** Request admin role from tenant admin

---

## 📝 Exercise 1.2: Create Dynamic Group

### Objective
Create a security group with dynamic membership rule that auto-populates based on user properties.

### Duration
30 minutes

### Prerequisites
- ✅ Completed Exercise 1.1
- ✅ Test users created (need at least 2 users in Sales department)
- ✅ Group Administrator role

### Step-by-Step Instructions

#### Method 1: Using Azure Portal

**Step 1: Navigate to Groups**
```
1. In Microsoft Entra ID, click: "Groups"
2. Top menu, click: "New group"
```

**Step 2: Configure Group Basics**
```
Field Name          | Value
Group type          | Security
Group name          | Sales-Department-Group
Group description   | Group for all Sales department employees
Membership type     | Dynamic User
```

**Step 3: Add Dynamic Membership Rule**
```
1. Under "Membership type", click: "Add dynamic query"
2. For "Rule builder" (easier method):
   - Property: department
   - Operator: Equals
   - Value: Sales
   
   This creates rule: (user.department -eq "Sales")
```

**Step 4: Create Group**
```
1. Click: "Create"
2. Wait for success notification
3. Verify: Group appears in groups list
```

**Step 5: Verify Dynamic Population**
```
1. Click on group: "Sales-Department-Group"
2. Click: "Members"
3. Verify: All users with department="Sales" appear
4. Wait 2-3 minutes if not showing immediately
```

#### Method 2: Using PowerShell

```powershell
# Connect to Microsoft Graph
Connect-MgGraph -Scopes "Group.ReadWrite.All"

# Create dynamic group
New-MgGroup -DisplayName "Sales-Department-Group" `
            -Description "Group for all Sales department employees" `
            -GroupTypes "DynamicMembership" `
            -SecurityEnabled `
            -MembershipRule '(user.department -eq "Sales")' `
            -MembershipRuleProcessingState "On"

# Verify group creation
Get-MgGroup -Filter "displayName eq 'Sales-Department-Group'"

# Check members
$group = Get-MgGroup -Filter "displayName eq 'Sales-Department-Group'"
Get-MgGroupMember -GroupId $group.Id
```

### Expected Output

```
✅ DYNAMIC GROUP SUCCESSFULLY CREATED

Group Details:
  Display Name: Sales-Department-Group
  Description: Group for all Sales department employees
  Type: Security
  Membership Type: Dynamic User
  Membership Rule: (user.department -eq "Sales")
  Status: Active ✅
  Members: [Auto-populated, count shown]

Members Auto-populated:
  ✅ John Smith (department: Sales)
  ✅ [Any other users with Sales department]
  
Verification:
  ✅ Group visible in Groups list
  ✅ Members section shows all matching users
  ✅ Rule shows as active
  ✅ Membership updates automatically
```

### Verification Checklist

- [ ] Group created successfully
- [ ] Group appears in groups list
- [ ] Membership type shows as "Dynamic User"
- [ ] Membership rule visible and correct
- [ ] Members section shows auto-populated users
- [ ] All users with department="Sales" are members
- [ ] No manual members added

### Advanced: Custom Rules

```
Other example rules you can try:

Rule: Only users in USA
(user.country -eq "United States")

Rule: Only users with specific job title
(user.jobTitle -eq "Manager")

Rule: Users in IT OR Finance department
(user.department -eq "IT") -or (user.department -eq "Finance")

Rule: Users with manager AND extension 2000+
(user.extension_<guid>_extensionAttribute1 -eq "Manager") -and (user.telephoneNumber -startsWith "2")
```

### Troubleshooting

**Problem:** "Dynamic group appears empty"
- **Cause:** No users match the rule
- **Solution:** Create test users with matching department

**Problem:** "Rule syntax error"
- **Cause:** Incorrect property name or formatting
- **Solution:** Check property name (use lowercase exactly)

---

## 📝 Exercise 1.3: Assign License

### Objective
Assign Microsoft 365 license to a user and verify activation.

### Duration
30 minutes

### Prerequisites
- ✅ Completed Exercise 1.1 (user created)
- ✅ Microsoft 365 licenses available in tenant
- ✅ License Administrator role

### Step-by-Step Instructions

#### Method 1: Using Azure Portal

**Step 1: Navigate to User**
```
1. In Microsoft Entra ID, click: "Users"
2. Search for: "John Smith"
3. Click on: "john.smith@yourtenant.onmicrosoft.com"
```

**Step 2: Set Usage Location (REQUIRED!)**
```
1. In user profile, click: "Edit properties"
2. Find: "Usage Location"
3. Select: "United States" (or appropriate country)
4. Click: "Save"
⚠️ NOTE: Cannot assign license without Usage Location
```

**Step 3: Assign License**
```
1. In left panel, click: "Licenses"
2. Click: "Assignments" or "+ Assign license"
3. Select license:
   - Option 1: Microsoft 365 P1
   - Option 2: Microsoft 365 P2 (if available)
4. Click: "Save" or "Assign"
```

**Step 4: Verify License Assignment**
```
1. Refresh page (if needed)
2. Verify license appears in "Licenses" section
3. Check status: Should show "Active" ✅
4. Note the "Last assigned" date
```

#### Method 2: Using PowerShell

```powershell
# Connect to Azure
Connect-AzAccount

# Get user
$user = Get-AzADUser -Filter "userPrincipalName eq 'john.smith@yourtenant.onmicrosoft.com'"

# Set usage location first
$user | Set-AzADUser -UsageLocation "US"

# Get available licenses
Get-MgSubscribedSku | Select-Object DisplayName, SkuId

# Assign license (example: Microsoft 365 P1)
$SkuId = (Get-MgSubscribedSku -Filter "displayName eq 'Microsoft 365 Business Standard'").SkuId

Set-MgUserLicense -UserId $user.Id `
                   -AddLicenses @{SkuId = $SkuId} `
                   -RemoveLicenses @()

# Verify assignment
Get-MgUserLicenseDetail -UserId $user.Id
```

### Expected Output

```
✅ LICENSE SUCCESSFULLY ASSIGNED

User: john.smith@yourtenant.onmicrosoft.com
License Details:
  License: Microsoft 365 Business Standard
  SKU: M365_BUSINESS_STANDARD
  Status: Active ✅
  Assigned Date: [Today]
  Renewal: [Date]
  
Service Plans Included:
  ✅ Exchange Online
  ✅ SharePoint Online
  ✅ Teams
  ✅ OneDrive
  ✅ And more...

Verification:
  ✅ License shows in user profile
  ✅ Status is "Active"
  ✅ No errors in assignment history
  ✅ Services are provisioning
```

### Verification Checklist

- [ ] Usage Location set before license assignment
- [ ] License selected from available options
- [ ] Assignment completed without errors
- [ ] License shows as "Active" in user profile
- [ ] "Last assigned" date is today
- [ ] Can see service plans included
- [ ] User can now access Microsoft 365 services

### License Provisioning Timeline

```
Immediately:
  ✅ License assigned
  ✅ Shows in admin portal
  
1-5 minutes:
  ✅ Services start provisioning
  ✅ Email account active
  
5-30 minutes:
  ✅ Teams access available
  ✅ OneDrive ready
  
30+ minutes:
  ✅ All services fully active
  ✅ User can sign in and use all features
```

### Troubleshooting

**Problem:** "You must set a usage location first"
- **Cause:** Usage Location not set on user
- **Solution:** Go to user properties and set Usage Location

**Problem:** "No licenses available"
- **Cause:** All licenses consumed or no licenses purchased
- **Solution:** Check available licenses with admin

**Problem:** "License assignment failed"
- **Cause:** Insufficient permissions or licensing conflict
- **Solution:** Check you have License Admin role, try again

---

## 📊 Summary of All Exercises

| Exercise | Task | Time | Status |
|----------|------|------|--------|
| 1.1 | Create Cloud User | 30 min | ⬜ |
| 1.2 | Create Dynamic Group | 30 min | ⬜ |
| 1.3 | Assign License | 30 min | ⬜ |
| **Total** | **All 3 exercises** | **90 min** | |

---

## ✅ Module Completion Verification

**Before moving to Module 2, verify:**

- [ ] Exercise 1.1 completed (user created)
- [ ] Exercise 1.2 completed (group created)
- [ ] Exercise 1.3 completed (license assigned)
- [ ] All expected outputs verified
- [ ] No errors encountered
- [ ] Can explain what you learned in each exercise

---

## 🎓 What You've Learned

After completing all 3 exercises, you understand:
1. How to create users in Microsoft Entra ID
2. How dynamic groups auto-populate based on rules
3. How to assign licenses and the requirement for usage location
4. Both Portal and PowerShell methods
5. Common issues and how to troubleshoot them

---

**Great job! You're ready for Module 2! 🚀**

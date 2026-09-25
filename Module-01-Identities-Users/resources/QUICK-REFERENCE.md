# Module 1: Quick Reference Guide

**Print this page and keep it handy during labs!**

---

## 📋 Quick Facts

| Item | Detail |
|------|--------|
| **Module** | 1 |
| **Day** | Day 1 |
| **Duration** | 5 hours total |
| **Lab Time** | 2 hours (3 exercises × 30 min) |
| **Difficulty** | Beginner |
| **Exam Domain** | Identities & Governance (20-25%) |

---

## 🚀 Quick Start

### 3 Things You'll Do
1. **Create a user** in Microsoft Entra ID
2. **Create a dynamic group** that auto-populates
3. **Assign a license** to the user

### Time Each Takes
- Exercise 1.1: 30 minutes
- Exercise 1.2: 30 minutes  
- Exercise 1.3: 30 minutes

---

## 👤 User Creation Checklist

```
Portal Steps:
  1. Microsoft Entra ID → Users → New user
  2. Enter:
     - First Name: John
     - Last Name: Smith
     - Display Name: John Smith
     - UPN: john.smith@yourtenant.onmicrosoft.com
     - Department: Sales
     - Job Title: Manager
  3. Generate password
  4. Click Create
  5. Verify in users list ✓

PowerShell:
  New-MgUser -DisplayName "John Smith" `
             -UserPrincipalName "john.smith@yourtenant.onmicrosoft.com" `
             -MailNickname "johnsmith" `
             -Department "Sales" `
             -JobTitle "Manager" `
             -AccountEnabled
```

**Common UPN Mistakes:**
- ❌ john smith@yourtenant.onmicrosoft.com (space!)
- ❌ john@company.com (wrong domain!)
- ✅ john.smith@yourtenant.onmicrosoft.com (correct!)

---

## 👥 Group Creation Checklist

```
Portal Steps:
  1. Microsoft Entra ID → Groups → New group
  2. Select:
     - Type: Security
     - Name: Sales-Department-Group
     - Membership: Dynamic User
  3. Add rule: user.department -eq "Sales"
  4. Click Create
  5. Wait for auto-population ✓

PowerShell:
  New-MgGroup -DisplayName "Sales-Dept" `
              -GroupTypes "DynamicMembership" `
              -SecurityEnabled `
              -MembershipRule '(user.department -eq "Sales")'
```

**Common Group Rules:**
```
Department: (user.department -eq "Sales")
Location: (user.city -eq "NewYork")
Job Title: (user.jobTitle -eq "Manager")
Multiple: (user.department -eq "Sales") -or (user.department -eq "Marketing")
```

---

## 💳 License Assignment Checklist

```
⚠️ FIRST - Set Usage Location:
   User Properties → Usage Location → Select Country
   (Without this, license assignment fails!)

Then - Assign License:
  1. User → Licenses → Assign license
  2. Select: Microsoft 365 P1 or P2
  3. Click: Save
  4. Wait 5-30 minutes for provisioning ✓

PowerShell:
  Update-MgUser -UserId $id -UsageLocation "US"
  Set-MgUserLicense -UserId $id `
                     -AddLicenses @{SkuId="..."} `
                     -RemoveLicenses @()
```

**License Provisioning Times:**
- Immediate: Shows in portal
- 1-5 min: Email active
- 5-30 min: Teams, OneDrive, other services
- 30+ min: Fully provisioned

---

## 🔑 Key Commands Reference

### User Commands

| Task | Command |
|------|---------|
| Create user | `New-MgUser -DisplayName "..." -UserPrincipalName "..."` |
| Get user | `Get-MgUser -Filter "displayName eq 'John Smith'"` |
| Update user | `Update-MgUser -UserId $id -JobTitle "..."` |
| Delete user | `Remove-MgUser -UserId $id` |
| Get all users | `Get-MgUser -All` |

### Group Commands

| Task | Command |
|------|---------|
| Create group | `New-MgGroup -DisplayName "..." -SecurityEnabled` |
| Get group | `Get-MgGroup -Filter "displayName eq '...'"` |
| Get members | `Get-MgGroupMember -GroupId $id` |
| Add member | `New-MgGroupMember -GroupId $id -DirectoryObjectId $userId` |
| Remove member | `Remove-MgGroupMember -GroupId $id -DirectoryObjectId $userId` |

### License Commands

| Task | Command |
|------|---------|
| Get licenses | `Get-MgSubscribedSku` |
| Assign license | `Set-MgUserLicense -UserId $id -AddLicenses @{SkuId="..."}` |
| Remove license | `Set-MgUserLicense -UserId $id -RemoveLicenses @("...")` |
| Get user licenses | `Get-MgUserLicenseDetail -UserId $id` |

---

## ⚡ Common Errors & Fixes

| Error | Cause | Fix |
|-------|-------|-----|
| "Name already exists" | UPN duplicate | Use different UPN (add numbers) |
| "Invalid email" | Wrong format | Use `name@yourtenant.onmicrosoft.com` |
| "License failed" | Usage Location missing | Set Usage Location first! |
| "Cannot find user" | Wrong UPN/filter | Check spelling of UPN |
| "Group empty" | No matching users | Create users with matching property |

---

## 📊 Exercise Time Tracker

```
Exercise 1.1 (Create User):
  Start time: ___:___
  End time: ___:___
  Issues: __________________
  Status: ✓ Complete / ✗ Retry

Exercise 1.2 (Create Group):
  Start time: ___:___
  End time: ___:___
  Issues: __________________
  Status: ✓ Complete / ✗ Retry

Exercise 1.3 (Assign License):
  Start time: ___:___
  End time: ___:___
  Issues: __________________
  Status: ✓ Complete / ✗ Retry
```

---

## 🎯 Success Verification

### After Exercise 1.1
- [ ] User appears in Microsoft Entra ID users list
- [ ] Display name shows "John Smith"
- [ ] Department shows "Sales"
- [ ] Job Title shows "Manager"
- [ ] Status is "Enabled"

### After Exercise 1.2
- [ ] Group appears in groups list
- [ ] Group name is "Sales-Department-Group"
- [ ] Membership type is "Dynamic User"
- [ ] Members section shows users auto-populated
- [ ] All Sales department users are members

### After Exercise 1.3
- [ ] License shows in user's licenses section
- [ ] License status is "Active"
- [ ] "Last assigned" date is today
- [ ] No errors in assignment history

---

## 💡 Pro Tips

1. **Save passwords safely**: When creating users, save the auto-generated password somewhere safe
2. **Test first**: Create test user/group before doing bulk operations
3. **Use PowerShell for bulk**: If creating 5+ items, use PowerShell scripts
4. **Check UPN carefully**: UPN is the most common mistake
5. **Dynamic groups rock**: Use dynamic groups to reduce admin work
6. **Set usage location first**: Always do this before assigning licenses
7. **Wait for provisioning**: Don't get impatient - wait 5-30 min for licenses

---

## 🔄 Portal vs PowerShell Comparison

| Task | Portal | PowerShell |
|------|--------|-----------|
| Create 1 user | ⭐⭐ Easy | ⭐⭐⭐ Code required |
| Create 10 users | ⭐ Tedious | ⭐⭐⭐ Script it! |
| Create group | ⭐⭐ Easy | ⭐⭐⭐ More options |
| Bulk operations | ❌ Difficult | ⭐⭐⭐ Perfect |
| Testing | ⭐⭐⭐ Visual | ⭐⭐ Command line |

**Best practice:** Use Portal for testing 1-2 items, PowerShell for bulk operations

---

## 📱 Portal Locations (Bookmarks)

Save these URLs:
- Azure Portal: https://portal.azure.com
- Entra Admin: https://entra.microsoft.com
- Users: https://entra.microsoft.com/#blade/Microsoft_AAD_IAM/UsersManagementMenuBlade
- Groups: https://entra.microsoft.com/#blade/Microsoft_AAD_IAM/GroupsManagementMenuBlade

---

## 🔗 Quick Links

| Resource | Link |
|----------|------|
| Lab Exercises | `labs/LAB-EXERCISES.md` |
| Lab Notes | `labs/LAB-NOTES.md` |
| PowerShell Commands | `resources/POWERSHELL-COMMANDS.ps1` |
| Full Module Content | `content/README.md` |

---

## ✅ Module Completion Checklist

- [ ] Read all theory sections
- [ ] Completed Exercise 1.1
- [ ] Completed Exercise 1.2
- [ ] Completed Exercise 1.3
- [ ] All expected outputs verified
- [ ] Tried PowerShell commands
- [ ] Reviewed key takeaways
- [ ] Completed self-assessment
- [ ] Ready for Module 2

---

## 🎓 Key Concepts (Must Know)

**UPN (User Principal Name):**
- Unique identifier for user
- Format: firstname.lastname@yourtenant.onmicrosoft.com
- Used for sign-in
- Can't be duplicated

**Dynamic Groups:**
- Auto-populate based on rules
- Example rule: (user.department -eq "Sales")
- No manual management needed
- Auto-update when users change

**Usage Location:**
- Geographic location for licensing
- MUST be set before assigning licenses
- Determines license availability
- Example: United States, Canada, UK

**License Status:**
- Active = ready to use
- Takes 5-30 minutes to provision
- Multiple licenses per user possible
- Can be removed anytime

---

## 🚀 Ready to Continue?

After completing this module and verifying all exercises:

✅ Move to **Module 2: Access Control & RBAC**

You'll be:
- Assigning roles to users you created
- Understanding scope and inheritance
- Creating custom roles

---

**Print this page → Bookmark it → Use during labs! 📌**

---

*Module 1 Quick Reference v1.0*  
*Created: September 26, 2026*  
*Last Updated: September 26, 2026*

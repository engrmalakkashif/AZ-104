# Module 1: Lab Notes - Microsoft Entra Users & Groups

**Module:** 1  
**Day:** 1  
**Duration:** Lab Section = 3 hours  
**Total Module Time:** 5 hours (Theory 1hr + Labs 3hrs + Review 1hr)

---

## 📋 Lab Environment Setup

### Prerequisites Checklist
- [ ] Azure subscription active
- [ ] Access to Azure Portal (portal.azure.com)
- [ ] Global Administrator OR User Administrator role
- [ ] Microsoft Entra Admin Center access (entra.microsoft.com)
- [ ] PowerShell with Az module installed (optional but recommended)
- [ ] Azure CLI installed (optional but recommended)

### Resource Creation (If Needed)
```bash
# Create a test resource group
az group create --name rg-module01-lab --location eastus

# Or via PowerShell:
New-AzResourceGroup -Name "rg-module01-lab" -Location "eastus"
```

### Lab Duration Breakdown

| Activity | Time | Status |
|----------|------|--------|
| Exercise 1.1: Create Cloud User | 30 min | ⬜ |
| Exercise 1.2: Create Dynamic Group | 30 min | ⬜ |
| Exercise 1.3: Assign License | 30 min | ⬜ |
| Review & Troubleshooting | 30 min | ⬜ |
| **Total Lab Time** | **2 hours** | |

---

## 🎯 Lab Objectives

By completing all labs in this module, you will:
1. ✅ Understand how to create users in Microsoft Entra ID
2. ✅ Know the difference between user types (cloud, hybrid, guest)
3. ✅ Create dynamic groups with membership rules
4. ✅ Assign licenses to users
5. ✅ Use both Portal and PowerShell methods
6. ✅ Verify user and group creation

---

## 🔧 Lab Environment Details

### Azure Portal Locations

**Microsoft Entra ID:**
```
https://entra.microsoft.com
→ Users
→ Groups
→ Licenses
```

**Alternative Access:**
```
Azure Portal → Azure Services → Microsoft Entra ID
```

### PowerShell Module Requirements
```powershell
# Required modules
Install-Module -Name Microsoft.Graph -Scope CurrentUser -Force
Import-Module Microsoft.Graph

# Connect to Graph
Connect-MgGraph -Scopes "User.ReadWrite.All", "Group.ReadWrite.All"
```

### Azure CLI Setup
```bash
# Login to Azure
az login

# Check Entra ID access
az ad user list --query "[].displayName"
```

---

## ⚠️ Important Notes for Labs

### User Creation Rules
- User Principal Name (UPN) must be unique in tenant
- Format: `firstname.lastname@yourtenant.onmicrosoft.com`
- Cannot contain spaces or special characters
- Email must be valid format

### Group Creation Tips
- Security groups are best for access management
- Microsoft 365 groups are for collaboration
- Dynamic groups auto-populate based on rules
- Group rules use user properties (department, country, etc.)

### License Assignment Prerequisites
- Must set "Usage Location" on user first
- License must be available in tenant
- Can take 5-10 minutes to provision
- Requires specific admin role

---

## 📝 Lab Exercise Overview

### Exercise 1.1: Create Cloud User
**What You'll Do:**
- Create a new user in Microsoft Entra ID
- Set user properties (name, email, phone, etc.)
- Assign temporary password
- Verify user creation

**Time:** 30 minutes  
**Prerequisites:** Azure Portal access  
**Success Criteria:** User appears in users list

---

### Exercise 1.2: Create Dynamic Group
**What You'll Do:**
- Create a security group
- Set dynamic membership rule
- Add test users to group
- Verify auto-population works

**Time:** 30 minutes  
**Prerequisites:** Multiple test users created  
**Success Criteria:** Users auto-added to group based on rule

---

### Exercise 1.3: Assign License
**What You'll Do:**
- Set usage location on user
- Assign Microsoft 365 license
- Verify license assignment
- Check license status

**Time:** 30 minutes  
**Prerequisites:** License available in tenant  
**Success Criteria:** License shows as active for user

---

## 🔍 What to Monitor During Labs

### User Creation Checklist
- [ ] UPN is unique
- [ ] Display name is set correctly
- [ ] Job title/department filled
- [ ] Mobile phone number entered
- [ ] Password created and saved
- [ ] User marked as enabled

### Group Creation Checklist
- [ ] Group name is clear and descriptive
- [ ] Group type is correct (Security or Microsoft 365)
- [ ] Membership type is set (Assigned or Dynamic)
- [ ] If dynamic: rule syntax is valid
- [ ] Group description added
- [ ] Owners assigned

### License Assignment Checklist
- [ ] Usage Location set (required)
- [ ] License type selected (P1 or P2)
- [ ] License status shows "Active"
- [ ] Assignment date recorded
- [ ] Renewal settings configured

---

## 📊 Expected Results Summary

### After Exercise 1.1
```
✅ New user created
   Name: John Smith
   UPN: john.smith@yourtenant.onmicrosoft.com
   Status: Enabled
   Location: United States
```

### After Exercise 1.2
```
✅ Dynamic group created
   Name: Sales-Department-Group
   Type: Security
   Membership: Dynamic
   Rule: (user.department -eq "Sales")
   Members: Auto-populated
```

### After Exercise 1.3
```
✅ License assigned
   User: john.smith@yourtenant.onmicrosoft.com
   License: Microsoft 365 P1
   Status: Active
   Assigned Date: Today
```

---

## ⏱️ Time Management Tips

**If running short on time:**
- Use Portal for faster UI-based creation (vs PowerShell)
- Create only 1 user per exercise
- Skip advanced filtering rules initially
- Focus on success verification over documentation

**If want to go deeper:**
- Create multiple users with different properties
- Create multiple groups with different membership rules
- Explore PowerShell scripting for bulk creation
- Test group nesting and permissions

---

## 🐛 Common Issues & Solutions

### Issue: "Name Already Exists"
**Cause:** UPN already used in tenant
**Solution:** Use unique suffix (add numbers/department code)

### Issue: "Cannot Assign License"
**Cause:** Usage Location not set
**Solution:** Go to user properties → set Usage Location first

### Issue: "Dynamic Group Shows No Members"
**Cause:** Rule syntax incorrect
**Solution:** Check rule for typos, use correct property names

### Issue: "User Created But Not Visible"
**Cause:** Page not refreshed
**Solution:** Refresh browser or wait 30 seconds

---

## 📞 Support During Labs

**If stuck:**
1. Check "Expected Output" section in lab exercise
2. Review "Quick Reference" commands
3. Check prerequisites are all met
4. Try alternative method (Portal vs CLI vs PowerShell)
5. Ask on Microsoft Q&A forum

---

## ✅ Lab Completion Checklist

Before moving to Exercise 1.2, complete Exercise 1.1:
- [ ] User created in Microsoft Entra ID
- [ ] All properties populated
- [ ] User is enabled
- [ ] Can see user in users list

Before moving to Exercise 1.3, complete Exercise 1.2:
- [ ] Group created
- [ ] Membership rule working
- [ ] Group appears in groups list
- [ ] Can see members populated

Final Module Completion:
- [ ] All 3 exercises completed
- [ ] All expected outputs verified
- [ ] No errors encountered
- [ ] Ready for Module 2

---

## 📈 Progress Tracking

**Lab Status:**
- [ ] Lab Notes reviewed: ________
- [ ] Exercise 1.1 complete: ________
- [ ] Exercise 1.2 complete: ________
- [ ] Exercise 1.3 complete: ________
- [ ] All verified working: ________

**Date Started:** ____________  
**Date Completed:** ____________  
**Issues Encountered:** ____________  
**Time Taken:** ____________  

---

## 🎯 Next Steps After Labs

1. ✅ Review PowerShell commands section
2. ✅ Practice commands in PowerShell ISE
3. ✅ Read Key Takeaways section
4. ✅ Complete self-assessment
5. ✅ Move to Module 2

---

**Good luck with your labs! You'll do great! 🚀**

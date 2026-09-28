# Module 2: Lab Notes - Access Control & RBAC

**Module:** 2  
**Day:** 2  
**Duration:** Lab Section = 3 hours  
**Total Module Time:** 5 hours (Theory 1hr + Labs 3hrs + Review 1hr)

---

## 📋 Lab Environment Setup

### Prerequisites Checklist
- [ ] Completed Module 1 (users and groups created)
- [ ] Azure subscription active
- [ ] Owner or User Access Administrator role
- [ ] Test resource group created (or created during labs)
- [ ] Test users from Module 1 available
- [ ] Access to Azure Portal

### Required Resources
```bash
# Create test resource group if needed
az group create --name rg-rbac-lab --location eastus

# Create test storage account
az storage account create --name storagerbaclab \
                          --resource-group rg-rbac-lab \
                          --location eastus
```

### Lab Duration Breakdown

| Activity | Time | Status |
|----------|------|--------|
| Exercise 2.1: Assign Roles at Different Scopes | 45 min | ⬜ |
| Exercise 2.2: Check Effective Permissions | 30 min | ⬜ |
| Exercise 2.3: Create Custom Role | 45 min | ⬜ |
| Exercise 2.4: Remove Access (Cleanup) | 15 min | ⬜ |
| Review & Troubleshooting | 30 min | ⬜ |
| **Total Lab Time** | **2.75 hours** | |

---

## 🎯 Lab Objectives

By completing all labs in this module, you will:
1. ✅ Understand RBAC model (Principal + Role + Scope)
2. ✅ Assign roles at different scopes (subscription, RG, resource)
3. ✅ Verify effective permissions for users
4. ✅ Create custom roles with specific permissions
5. ✅ Understand role inheritance
6. ✅ Practice with Portal, PowerShell, and CLI

---

## 🔧 Lab Environment Details

### RBAC Model Review

```
RBAC = Security Principal + Role Definition + Scope

Security Principal (WHO):
  - User (john.smith@...)
  - Group (Sales-Team)
  - Service Principal (MyApp)
  - Managed Identity

Role Definition (WHAT):
  - Built-in roles (Contributor, Reader, Owner)
  - Custom roles (VM Operator)

Scope (WHERE):
  - Management Group
  - Subscription
  - Resource Group
  - Resource
```

### Scope Hierarchy

```
Management Group
  └─ Subscription
      └─ Resource Group
          └─ Resource (Storage, VM, etc.)

Assignment at higher level = inherited by lower levels
```

### Azure Portal RBAC Locations

**From Resource Group:**
```
Resource Group → Access Control (IAM) → Role assignments
```

**From Subscription:**
```
Subscriptions → Your subscription → Access Control (IAM)
```

**From Resource:**
```
Resource (Storage, VM, etc.) → Access Control (IAM)
```

---

## ⚠️ Important RBAC Notes

### Role Assignment Rules
- Must have Owner or User Access Administrator role to assign
- Role + Scope combination determines actual permissions
- Assignments are immediately effective
- Can assign to users, groups, or service principals

### Scope Considerations
- More specific scope = least privilege (best practice)
- Subscription-level = too broad for regular users
- Resource-level = most secure
- Group assignments = easier management

### Custom Role Tips
- Based on actions (permissions)
- Must have describable permissions
- Can include or exclude specific actions
- Takes precedence over built-in roles
- Can't be deleted if assigned

---

## 📝 Lab Exercise Overview

### Exercise 2.1: Assign Roles at Different Scopes
**What You'll Do:**
- Assign Contributor to user at RG level
- Assign Storage Contributor at storage account level
- Assign Reader at subscription level
- Verify all assignments active

**Time:** 45 minutes  
**Success Criteria:** All 3 assignments visible in portal

---

### Exercise 2.2: Check Effective Permissions
**What You'll Do:**
- Check what permissions user actually has
- Understand inherited permissions
- Review direct vs. inherited assignments

**Time:** 30 minutes  
**Success Criteria:** Can explain user's effective permissions

---

### Exercise 2.3: Create Custom Role
**What You'll Do:**
- Create "VM Operator" custom role
- Configure start/stop/restart permissions
- Set assignable scope
- Assign to test user

**Time:** 45 minutes  
**Success Criteria:** Custom role created and assignable

---

### Exercise 2.4: Remove Access (Cleanup)
**What You'll Do:**
- Remove test role assignments
- Clean up custom role
- Verify cleanup complete

**Time:** 15 minutes  
**Success Criteria:** All test assignments removed

---

## 🔍 What to Monitor During Labs

### Role Assignment Verification
- [ ] Role appears in "Role assignments" tab
- [ ] Correct scope selected
- [ ] Correct principal (user/group) assigned
- [ ] Assignment type (Direct or Inherited) noted
- [ ] No errors in activity log

### Effective Permissions Verification
- [ ] "Check access" tab accessible
- [ ] User name entered correctly
- [ ] All applicable roles listed
- [ ] Inherited roles shown separately
- [ ] Permissions explained clearly

### Custom Role Verification
- [ ] Role created successfully
- [ ] Correct permissions selected
- [ ] Assignable scope set correctly
- [ ] Can assign to users
- [ ] Can remove when needed

---

## 📊 Expected Results Summary

### After Exercise 2.1
```
✅ Role Assignments Created:
  1. Contributor → User at RG scope
  2. Storage Contributor → User at Storage Account scope
  3. Reader → User at Subscription scope
  
All visible in portal with correct scope labels
```

### After Exercise 2.2
```
✅ Effective Access Verified:
  User has:
    - Contributor permissions (RG level)
    - Storage permissions (storage level)
    - Read-only (subscription level)
  
Can identify which permissions come from which scope
```

### After Exercise 2.3
```
✅ Custom Role Created:
  Name: VM Operator
  Permissions:
    - start/action
    - stop/action
    - restart/action
    - read
  
Assignable scope: Subscription/Resource Group
```

### After Exercise 2.4
```
✅ Cleanup Complete:
  - Test assignments removed
  - Custom role cleaned up
  - Portal shows no test entries
```

---

## ⏱️ Time Management Tips

**If running short:**
- Focus on 2.1 and 2.2 (core concepts)
- Skip custom role creation (2.3) for now
- Review PowerShell for quick reference

**If want to go deeper:**
- Create multiple custom roles
- Test permission limitations
- Explore managed identities
- Research Azure Blueprints

---

## 🐛 Common Issues & Solutions

### Issue: "You don't have permission..."
**Cause:** Don't have Owner or UAA role
**Solution:** Request role from subscription admin

### Issue: "Role not appearing in dropdown"
**Cause:** Role filter or refresh needed
**Solution:** Refresh browser, clear filters, try again

### Issue: "Custom role can't be assigned"
**Cause:** Scope mismatch or syntax error
**Solution:** Check role definition, verify scope

### Issue: "Permissions still active after removal"
**Cause:** Role assigned at multiple scopes
**Solution:** Check all scopes (subscription, RG, resource)

---

## 📞 Support During Labs

**If stuck:**
1. Verify you have correct admin role
2. Check resource exists and accessible
3. Review scope hierarchy
4. Try from different scope level
5. Use PowerShell for verification

---

## ✅ Lab Completion Checklist

Before Exercise 2.2, complete Exercise 2.1:
- [ ] Contributor assigned at RG level
- [ ] Storage Contributor assigned at storage level
- [ ] Reader assigned at subscription level
- [ ] All assignments visible in portal

Before Exercise 2.3, complete Exercise 2.2:
- [ ] Can access "Check access" tab
- [ ] Can verify user permissions
- [ ] Understand inherited vs. direct

Before Exercise 2.4, complete Exercise 2.3:
- [ ] Custom role created
- [ ] Role has correct permissions
- [ ] Role can be assigned
- [ ] Assignment test successful

Final Module Completion:
- [ ] All 4 exercises completed
- [ ] All assignments verified
- [ ] Cleanup completed
- [ ] Ready for Module 3

---

## 📈 Progress Tracking

**Lab Status:**
- [ ] Lab Notes reviewed: ________
- [ ] Exercise 2.1 complete: ________
- [ ] Exercise 2.2 complete: ________
- [ ] Exercise 2.3 complete: ________
- [ ] Exercise 2.4 complete: ________
- [ ] All verified working: ________

**Date Started:** ____________  
**Date Completed:** ____________  
**Issues Encountered:** ____________  
**Time Taken:** ____________  

---

## 🎯 Next Steps After Labs

1. ✅ Review PowerShell commands section
2. ✅ Practice role assignment commands
3. ✅ Read Key Takeaways section
4. ✅ Complete self-assessment
5. ✅ Move to Module 3

---

**You're mastering Azure access control! Keep going! 🚀**

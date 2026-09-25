# Module 2: Access Control & RBAC

**Day:** 2 | **Duration:** 5 hours | **Skill Domain:** Manage access to Azure resources (20-25%)

## 📚 Module Overview

This module covers Azure Role-Based Access Control (RBAC), the fundamental mechanism for managing who has access to what in Azure. You'll learn about role assignments, scopes, built-in roles, and how to create custom roles.

## 📂 Module Structure

```
Module-02-Access-Control-RBAC/
├── README.md                      (This file - Module overview)
├── content/
│   ├── README.md                  (Theory & Concepts)
│   └── 02-theory-and-concepts.md  (Detailed learning material)
├── labs/
│   ├── Exercise-2.1-Assign-Roles.md
│   ├── Exercise-2.2-Check-Permissions.md
│   ├── Exercise-2.3-Custom-Role.md
│   └── Exercise-2.4-Remove-Access.md
└── resources/
    ├── powershell-commands.ps1
    ├── azure-cli-commands.sh
    ├── quick-reference.md
    └── rbac-model-diagram.txt
```

## 🎯 Learning Objectives

By the end of this module, you will:
- ✅ Understand RBAC model (Principal + Role + Scope)
- ✅ Know difference between security principals
- ✅ Assign roles at different scopes
- ✅ Interpret effective access assignments
- ✅ Create custom roles
- ✅ Implement least privilege access

## 📖 Quick Links

- [Theory & Concepts](content/README.md) - Detailed learning material
- [Lab Exercises](labs/) - Hands-on practice
- [PowerShell Commands](resources/powershell-commands.ps1) - Ready-to-use scripts
- [Azure CLI Commands](resources/azure-cli-commands.sh) - Alternative CLI approaches
- [Quick Reference](resources/quick-reference.md) - Cheat sheet
- [RBAC Model Diagram](resources/rbac-model-diagram.txt) - Visual reference

## 🔧 Prerequisites

- ✅ Completed Module 1
- ✅ Owner or User Access Administrator role
- ✅ Test resource group created
- ✅ Test users from Module 1

## 📋 Lab Exercises

### Exercise 2.1: Assign Roles at Different Scopes
- **File:** `labs/Exercise-2.1-Assign-Roles.md`
- **Duration:** 45 minutes
- **Objective:** Assign roles at subscription, RG, and resource scopes

### Exercise 2.2: Check Effective Permissions
- **File:** `labs/Exercise-2.2-Check-Permissions.md`
- **Duration:** 30 minutes
- **Objective:** Verify what permissions users have

### Exercise 2.3: Create Custom Role
- **File:** `labs/Exercise-2.3-Custom-Role.md`
- **Duration:** 45 minutes
- **Objective:** Create VM Operator custom role

### Exercise 2.4: Remove Access
- **File:** `labs/Exercise-2.4-Remove-Access.md`
- **Duration:** 15 minutes
- **Objective:** Clean up role assignments

## ✅ Module Completion Checklist

- [ ] Read theory and understand RBAC model
- [ ] Complete Exercise 2.1
- [ ] Complete Exercise 2.2
- [ ] Complete Exercise 2.3
- [ ] Complete Exercise 2.4
- [ ] Review PowerShell commands
- [ ] Complete self-assessment
- [ ] Mark module as complete

## 🎓 Self-Assessment

After completing this module, rate your understanding (1-5):
- RBAC fundamentals: ___ / 5
- Scope hierarchy: ___ / 5
- Built-in roles: ___ / 5
- Custom roles: ___ / 5

**Overall Module Confidence:** ___ / 5

## 📚 Additional Resources

- [Azure RBAC Overview](https://learn.microsoft.com/en-us/azure/role-based-access-control/overview)
- [Built-in Roles](https://learn.microsoft.com/en-us/azure/role-based-access-control/built-in-roles)
- [Create Custom Roles](https://learn.microsoft.com/en-us/azure/role-based-access-control/custom-roles)

## 🚀 Next Steps

After completing this module:
1. Review RBAC model understanding
2. Move to Module 3: Subscriptions & Governance
3. Continue with the 15-day study plan

---

**Status:** ⏳ Ready to Start  
**Time Estimate:** 5 hours  
**Difficulty:** Intermediate  
**Prerequisites Met:** ✅ Yes (after Module 1)

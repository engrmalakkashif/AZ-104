# AZ-104 Study Plan - Quick Start Guide

**Start Here! 👇**

---

## 🚀 Getting Started (5 minutes)

### Step 1: Understand What You're Getting
You have a **complete 15-day study plan** with:
- ✅ **3 Detailed Modules** (Days 1-3) ready to use
- ✅ **12 More Modules** outlined in the overview (Days 4-15)
- ✅ **75 hours** of structured learning material
- ✅ **Hands-on lab exercises** with expected outputs
- ✅ **PowerShell & CLI commands** for practice

### Step 2: Choose Your Path

**Option A: Start Today (Days 1-3)**
```
Day 1 → Module 1: Microsoft Entra Users & Groups
Day 2 → Module 2: Access Control & RBAC
Day 3 → Module 3: Governance & Policies
```

**Option B: Review First, Then Start**
```
1. Read: README.md (complete overview)
2. Read: 15-DAY-STUDY-PLAN-OVERVIEW.md (study schedule)
3. Then start Day 1 module
```

### Step 3: Get Your Azure Subscription Ready
```bash
# If you don't have Azure subscription, create free one:
# https://azure.microsoft.com/en-us/free/

# If you have subscription, sign in:
az login
# or
Connect-AzAccount  # PowerShell
```

---

## 📂 File Organization

```
AZ-104/
├── README.md                                    ← START HERE
├── QUICK-START.md                              ← YOU ARE HERE
├── 15-DAY-STUDY-PLAN-OVERVIEW.md              ← Study schedule
│
├── WEEK 1: IDENTITIES & GOVERNANCE
│   ├── Module-01-Azure-Identities-and-Governance-Part1.md
│   ├── Module-02-Azure-Identities-and-Governance-Part2.md
│   └── Module-03-Azure-Subscriptions-Governance.md
│
├── WEEK 2-4: Additional Modules
│   ├── Module-04 through Module-15 (outlined, to be created)
│
└── RESOURCES/
    └── (Additional reference materials)
```

---

## 📖 How to Read Each Module

Each module follows this structure:

```
1. LEARNING OBJECTIVES (2 min)
   └─ What you'll learn today

2. THEORY & CONCEPTS (60 min)
   └─ Read the concepts section carefully
   └─ Understand key principles
   └─ Review diagrams and examples

3. LAB NOTES & SETUP (10 min)
   └─ Check prerequisites
   └─ Create test resources
   └─ Note important URLs

4. LAB EXERCISES (150 min) ⭐ HANDS-ON
   └─ Follow step-by-step instructions
   └─ Complete all exercises
   └─ Verify outputs match expected results

5. QUICK REFERENCE (10 min)
   └─ Copy PowerShell commands
   └─ Copy Azure CLI commands

6. REVIEW & SUMMARY (20 min)
   └─ Complete self-assessment
   └─ Note areas for further study
   └─ Mark module as complete
```

**⏱️ TOTAL: 5 hours per module**

---

## 📋 Module Completion Checklist

### Day 1: Module 1 Checklist
- [ ] Read Learning Objectives
- [ ] Study all Theory & Concepts
- [ ] Create test Azure subscription resources
- [ ] Complete Exercise 1.1: Create cloud user
- [ ] Complete Exercise 1.2: Create dynamic group
- [ ] Complete Exercise 1.3: Assign license
- [ ] Review PowerShell commands
- [ ] Complete self-assessment
- [ ] Document any issues

### Day 2: Module 2 Checklist
- [ ] Read Learning Objectives
- [ ] Study RBAC theory
- [ ] Complete Exercise 2.1: Assign roles at different scopes
- [ ] Complete Exercise 2.2: Check effective permissions
- [ ] Complete Exercise 2.3: Create custom role
- [ ] Complete Exercise 2.4: Remove access (cleanup)
- [ ] Understand scope inheritance
- [ ] Complete self-assessment

### Day 3: Module 3 Checklist
- [ ] Read Learning Objectives
- [ ] Study Policy, Locks, Tags concepts
- [ ] Complete Exercise 3.1: Apply location policy
- [ ] Complete Exercise 3.2: Create tag enforcement policy
- [ ] Complete Exercise 3.3: Apply resource locks
- [ ] Complete Exercise 3.4: Apply and filter tags
- [ ] Complete Exercise 3.5 (optional): Management groups
- [ ] Complete self-assessment

---

## 🛠️ Prerequisites Checklist

Before starting Module 1, ensure you have:

```
✅ REQUIRED
  [ ] Azure Subscription (free tier acceptable)
  [ ] Access to Azure Portal (portal.azure.com)
  [ ] Access to Microsoft Entra Admin Center (entra.microsoft.com)
  [ ] Global Administrator or User Administrator role
  [ ] 5 hours of uninterrupted study time

✅ RECOMMENDED
  [ ] PowerShell installed with Az module
  [ ] Azure CLI installed
  [ ] Visual Studio Code
  [ ] 2-3 test users created in your tenant

✅ OPTIONAL
  [ ] Notepad or OneNote for notes
  [ ] Second monitor for documentation
  [ ] Headphones if watching accompanying videos
```

### Installation Commands

```bash
# Install Azure CLI (Linux/Mac/Windows)
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

# Install Azure PowerShell
# From PowerShell:
Install-Module -Name Az -AllowClobber -Force

# Update to latest
Update-Module -Name Az -Force

# Verify installation
az version
Get-Module Az -ListAvailable
```

---

## 🎯 First 5 Hours (Day 1) - Detailed Timeline

### Hour 1: Theory (60 min)
```
0:00-0:15  Read Module 1 title and objectives
0:15-0:45  Study Section 1.1-1.3 (Users, Groups, Properties)
0:45-1:00  Study Section 1.4-1.6 (Licensing, External Users, SSPR)
```

### Hour 2-4: Lab Exercises (180 min)
```
1:00-1:30  Exercise 1.1: Create cloud user
1:30-2:00  Exercise 1.2: Create dynamic group
2:00-2:30  Exercise 1.3: Assign license to user
2:30-3:00  Exercise 1.1-1.3 Verification
3:00-3:30  Try PowerShell alternatives to portal
3:30-4:00  Troubleshoot any issues
```

### Hour 5: Review & Wrap-up (30 min)
```
4:00-4:15  Quick Fact Check - verify understanding
4:15-4:25  Read Key Takeaways
4:25-4:30  Rate self-assessment (1-5 scale)
4:30       Mark Day 1 as complete!
```

---

## ✅ How to Know You're Ready for Day 2

Before moving to Day 2 (Module 2), verify you can:

- ✅ Create a cloud user in Microsoft Entra ID
- ✅ Explain what a dynamic group is
- ✅ Assign a license to a user
- ✅ Understand the difference between SSPR and MFA
- ✅ Use PowerShell to create users
- ✅ Create a user via portal AND CLI
- ✅ Explain external user management basics

**If you cannot do all of these, review Module 1 again before Day 2.**

---

## 🔍 Expected Outputs - Module 1

When you complete Day 1 exercises, you should have:

### In Your Azure Tenant:
```
✅ Users Created:
  - john.smith@yourtenant.onmicrosoft.com (Sales Manager)
  - Additional test users (at least 2 more)

✅ Groups Created:
  - Sales-Department-Group (Dynamic)
  - Members auto-populated based on department

✅ Licenses Assigned:
  - Microsoft 365 P1 or P2 licenses on test users
```

### In Your Notes:
```
✅ Notes on:
  - User principal name format
  - How dynamic groups work
  - License assignment process
  - PowerShell commands you learned
```

---

## 💡 Study Tips for Success

### ✅ DO:
- ✅ Complete labs hands-on in Azure Portal
- ✅ Follow instructions exactly as written first time
- ✅ Take screenshots of successful lab outputs
- ✅ Try each PowerShell command
- ✅ Repeat failed exercises until successful
- ✅ Use multiple methods (Portal + CLI + PowerShell)
- ✅ Note down commands you'll need for exam
- ✅ Join study groups or forums

### ❌ DON'T:
- ❌ Skip lab exercises - they're critical
- ❌ Just read without doing - hands-on is essential
- ❌ Move to next day if you don't understand
- ❌ Rely on videos alone - you need practice
- ❌ Rush through modules to "save time"
- ❌ Ignore errors - troubleshoot them thoroughly
- ❌ Create real production resources for testing
- ❌ Use real company data in labs

---

## 🆘 Getting Help

### If You Get Stuck:

**For technical errors in Azure:**
1. Read error message carefully
2. Check Module's troubleshooting section
3. Search Microsoft Learn documentation
4. Ask on Microsoft Q&A: https://learn.microsoft.com/en-us/answers/

**For understanding concepts:**
1. Re-read the theory section
2. Watch related Microsoft Learn video
3. Search Stack Overflow with your question
4. Join Azure Discord/Reddit communities

**For lab issues:**
1. Delete the resource and restart exercise
2. Check prerequisites are met
3. Verify you have correct permissions
4. Review the "Expected Output" section

---

## 🎓 After Each Day

### Daily Checklist:
- [ ] Completed all required exercises
- [ ] Verified expected outputs
- [ ] Reviewed PowerShell commands
- [ ] Completed self-assessment
- [ ] Documented any challenges
- [ ] Cleaned up test resources (or kept for next module)
- [ ] Feel confident about today's topics

### Before Moving to Next Day:
- [ ] Understand today's key concepts
- [ ] Can explain topics to someone else
- [ ] Feel ready for knowledge building on next day

---

## 📊 Progress Tracking

### Print and Fill This Out:

```
WEEK 1 PROGRESS:

Day 1: Module 1 - Identities & Users
Completed: [ ] Not Yet [ ] In Progress [ ] ✅ Complete
Self-Assessment Score: ___ / 5
Confidence Level: Low [ ] Medium [ ] High [ ]
Issues Encountered: _________________

Day 2: Module 2 - Access Control & RBAC
Completed: [ ] Not Yet [ ] In Progress [ ] ✅ Complete
Self-Assessment Score: ___ / 5
Confidence Level: Low [ ] Medium [ ] High [ ]
Issues Encountered: _________________

Day 3: Module 3 - Governance & Policies
Completed: [ ] Not Yet [ ] In Progress [ ] ✅ Complete
Self-Assessment Score: ___ / 5
Confidence Level: Low [ ] Medium [ ] High [ ]
Issues Encountered: _________________

WEEK 1 SUMMARY:
Topics Mastered: ___________________________
Areas for Review: ___________________________
Ready for Week 2: [ ] Yes [ ] Need More Review
```

---

## 🚀 Next Steps After Day 3

### Complete Week 1 ✅
You'll understand:
- ✅ How to manage Azure identities
- ✅ How RBAC works
- ✅ How to enforce governance policies

### Ready for Week 2
- Days 4-6: **Azure Storage Services**
- Days 7: **Virtual Machines**

### Start Day 4 When:
- [ ] All Day 3 exercises completed
- [ ] You understand RBAC model (Principal + Role + Scope)
- [ ] You can explain policy effects (Deny, Audit, Modify, etc.)
- [ ] You have 5 hours available for Day 4

---

## 📞 Support Resources

**Official Microsoft:**
- Azure Portal: https://portal.azure.com
- Microsoft Learn: https://learn.microsoft.com
- Microsoft Q&A: https://learn.microsoft.com/en-us/answers/

**Communities:**
- Reddit: https://reddit.com/r/Azure
- Stack Overflow: https://stackoverflow.com/questions/tagged/azure
- Microsoft Tech Community: https://techcommunity.microsoft.com

**Guides Included:**
- README.md (Complete overview)
- 15-DAY-STUDY-PLAN-OVERVIEW.md (Full schedule)
- This file: QUICK-START.md

---

## ✨ You're Ready!

Everything you need is prepared:
- ✅ **3 Complete Modules** (Days 1-3) with full labs
- ✅ **Study Plan** for all 15 days
- ✅ **PowerShell & CLI references**
- ✅ **Expected outputs** for verification
- ✅ **Self-assessment tools**

**Start with Day 1 Module 1, and follow the structure. You'll have all the knowledge needed for the AZ-104 exam in 15 days!**

---

## 🎯 Ready to Begin?

### ➡️ Next Action: Open [Module-01-Azure-Identities-and-Governance-Part1.md](Module-01-Azure-Identities-and-Governance-Part1.md)

---

**Let's go! You're going to ace this! 🚀**

---

**Created:** 2026  
**Version:** 1.0  
**Next Review:** After completing Day 1

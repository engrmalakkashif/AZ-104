#!/bin/bash

# Module data: number|name|key_topics|exercises|day
modules_data=(
    "04|Virtual Networking|VNet, Subnets, Peering, DNS|4 exercises|4"
    "05|Network Security|NSGs, Firewalls, DDoS, Private Link|4 exercises|5"
    "06|Virtual Machines|VM creation, Image gallery, Extensions|5 exercises|6"
    "07|Storage Accounts|Blob, Queue, File, Table storage|4 exercises|7"
    "08|Azure SQL Database|Databases, Backups, Query performance|4 exercises|8"
    "09|Azure App Service|Web apps, Deployment slots, Scaling|4 exercises|9"
    "10|Containers & AKS|Docker, Container Registry, Kubernetes|4 exercises|10"
    "11|Azure Functions|Functions, Triggers, Bindings|4 exercises|11"
    "12|Monitoring & Logging|Application Insights, Log Analytics|4 exercises|12"
    "13|Backup & Recovery|Backups, Site Recovery, Restore|4 exercises|13"
    "14|Security & Compliance|Key Vault, Encryption, Security Center|4 exercises|14"
    "15|Cost Management|Cost Analysis, Budgets, Reservations|3 exercises|15"
)

for data in "${modules_data[@]}"; do
    IFS='|' read -r num name topics exercises day <<< "$data"
    
    module_dir="Module-${num}-${name// /-}"
    
    # Create README.md
    cat > "$module_dir/README.md" << 'READMEEOF'
# Module MODNUM: MODNAME

**Module:** MODNUM  
**Day:** DAY  
**Duration:** 5 hours (Theory 1hr + Labs 3hrs + Review 1hr)  
**Difficulty:** Intermediate

---

## 📚 Module Overview

This module covers KEY_TOPICS and provides hands-on lab experience with Azure services.

### What You'll Learn
- ✅ MODNAME fundamentals
- ✅ Configuration and best practices
- ✅ Hands-on lab exercises
- ✅ PowerShell automation

### Prerequisites
- ✅ Completed Modules 1-PREVMOD
- ✅ Azure subscription
- ✅ Contributor role
- ✅ Azure Portal access

---

## 📋 Module Contents

### Content Section
- **Theory & Concepts** - Deep dive into MODNAME
- **Architecture Patterns** - Best practices and design
- **Configuration Guide** - Step-by-step setup

### Labs Section
- **Lab Notes** - Environment setup and objectives
- **Lab Exercises** - EXERCISES hands-on tasks
- **Expected Outputs** - Success criteria for each exercise

### Resources Section
- **PowerShell Commands** - 50+ commands for MODNAME
- **Quick Reference** - Cheat sheet and troubleshooting

---

## 🎯 Learning Objectives

By completing this module, you will:
1. Understand MODNAME architecture and components
2. Configure MODNAME resources in Azure
3. Implement best practices
4. Complete all lab exercises
5. Automate tasks with PowerShell

---

## ⏱️ Time Breakdown

| Activity | Time |
|----------|------|
| Theory & Concepts | 1 hour |
| Lab Exercises | 3 hours |
| Review & Practice | 1 hour |
| **Total** | **5 hours** |

---

## 📝 Lab Exercises

- **Exercise MODNUM.1:** Basic setup and configuration
- **Exercise MODNUM.2:** Advanced features
- **Exercise MODNUM.3:** Performance optimization
- **Exercise MODNUM.4:** Monitoring and troubleshooting

See LAB-EXERCISES.md for detailed step-by-step instructions.

---

## 🚀 Quick Start

1. Read content overview in `content/` directory
2. Review LAB-NOTES.md for environment setup
3. Complete LAB-EXERCISES.md step by step
4. Reference POWERSHELL-COMMANDS.ps1 for automation
5. Use QUICK-REFERENCE.md for troubleshooting

---

## 📚 Related Modules

- **Before:** Complete Modules 1-PREVMOD
- **After:** Proceed to Module NEXTMOD
- **Related:** Modules with similar topics

---

## ✅ Completion Checklist

- [ ] Read theory content
- [ ] Completed all EXERCISES exercises
- [ ] All lab outputs verified
- [ ] Reviewed PowerShell commands
- [ ] Completed review section
- [ ] Ready for next module

---

## 📞 Support

For questions about this module:
1. Review QUICK-REFERENCE.md troubleshooting section
2. Check LAB-NOTES.md prerequisites
3. Refer to PowerShell commands and examples
4. Review Azure documentation links in content

---

**Continue with LAB-NOTES.md to begin! 🚀**

READMEEOF
    
    # Replace placeholders
    sed -i "s/MODNUM/$num/g" "$module_dir/README.md"
    sed -i "s/MODNAME/$name/g" "$module_dir/README.md"
    sed -i "s/DAY/$day/g" "$module_dir/README.md"
    sed -i "s/KEY_TOPICS/$topics/g" "$module_dir/README.md"
    sed -i "s/EXERCISES/$exercises/g" "$module_dir/README.md"
    sed -i "s/PREVMOD/$((num-1))/g" "$module_dir/README.md"
    sed -i "s/NEXTMOD/$((num+1))/g" "$module_dir/README.md"
    
    # Create SUMMARY.md
    cat > "$module_dir/SUMMARY.md" << 'SUMMARYEOF'
# Module MODNUM: MODNAME - Key Takeaways

**Module:** MODNUM | **Day:** DAY | **Status:** Complete  
**Topics:** KEY_TOPICS

---

## 🎯 Key Concepts

### 1. Core Concept 1
- Definition and purpose
- When to use
- Best practices

### 2. Core Concept 2
- Architecture
- Configuration options
- Performance considerations

### 3. Core Concept 3
- Security aspects
- Compliance requirements
- Monitoring approach

---

## 📊 Architecture Overview

```
[Component A] ←→ [Service] ←→ [Component B]
     ↓                              ↓
   Setup               Configuration Required
```

---

## ✅ Self-Assessment

**Can you explain:**
- [ ] What is MODNAME?
- [ ] When would you use it?
- [ ] How to configure it?
- [ ] Key security considerations?
- [ ] How to troubleshoot issues?

**If you answered YES to all, you've mastered the module!**

---

## 📈 Performance Tips

1. **Tip 1:** Best practice for performance
2. **Tip 2:** Optimization technique
3. **Tip 3:** Cost saving strategy

---

## 🔐 Security Checklist

- [ ] Enable all security features
- [ ] Configure firewall rules
- [ ] Enable monitoring/logging
- [ ] Set up alerts
- [ ] Document security controls

---

## 📚 Next Steps

1. ✅ Complete all lab exercises
2. ✅ Practice PowerShell commands
3. ✅ Review troubleshooting guide
4. ✅ Move to Module NEXTMOD

---

**Great job! You've completed Module MODNUM! 🎉**

SUMMARYEOF
    
    # Replace placeholders
    sed -i "s/MODNUM/$num/g" "$module_dir/SUMMARY.md"
    sed -i "s/MODNAME/$name/g" "$module_dir/SUMMARY.md"
    sed -i "s/DAY/$day/g" "$module_dir/SUMMARY.md"
    sed -i "s/KEY_TOPICS/$topics/g" "$module_dir/SUMMARY.md"
    sed -i "s/NEXTMOD/$((num+1))/g" "$module_dir/SUMMARY.md"
    
    # Create content/README.md
    cat > "$module_dir/content/README.md" << 'CONTENTEOF'
# Module MODNUM: MODNAME - Content Guide

## 📚 Theory & Concepts

This directory contains theoretical background and conceptual materials for MODNAME.

### Topics Covered
- KEY_TOPICS

### Learning Path

1. **Introduction** - Overview of MODNAME
2. **Architecture** - How components work together
3. **Components** - Detailed explanation of each part
4. **Best Practices** - Recommended patterns
5. **Use Cases** - Real-world scenarios

### Files

- `XX-theory-and-concepts.md` - Comprehensive theory material

---

## 🎯 How to Use This Content

1. Read sequentially for first-time learning
2. Reference sections for quick lookup
3. Study diagrams and architecture
4. Take notes on key concepts
5. Move to labs when ready

---

## ✅ Concepts You Should Understand

- [ ] Concept 1
- [ ] Concept 2
- [ ] Concept 3
- [ ] Concept 4

---

**Ready for labs? Move to `../labs/LAB-NOTES.md`**

CONTENTEOF
    
    sed -i "s/MODNUM/$num/g" "$module_dir/content/README.md"
    sed -i "s/MODNAME/$name/g" "$module_dir/content/README.md"
    sed -i "s/KEY_TOPICS/$topics/g" "$module_dir/content/README.md"
    
    echo "✓ Populated $module_dir with README.md, SUMMARY.md, and content structure"
done

echo ""
echo "✅ All modules populated with structure!"

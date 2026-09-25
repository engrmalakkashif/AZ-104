#!/bin/bash

# Module definitions (name, description, number of exercises)
declare -a modules=(
    "04|Virtual Networking|Basic networking concepts and setup"
    "05|Network Security|NSGs, firewalls, and security"
    "06|Virtual Machines|VM creation and management"
    "07|Storage Accounts|Storage types and configuration"
    "08|Azure SQL Database|Database setup and management"
    "09|Azure App Service|Web apps and deployment"
    "10|Containers & AKS|Docker and Kubernetes"
    "11|Azure Functions|Serverless computing"
    "12|Monitoring & Logging|Application Insights and Log Analytics"
    "13|Backup & Recovery|Disaster recovery solutions"
    "14|Security & Compliance|Advanced security features"
    "15|Cost Management|Azure cost optimization"
)

# Create module directories
for module_info in "${modules[@]}"; do
    IFS='|' read -r num name desc <<< "$module_info"
    
    module_dir="Module-${num}-${name// /-}"
    echo "Creating $module_dir..."
    
    # Create main directories
    mkdir -p "$module_dir/content"
    mkdir -p "$module_dir/labs"
    mkdir -p "$module_dir/resources"
    
    # Create placeholder files
    touch "$module_dir/README.md"
    touch "$module_dir/SUMMARY.md"
    touch "$module_dir/content/README.md"
    touch "$module_dir/labs/LAB-NOTES.md"
    touch "$module_dir/labs/LAB-EXERCISES.md"
    touch "$module_dir/resources/POWERSHELL-COMMANDS.ps1"
    touch "$module_dir/resources/QUICK-REFERENCE.md"
    
    echo "✓ Created $module_dir with all subdirectories and files"
done

echo ""
echo "✅ All module directories created successfully!"

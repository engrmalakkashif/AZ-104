# Day 7 Azure Storage Account examples.
# Review current regional SKU support and pricing before creating resources.
# Never paste account keys or SAS tokens into this script.

Connect-AzAccount
Get-AzContext

$resourceGroup = 'az104-storage-lab'
$location = 'eastus'
$storageAccount = 'az104store12345' # Replace with a globally unique lowercase name.

# Create only in an authorized disposable subscription after checking cost.
New-AzResourceGroup -Name $resourceGroup -Location $location
New-AzStorageAccount -ResourceGroupName $resourceGroup `
	-Name $storageAccount `
	-Location $location `
	-SkuName Standard_LRS `
	-Kind StorageV2 `
	-EnableHttpsTrafficOnly $true `
	-MinimumTlsVersion TLS1_2

Get-AzStorageAccount -ResourceGroupName $resourceGroup

# Cleanup is intentionally not automatic. After verifying the RG contains only
# disposable lab resources, remove it manually with Remove-AzResourceGroup.

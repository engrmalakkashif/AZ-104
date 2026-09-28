# Day 10 Azure Files management-plane examples.
# Check account/share pricing and protocol support before creating resources.
Connect-AzAccount
$resourceGroup = 'replace-with-resource-group'
$accountName = 'az104store12345' # Replace with the lab account's actual name.

Get-AzStorageAccount -ResourceGroupName $resourceGroup -Name $accountName
Get-AzStorageShare -ResourceGroupName $resourceGroup -StorageAccountName $accountName

# Create a small-quota share only in an authorized disposable account.
# New-AzRmStorageShare -ResourceGroupName $resourceGroup `
#     -StorageAccountName $accountName -Name 'labshare' -QuotaGiB 1

# Never print or save account keys. Use the Portal's Connect instructions and
# supported identity authentication for client mounting where configured.
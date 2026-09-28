# Day 9 read-only protection inspection. Avoid emitting keys or SAS secrets.
Connect-AzAccount
$resourceGroup = 'replace-with-resource-group'
$accountName = 'az104store12345' # Replace with the lab account's actual name.

$account = Get-AzStorageAccount -ResourceGroupName $resourceGroup `
    -Name $accountName
$account | Select-Object StorageAccountName, Location, Sku, EnableHttpsTrafficOnly

# Inspect blob service protection configuration where supported.
Get-AzStorageBlobServiceProperty -ResourceGroupName $resourceGroup `
    -StorageAccountName $accountName

# This script intentionally does not generate SAS tokens or print account keys.
# Configure protection changes only on an authorized disposable account.
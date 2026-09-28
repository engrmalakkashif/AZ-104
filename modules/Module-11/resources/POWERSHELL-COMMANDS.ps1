# Day 11 read-only storage operations examples.
# Prefer identity-based access; do not store account keys or SAS in this file.
Connect-AzAccount
$resourceGroup = 'replace-with-resource-group'
$accountName = 'az104store12345' # Replace with the lab account's actual name.

$account = Get-AzStorageAccount -ResourceGroupName $resourceGroup -Name $accountName
$context = New-AzStorageContext -StorageAccountName $accountName -UseConnectedAccount
Get-AzStorageContainer -Context $context
Get-AzStorageBlob -Container 'lab-private' -Context $context

# Configure lifecycle and object replication only after reviewing scope,
# prerequisites and cost. These operations are asynchronous.
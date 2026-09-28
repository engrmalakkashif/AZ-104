# Day 8 Blob Storage examples using the signed-in Entra identity.
# The identity needs a suitable Blob data-plane role on the account/container.
# Use only a private disposable container and non-sensitive test files.

Connect-AzAccount
$accountName = 'az104store12345' # Replace with the lab account's actual name.
$containerName = 'lab-private'
$context = New-AzStorageContext -StorageAccountName $accountName -UseConnectedAccount

Get-AzStorageContainer -Context $context
New-AzStorageContainer -Name $containerName -Context $context -Permission Off

$localFile = '.\sample.txt'
Set-Content -Path $localFile -Value 'AZ-104 test object'
Set-AzStorageBlobContent -File $localFile -Container $containerName `
    -Blob 'sample.txt' -Context $context
Get-AzStorageBlob -Container $containerName -Context $context
Get-AzStorageBlobContent -Container $containerName -Blob 'sample.txt' `
    -Destination '.\downloaded-sample.txt' -Context $context

# Delete only the test blob/container you created after verifying the names.
# Remove-AzStorageBlob -Container $containerName -Blob 'sample.txt' -Context $context
# Remove-AzStorageContainer -Name $containerName -Context $context
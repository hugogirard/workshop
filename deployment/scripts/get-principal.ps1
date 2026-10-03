#!/usr/bin/env pwsh
# Resolves the signed-in Azure CLI user and stores their email + object id in the azd environment.
$ErrorActionPreference = 'Stop'

$user = az ad signed-in-user show --query "{id:id, upn:userPrincipalName, mail:mail}" -o json | ConvertFrom-Json
if (-not $user -or -not $user.id) {
    throw "Could not read the signed-in user. Run 'az login' first."
}

$email = if ($user.mail) { $user.mail } else { $user.upn }

azd env set AZURE_PRINCIPAL_ID $user.id
azd env set ADMIN_EMAIL $email

Write-Host "Signed-in user: $email ($($user.id))"

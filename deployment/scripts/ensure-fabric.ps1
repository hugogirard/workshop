#!/usr/bin/env pwsh
# Resumes the workshop's Fabric capacity if it exists and is paused — a paused capacity
# rejects ARM updates ("Service is not ready to be updated"), which breaks azd provision.
$ErrorActionPreference = 'Stop'

$rg = az group list --tag "azd-env-name=$($env:AZURE_ENV_NAME)" --query "[0].name" -o tsv
if (-not $rg) {
    Write-Host "No resource group yet for env '$($env:AZURE_ENV_NAME)'; nothing to resume."
    return
}

$names = az resource list --resource-group $rg --resource-type Microsoft.Fabric/capacities --query "[].name" -o tsv
if (-not $names) {
    Write-Host "No Fabric capacity in '$rg'; nothing to resume."
    return
}

foreach ($name in ($names -split "`n" | Where-Object { $_ })) {
    $state = az resource show --resource-group $rg --resource-type Microsoft.Fabric/capacities --name $name --api-version 2023-11-01 --query "properties.state" -o tsv
    if ($state -ne 'Paused') {
        Write-Host "Fabric capacity '$name' state is '$state'; no action needed."
        continue
    }

    Write-Host "Fabric capacity '$name' is Paused; resuming so it can be updated..."
    az resource invoke-action --resource-group $rg --resource-type Microsoft.Fabric/capacities --name $name --api-version 2023-11-01 --action resume | Out-Null

    # Wait until the capacity is Active; ARM also rejects updates while it is Resuming.
    for ($i = 0; $i -lt 60; $i++) {
        $s = az resource show --resource-group $rg --resource-type Microsoft.Fabric/capacities --name $name --api-version 2023-11-01 --query "properties.state" -o tsv
        if ($s -eq 'Active') { break }
        Start-Sleep -Seconds 10
    }
    Write-Host "Fabric capacity '$name' is now '$s'."
}

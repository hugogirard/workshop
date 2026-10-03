#!/usr/bin/env pwsh
# Builds the workshop + Caddy images with ACR Tasks and runs them as a public
# multi-container Azure Container Instance with automatic HTTPS (Let's Encrypt).
$ErrorActionPreference = 'Stop'

$acr = $env:containerRegistryName
$resourceGroup = $env:resourceGroupName
if (-not $acr) { throw "containerRegistryName is not set. Run 'azd provision' first." }
if (-not $resourceGroup) { throw "resourceGroupName is not set. Run 'azd provision' first." }

$image = 'fabric-workshop:latest'
$caddyImage = 'fabric-caddy:latest'
$containerName = 'fabric-workshop'
$dnsLabel = "contosomart-$($env:AZURE_ENV_NAME)".ToLower()
$adminEmail = $env:ADMIN_EMAIL

$location = az group show --name $resourceGroup --query location -o tsv
$fqdn = "$dnsLabel.$location.azurecontainer.io"

Write-Host "Building $image in registry $acr (ACR Tasks)..."
az acr build --registry $acr --image $image . | Out-Host

Write-Host "Building $caddyImage in registry $acr (ACR Tasks)..."
az acr build --registry $acr --image $caddyImage ./deployment/caddy | Out-Host

$loginServer = az acr show --name $acr --query loginServer -o tsv
$acrUser = az acr credential show --name $acr --query username -o tsv
$acrPassword = az acr credential show --name $acr --query "passwords[0].value" -o tsv

# Azure Files share persists Caddy's TLS certs across restarts (avoids Let's Encrypt rate limits).
$storage = ('st' + ($acr -replace '^cr', '')).ToLower()
if ($storage.Length -gt 24) { $storage = $storage.Substring(0, 24) }
$share = 'caddydata'
Write-Host "Ensuring storage account $storage and share $share..."
az storage account create --name $storage --resource-group $resourceGroup --location $location --sku Standard_LRS --only-show-errors | Out-Null
$storageKey = az storage account keys list --account-name $storage --resource-group $resourceGroup --query "[0].value" -o tsv
az storage share create --name $share --account-name $storage --account-key $storageKey --only-show-errors | Out-Null

# Container Instances needs its resource provider registered once per subscription.
az provider register --namespace Microsoft.ContainerInstance --wait | Out-Null

$yaml = @"
name: $containerName
apiVersion: '2021-10-01'
location: $location
properties:
  osType: Linux
  restartPolicy: Always
  imageRegistryCredentials:
    - server: $loginServer
      username: $acrUser
      password: $acrPassword
  containers:
    - name: caddy
      properties:
        image: $loginServer/$caddyImage
        ports:
          - protocol: TCP
            port: 80
          - protocol: TCP
            port: 443
        environmentVariables:
          - name: SITE_ADDRESS
            value: $fqdn
          - name: ACME_EMAIL
            value: $adminEmail
        resources:
          requests:
            cpu: 1
            memoryInGB: 1
        volumeMounts:
          - name: caddy-data
            mountPath: /data
    - name: fabric-workshop
      properties:
        image: $loginServer/$image
        resources:
          requests:
            cpu: 1
            memoryInGB: 1
  ipAddress:
    type: Public
    dnsNameLabel: $dnsLabel
    ports:
      - protocol: TCP
        port: 80
      - protocol: TCP
        port: 443
  volumes:
    - name: caddy-data
      azureFile:
        shareName: $share
        storageAccountName: $storage
        storageAccountKey: $storageKey
"@

$yamlPath = Join-Path ([System.IO.Path]::GetTempPath()) 'fabric-workshop-aci.yaml'
$yaml | Out-File -FilePath $yamlPath -Encoding ascii

Write-Host "Deploying multi-container group $containerName..."
az container create --resource-group $resourceGroup --file $yamlPath | Out-Host

$url = "https://$fqdn"
azd env set WORKSHOP_URL $url
Write-Host "Workshop is live at: $url"
Write-Host "Caddy may take 1-2 minutes to obtain the TLS certificate on first start."

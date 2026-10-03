#!/usr/bin/env bash
# Builds the workshop + Caddy images with ACR Tasks and runs them as a public
# multi-container Azure Container Instance with automatic HTTPS (Let's Encrypt).
set -euo pipefail

acr="${containerRegistryName:-}"
resourceGroup="${resourceGroupName:-}"
if [ -z "$acr" ]; then echo "containerRegistryName is not set. Run 'azd provision' first." >&2; exit 1; fi
if [ -z "$resourceGroup" ]; then echo "resourceGroupName is not set. Run 'azd provision' first." >&2; exit 1; fi

image='fabric-workshop:latest'
caddyImage='fabric-caddy:latest'
containerName='fabric-workshop'
dnsLabel="$(echo "contosomart-${AZURE_ENV_NAME}" | tr '[:upper:]' '[:lower:]')"
adminEmail="${ADMIN_EMAIL:-}"

location=$(az group show --name "$resourceGroup" --query location -o tsv)
fqdn="$dnsLabel.$location.azurecontainer.io"

echo "Building $image in registry $acr (ACR Tasks)..."
az acr build --registry "$acr" --image "$image" .

echo "Building $caddyImage in registry $acr (ACR Tasks)..."
az acr build --registry "$acr" --image "$caddyImage" ./deployment/caddy

loginServer=$(az acr show --name "$acr" --query loginServer -o tsv)
acrUser=$(az acr credential show --name "$acr" --query username -o tsv)
acrPassword=$(az acr credential show --name "$acr" --query "passwords[0].value" -o tsv)

# Azure Files share persists Caddy's TLS certs across restarts (avoids Let's Encrypt rate limits).
storage="st$(echo "$acr" | sed 's/^cr//')"
storage="$(echo "$storage" | cut -c1-24 | tr '[:upper:]' '[:lower:]')"
share='caddydata'
echo "Ensuring storage account $storage and share $share..."
az storage account create --name "$storage" --resource-group "$resourceGroup" --location "$location" --sku Standard_LRS --only-show-errors >/dev/null
storageKey=$(az storage account keys list --account-name "$storage" --resource-group "$resourceGroup" --query "[0].value" -o tsv)
az storage share create --name "$share" --account-name "$storage" --account-key "$storageKey" --only-show-errors >/dev/null

# Container Instances needs its resource provider registered once per subscription.
az provider register --namespace Microsoft.ContainerInstance --wait >/dev/null

yamlPath="$(mktemp -t fabric-workshop-aci.XXXXXX.yaml)"
cat > "$yamlPath" <<YAML
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
YAML

echo "Deploying multi-container group $containerName..."
az container create --resource-group "$resourceGroup" --file "$yamlPath"

url="https://$fqdn"
azd env set WORKSHOP_URL "$url"
echo "Workshop is live at: $url"
echo "Caddy may take 1-2 minutes to obtain the TLS certificate on first start."

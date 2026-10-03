#!/usr/bin/env bash
# Resumes the workshop's Fabric capacity if it exists and is paused — a paused capacity
# rejects ARM updates ("Service is not ready to be updated"), which breaks azd provision.
set -euo pipefail

rg=$(az group list --tag "azd-env-name=${AZURE_ENV_NAME}" --query "[0].name" -o tsv)
if [ -z "$rg" ]; then
  echo "No resource group yet for env '${AZURE_ENV_NAME}'; nothing to resume."
  exit 0
fi

names=$(az resource list --resource-group "$rg" --resource-type Microsoft.Fabric/capacities --query "[].name" -o tsv)
if [ -z "$names" ]; then
  echo "No Fabric capacity in '$rg'; nothing to resume."
  exit 0
fi

while IFS= read -r name; do
  [ -z "$name" ] && continue
  state=$(az resource show --resource-group "$rg" --resource-type Microsoft.Fabric/capacities --name "$name" --api-version 2023-11-01 --query "properties.state" -o tsv)
  if [ "$state" != "Paused" ]; then
    echo "Fabric capacity '$name' state is '$state'; no action needed."
    continue
  fi

  echo "Fabric capacity '$name' is Paused; resuming so it can be updated..."
  az resource invoke-action --resource-group "$rg" --resource-type Microsoft.Fabric/capacities --name "$name" --api-version 2023-11-01 --action resume >/dev/null

  # Wait until the capacity is Active; ARM also rejects updates while it is Resuming.
  for _ in $(seq 1 60); do
    s=$(az resource show --resource-group "$rg" --resource-type Microsoft.Fabric/capacities --name "$name" --api-version 2023-11-01 --query "properties.state" -o tsv)
    [ "$s" = "Active" ] && break
    sleep 10
  done
  echo "Fabric capacity '$name' is now '$s'."
done <<< "$names"

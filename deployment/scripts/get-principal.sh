#!/usr/bin/env bash
# Resolves the signed-in Azure CLI user and stores their email + object id in the azd environment.
set -euo pipefail

id=$(az ad signed-in-user show --query id -o tsv)
upn=$(az ad signed-in-user show --query userPrincipalName -o tsv)
mail=$(az ad signed-in-user show --query mail -o tsv)

email="${mail:-$upn}"

if [ -z "$id" ]; then
  echo "Could not read the signed-in user. Run 'az login' first." >&2
  exit 1
fi

azd env set AZURE_PRINCIPAL_ID "$id"
azd env set ADMIN_EMAIL "$email"

echo "Signed-in user: $email ($id)"

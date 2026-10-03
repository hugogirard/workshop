# Workshop infrastructure (Bicep + azd)

This folder is where the Azure infrastructure for the workshops lives. Running
`azd provision` from the repo root deploys it from [`main.bicep`](main.bicep).

It is meant to stand up the shared backend every lab assumes:

- a **Microsoft Fabric capacity** (so you don't rely on a trial),
- an **Azure AI Foundry** resource + project, and
- a **model deployment** the Foundry agents use.

> The Bicep here is a **starter stub** — add your Fabric capacity, Foundry resource,
> and model deployment to `main.bicep` (or modules under `modules/`). Pick the model
> that fits your subscription's quota and region.

## Prerequisites

- [Azure Developer CLI (`azd`)](https://learn.microsoft.com/azure/developer/azure-developer-cli/install-azd)
- [Azure CLI (`az`)](https://learn.microsoft.com/cli/azure/install-azure-cli)
- **RBAC role on the target subscription: `Owner`** — or, at minimum, **`Contributor`** *and*
  **`User Access Administrator`**. `Contributor` alone can create the resources but **not** the role
  assignments the template needs, which surfaces as
  `Unauthorized: Unable to authorize with Azure Active Directory` *after* the resource group is created.
  See [Assign Azure roles with the CLI](https://learn.microsoft.com/azure/role-based-access-control/role-assignments-cli).

## Provision

Run from the **repo root** (where `azure.yaml` lives):

```bash
# Sign in to both CLIs
az login
azd auth login

# Target the right subscription
az account set --subscription <SUBSCRIPTION_ID>

# Register the resource providers (first time per subscription)
az provider register --namespace Microsoft.Fabric
az provider register --namespace Microsoft.CognitiveServices

# If you are a subscription Owner, grant yourself (or ask an admin to grant) the role:
az role assignment create \
  --assignee "<your-user-object-id-or-UPN>" \
  --role Owner \
  --scope /subscriptions/<SUBSCRIPTION_ID>

# Provision the infrastructure
azd provision
```

`azd` prompts for an environment name, subscription, and location the first time,
then deploys `infra/main.bicep`. Read the values the labs need with:

```bash
azd env get-values
```

## Tear down

Fabric capacity and model deployments bill while they exist. Remove everything when
you're done:

```bash
azd down --purge
```

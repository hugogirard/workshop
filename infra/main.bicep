import { modelParameters } from './types/customType.bicep'

targetScope = 'subscription'

@minLength(1)
@description('Primary Azure region for all resources. Restricted to USA, Sweden, and Canada regions where gpt-5.5 is available.')
@allowed([
  // USA
  'centralus'
  'eastus'
  'eastus2'
  'northcentralus'
  'southcentralus'
  'westus'
  'westus3'
  // Sweden
  'swedencentral'
  // Canada
  'canadacentral'
  'canadaeast'
])
param location string

@minLength(5)
@description('The name of the resource group that will contains all the resources')
param resourceGroupName string

@minLength(1)
@description('azd environment name. Used to derive the resource group and resource names.')
param environmentName string

@description('The email of the administrator for Fabric')
param administrationMember string = ''

@description('The user principal ID')
param userPrincipalId string = ''

#disable-next-line no-unused-vars
var resourceToken = toLower(uniqueString(subscription().id, environmentName, location))

var openAIModelProperties modelParameters = {
  deploymentName: 'gpt-5.5'
  modelProperties: {
    name: 'gpt-5.5'
    format: 'OpenAI'
    version: '2026-04-24'
  }
  sku: {
    name: 'GlobalStandard'
    capacity: 150
  }
  versionUpgradeOption: 'OnceNewDefaultVersionAvailable'
}

var tags = {
  'azd-env-name': environmentName
  SecurityControl: 'Ignore'
}

#disable-next-line no-unused-vars
var abbrs = loadJsonContent('./abbreviations.json')

resource rg 'Microsoft.Resources/resourceGroups@2024-03-01' = {
  name: resourceGroupName
  location: location
  tags: tags
}

module fabric 'core/data/fabric.bicep' = {
  scope: rg
  params: {
    location: location
    tags: tags
    administrationMember: administrationMember
    fabricResourceName: 'fabric${resourceToken}'
  }
}

module monitoring 'core/monitoring/monitoring.bicep' = {
  scope: rg
  params: {
    location: location
    appInsightResourceName: '${abbrs.insightsComponents}${resourceToken}'
    workspaceResourceName: '${abbrs.operationalInsightsWorkspaces}${resourceToken}'
  }
}

module foundry 'core/ai/foundry.bicep' = {
  scope: rg
  params: {
    location: location
    tags: tags
    accountName: '${abbrs.cognitiveServicesAccounts}${resourceToken}'
    logAnalyticResourceId: monitoring.outputs.logAnalyticResourceId
  }
}

module foundryConnections 'core/ai/foundry.connection.bicep' = {
  scope: rg
  params: {
    applicationInsightResourceName: monitoring.outputs.insightResourceName
    foundryResourceName: foundry.outputs.foundryResourceName
    projectResourceName: foundry.outputs.projectResourceName
  }
}

module modelDeployment 'core/ai/model-deployment.bicep' = {
  scope: rg
  params: {
    aiFoundryAccountName: foundry.outputs.foundryResourceName
    deploymentName: openAIModelProperties.deploymentName
    deploymentSku: openAIModelProperties.sku.name
    modelProperties: openAIModelProperties.modelProperties
    skuCapacity: openAIModelProperties.sku.capacity
    versionUpgradeOption: openAIModelProperties.versionUpgradeOption
  }
}

module ai_user_foundry 'core/rbac/rbac.bicep' = {
  scope: rg
  params: {
    principalId: userPrincipalId
    resourceId: foundry.outputs.foundryResourceId
    roleName: '53ca6127-db72-4b80-b1b0-d745d6d5456d' // Azure AI User
  }
}

module registry 'core/registry/container.bicep' = {
  scope: rg
  params: {
    location: location
    tags: tags
    acrName: '${abbrs.containerRegistryRegistries}${resourceToken}'
  }
}

@description('The name of the container registry')
output containerRegistryName string = registry.outputs.resourceName

@description('The resource group that contains all the resources')
output resourceGroupName string = rg.name

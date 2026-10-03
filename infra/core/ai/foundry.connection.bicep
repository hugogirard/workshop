@description('The name of the foundry resource')
param foundryResourceName string

@description('The name of the project')
param projectResourceName string

@description('The name of the application insights resource')
param applicationInsightResourceName string

resource foundry 'Microsoft.CognitiveServices/accounts@2026-01-15-preview' existing = {
  name: foundryResourceName
}

resource project 'Microsoft.CognitiveServices/accounts/projects@2026-03-15-preview' existing = {
  parent: foundry
  name: projectResourceName
}

resource appInsights 'Microsoft.Insights/components@2020-02-02' existing = {
  name: applicationInsightResourceName
}

resource connectionAppInsight 'Microsoft.CognitiveServices/accounts/projects/connections@2026-03-01' = {
  name: '${foundryResourceName}-appinsights'
  parent: project
  properties: {
    category: 'AppInsights'
    target: appInsights.id
    authType: 'ApiKey'
    isSharedToAll: true
    credentials: {
      key: appInsights.properties.ConnectionString
    }
    metadata: {
      ApiType: 'Azure'
      ResourceId: appInsights.id
    }
  }
}

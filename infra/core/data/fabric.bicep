param fabricResourceName string
param location string
param administrationMember string
param tags object

resource fabric 'Microsoft.Fabric/capacities@2023-11-01' = {
  name: fabricResourceName
  location: location
  tags: tags
  sku: {
    name: 'F16'
    tier: 'Fabric'
  }
  properties: {
    administration: {
      members: [
        administrationMember
      ]
    }
  }
}

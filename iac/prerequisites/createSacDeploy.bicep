// //targetScope = 'subscription'

// @description('The Azure env into which the resources should be deployed.')
// param environmentType string = 'development'

// @description('The location into which the resources should be deployed.')
// param location string = 'westeurope'

// // @description('The Azure rg into which the resources should be deployed.')
// // @maxLength(13)
// // param rgName string = 'test-aks9'

// // resource rResourceGroup 'Microsoft.Resources/resourceGroups@2020-06-01' = {
// //   name: rgName
// //   location: location
// // }

// module AksPreModuleSac 'modules/createSac.bicep' = {
//   name: deployment().name
//   //scope: rResourceGroup
//   params: {
//     environmentType: environmentType
//     location: location
//   }
// }

// module AksPreModuleBlob 'modules/createSac.bicep' = {
//   name: deployment().name
//   //scope: rResourceGroup
//   params: {
//     environmentType: environmentType
//     location: location
//   }
// }


// Creates a KeyVault with Private Link Endpoint
@description('The Azure Region to deploy the resrouce group into')
param location string = resourceGroup().location

@description('Tags to apply to the Key Vault Instance')
param tags object = {}

@description('The name of the Key Vault')
param keyvaultName string = 'kv123224r'

resource keyVault 'Microsoft.KeyVault/vaults@2021-04-01-preview' = {
  name: keyvaultName
  location: location
  tags: tags
  properties: {
    createMode: 'default'
    enabledForDeployment: false
    enabledForDiskEncryption: false
    enabledForTemplateDeployment: false
    enableSoftDelete: true
    enableRbacAuthorization: true
    enablePurgeProtection: true
    networkAcls: {
      bypass: 'AzureServices'
      defaultAction: 'Deny'
    }
    sku: {
      family: 'A'
      name: 'standard'
    }
    softDeleteRetentionInDays: 7
    tenantId: subscription().tenantId
  }
}

output keyvaultId string = keyVault.id

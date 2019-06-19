##############################################################
#This file call the module for the Hub config
##############################################################

variable "RGHub" {
    type = "string"
}

variable "RGBastion" {
    type = "string"
}

variable "RGFW" {
    type = "string"
}

variable "AzureRegion" {
  type    = "string"
  default = "westeurope"
}

# Variable to define the Tag

variable "EnvironmentTag" {
  type    = "string"
  default = "Hub"
}

variable "EnvironmentUsageTag" {
  type    = "string"
  default = "PoC"
}

variable "OwnerTag" {
  type = "string"
}

variable "ProvisioningDateTag" {
  type = "string"
}

variable "VNetHubName" {
  type    = "string"

}

variable "VNetHubAddressSpace" {
  type    = "list"

}

variable "SubnetInfraName" {
  default = [
    "GatewaySubnet",
    "AzureFirewallSubnet"

  ]

}

variable "HubSubnetName" {
  default = [
    "Bastion_Subnet",
    "SharedServices_Subnet"
  ]
    
}

variable "SubnetInfraaddressprefix" {
    type = "list"
}

variable "SubnetHubaddressprefix" {
    type = "list"
}


variable "FWPublicIPName" {
    type = "string"
    default = "FWIP"
}

variable "FWName" {
    type = "string"
    default = "HubFirewall"
}

variable "SVCEP" {
  type    = "list"
  default = ["Microsoft.AzureCosmosDB", "Microsoft.KeyVault", "Microsoft.Sql", "Microsoft.Storage", "Microsoft.ServiceBus", "Microsoft.EventHub"]
}
######################################################################
# Azure Hub module
######################################################################

This module allows the deployment of a Hub VNet.
It includes:
- A RG for the Hub VNet
- The Hub Vnet, containing 
    - a GatewaySubnet, 
    - a firewall Subnet, without NSG associated
    - a Bastion Subnet
    - a Shared Services Subnet
    - a log analytics workspace
    - a storage account for storing the logs
    - an azure firewall deployed in the firewall subnet
    - a route table and the associated route for the Shared Services Subnet
    - NSGs for the Shared Services and Bastion Subnets
    - a Keyvault and its access policies
- A RG for the bastion VM(s)
    - Bastion VMs
    - Public IPs for the Bastion VMs

For ease of reading, the traditional structure main.tf, variables.tf, outputs.tf is not followed, since there are quite a lot of resources to be created

It requires a terraformtvars:


RGHubName         = "RG_Hub"
RGBastionName     = "RG_Bastion"                
RGFWName          = "RG_FW"

AzureRegion           = "westeurope"
VNetHubName           = "VNetHub"
VNetHubAddressSpace   = ["x.x.x.x/y"]


SubnetInfraaddressprefix = [
    "x.x.x.x/y",
    "x.x.x.x/y"
  ]

SubnetHubaddressprefix = [
    "x.x.x.x/y",
    "x.x.x.x/y"
  ]


EnvironmentTag      = "LandingZone"
EnvironmentUsageTag = "PoC"
OwnerTag            = "OwnerName"
ProvisioningDateTag = "ProvisioningDate"


It also require a provider block:

```hcl

######################################################################
# Access to Azure
######################################################################

# Configure the Microsoft Azure Provider with Azure provider variable defined in a file not pushed in the git repo

provider "azurerm" {
  subscription_id = "${var.AzureSubscription}"
  client_id       = "${var.AzureClientID}"
  client_secret   = "${var.AzureClientSecret}"
  tenant_id       = "${var.AzureTenantID}"
}

```

define a bakend as follow: 

```hcl

terraform {
  backend "azurerm" {
    storage_account_name = "storage_account_name"
    container_name       = "terraform"
    key                  = "configbackend.tf"
    access_key           = "storage_account_access_key"
  }
}

```


Use the module as follow:


```hcl
module "HubSpoke" {
  #Module Location
  source = "./Modules/hub/"

  #Module variable
  RGHub                         = "${var.RGHubName}"
  RGBastion                     = "${var.RGBastionName}"
  RGFW                          = "${var.RGFWName}"
  AzureRegion                   = "${var.AzureRegion}"
  EnvironmentTag                = "${var.EnvironmentTag}"
  EnvironmentUsageTag           = "${var.EnvironmentUsageTag}"
  OwnerTag                      = "${var.OwnerTag}"
  ProvisioningDateTag           = "${var.ProvisioningDateTag}"
  VNetHubName                   = "${var.VNetHubName}"
  VNetHubAddressSpace           = "${var.VNetHubAddressSpace}"
  SubnetInfraaddressprefix      = "${var.SubnetInfraaddressprefix}"
  SubnetHubaddressprefix        = "${var.SubnetHubaddressprefix}"
  #FWPublicIPName                = ""
  #FWName                        = ""




}
```





##############################################################
#This module allows the creation a hub & spoke architecture
##############################################################




#Creating a Resource Group for the Hub VNet
resource "azurerm_resource_group" "RGHub" {

    
    name        = "${var.RGHub}"
    location    = "${var.AzureRegion}"

    tags = {
    Environment         = "${var.EnvironmentTag}"
    Usage               = "${var.EnvironmentUsageTag}"
    Owner               = "${var.OwnerTag}"
    ProvisioningDate    = "${var.ProvisioningDateTag}"
    }

}


#Creating a Resource Group for the Bastions Servers
resource "azurerm_resource_group" "RGBastion" {

    
    name        = "${var.RGBastion}"
    location    = "${azurerm_resource_group.RGHub.location}"

    tags = {
    Environment         = "${var.EnvironmentTag}"
    Usage               = "${var.EnvironmentUsageTag}"
    Owner               = "${var.OwnerTag}"
    ProvisioningDate    = "${var.ProvisioningDateTag}"
    }

}
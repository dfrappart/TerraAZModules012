##############################################################
#This module allows the creation a hub & spoke architecture
##############################################################

###################################################################
#This file describes the Hub VNet Creation
###################################################################

#Creating the Hub VNet

resource "azurerm_virtual_network" "VNetHub" {
  name                = "${var.VNetHubName}"
  resource_group_name = "${azurerm_resource_group.RGHub.name}"
  address_space       = "${var.VNetHubAddressSpace}"
  location            = "${azurerm_resource_group.RGHub.location}"

  tags = {
    Environment       = "${var.EnvironmentTag}"
    Usage             = "${var.EnvironmentUsageTag}"
    Owner             = "${var.OwnerTag}"
    ProvisioningDate  = "${var.ProvisioningDateTag}"
  }
}
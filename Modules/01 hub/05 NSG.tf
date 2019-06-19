##############################################################
#This module allows the creation a hub & spoke architecture
##############################################################

###################################################################
#This file describes the bastion & shared services NSG creation
###################################################################

#Creation fo the NSGs
resource "azurerm_network_security_group" "HubNSG" {
    count               = 2
    name                = "NSG_${element(var.HubSubnetName,count.index)}"
    location            = "${azurerm_resource_group.RGHub.location}"
    resource_group_name = "${azurerm_resource_group.RGHub.name}"

    tags = {
        Environment       = "${var.EnvironmentTag}"
        Usage             = "${var.EnvironmentUsageTag}"
        Owner             = "${var.OwnerTag}"
        ProvisioningDate  = "${var.ProvisioningDateTag}"
  }
}
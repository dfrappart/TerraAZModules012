##############################################################
#This module allows the creation a hub & spoke architecture
##############################################################

###################################################################
#This file describes the gatewaysubnet and firewall subnet creation
###################################################################
#Creation of the subnet Gateway and Firewall

resource "azurerm_subnet" "InfraSubnet" {

    count                       = 2
    name                        = "${element(var.SubnetInfraName,count.index)}"
    resource_group_name         = "${azurerm_resource_group.RGHub.name}"
    virtual_network_name        = "${azurerm_virtual_network.VNetHub.name}"
    address_prefix              = "${element(var.SubnetInfraaddressprefix,count.index)}"



}

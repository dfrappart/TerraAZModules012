##############################################################
#This module allows the creation a hub & spoke architecture
##############################################################

###################################################################
#This file describes a bastion & shared services subnets creation
###################################################################

#Creation of the subnets in the hub VNet

resource "azurerm_subnet" "Bastion_Subnet" {

    name                      = "${element(var.HubSubnetName,0)}"
    resource_group_name       = "${azurerm_resource_group.RGHub.name}"
    virtual_network_name      = "${azurerm_virtual_network.VNetHub.name}"
    address_prefix            = "${element(var.SubnetHubaddressprefix,0)}"
    network_security_group_id = "${element(azurerm_network_security_group.*.id,0)}"
    service_endpoints         = "${var.SVCEP}"
}

resource "azurerm_subnet" "ShareSVC" {
  name                      = "${element(var.HubSubnetName,1)}"
  resource_group_name       = "${azurerm_resource_group.RGHub.name}"
  virtual_network_name      = "${azurerm_virtual_network.VNetHub.name}"
  address_prefix            = "${element(var.SubnetHubaddressprefix,1)}"
  network_security_group_id = "${element(azurerm_network_security_group.*.id,1)}"
  service_endpoints         = "${var.SVCEP}"
  route_table_id            = "${var.RouteTableId}"
}
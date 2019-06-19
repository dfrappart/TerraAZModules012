##############################################################
#This module allows the creation a hub & spoke architecture
##############################################################

###################################################################
#This file describes the bastion & shared services NSG association
###################################################################



#Creation of the NSG association
#not supported by provider at this time
/*
resource "azurerm_network_security_group_association" "NSGAssociation" {
    count                               = 2
    subnet_id                           = "${element(azurerm_subnet.HubSubnet.id,count.index)}"
    azurerm_network_security_group_id   = "${element(azurerm_network_security_group.HubNSG.id,count.index)}"

}

*/
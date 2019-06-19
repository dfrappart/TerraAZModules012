##############################################################
#This module allows the creation of a Netsork Security Group
##############################################################



#Creation fo the NSG
resource "azurerm_network_security_group" "Terra-NSG" {
  name                = "${var.NSGName}"
  location            = "${var.NSGLocation}"
  resource_group_name = "${var.RGName}"

  tags = {
    Environment       = "${var.EnvironmentTag}"
    Usage             = "${var.EnvironmentUsageTag}"
    Owner             = "${var.OwnerTag}"
    ProvisioningDate  = "${var.ProvisioningDateTag}"
  }
}


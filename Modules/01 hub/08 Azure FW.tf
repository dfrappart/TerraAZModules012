##############################################################
#This module allows the creation a hub & spoke architecture
##############################################################

###################################################################
#This file describes the azure firewall and its public ip
###################################################################

# FW creation

resource "azurerm_public_ip" "FWPublicIP" {
  name                         = "${var.FWPublicIPName}"
  location                     = "${azurerm_resource_group.RGHub.location}"
  resource_group_name          = "${azurerm_resource_group.RGHub.name}"
  allocation_method            = "Static"
  sku                          = "standard"
  domain_name_label            = "azfw${lower(var.OwnerTag)}${lower(var.EnvironmentUsageTag)}"


  tags = {
    Environment       = "${var.EnvironmentTag}"
    Usage             = "${var.EnvironmentUsageTag}"
    Owner             = "${var.OwnerTag}"
    ProvisioningDate  = "${var.ProvisioningDateTag}"
  }
}

resource "azurerm_firewall" "HubFirewall" {
  name                          = "${var.FWName}"
  location                      = "${azurerm_resource_group.RGHub.location}"
  resource_group_name           = "${azurerm_resource_group.RGHub.name}"

  ip_configuration {
    name                          = "${var.FWName}IpConfig"
    subnet_id                     = "${element(azurerm_subnet.InfraSubnet.*.id,1)}"
    internal_public_ip_address_id = "${azurerm_public_ip.FWPublicIP.id}"
  }

    tags = {
    Environment         = "${var.EnvironmentTag}"
    Usage               = "${var.EnvironmentUsageTag}"
    Owner               = "${var.OwnerTag}"
    ProvisioningDate    = "${var.ProvisioningDateTag}"
    }
}


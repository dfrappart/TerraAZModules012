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
/*
#Creating a Resource Group for the Bastions Servers
resource "azurerm_resource_group" "RGFW" {

    
    name        = "${var.RGFW}"
    location    = "${azurerm_resource_group.RGHub.location}"

    tags = {
    Environment         = "${var.EnvironmentTag}"
    Usage               = "${var.EnvironmentUsageTag}"
    Owner               = "${var.OwnerTag}"
    ProvisioningDate    = "${var.ProvisioningDateTag}"
    }

}

*/

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

#Creation of the subnet Gateway and Firewall

resource "azurerm_subnet" "InfraSubnet" {

    count                       = 2
    name                        = "${element(var.SubnetInfraName,count.index)}"
    resource_group_name         = "${azurerm_resource_group.RGHub.name}"
    virtual_network_name        = "${azurerm_virtual_network.VNetHub.name}"
    address_prefix              = "${element(var.SubnetInfraaddressprefix,count.index)}"



}


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

#Creation of the subnets in the hub VNet

resource "azurerm_subnet" "HubSubnet" {

    count                     = 2
    name                      = "${element(var.HubSubnetName,count.index)}"
    resource_group_name       = "${azurerm_resource_group.RGHub.name}"
    virtual_network_name      = "${azurerm_virtual_network.VNetHub.name}"
    address_prefix            = "${element(var.SubnetHubaddressprefix,count.index)}"
    #network_security_group_id = "${element(azurerm_network_security_group.*.id,count.index)}"
    service_endpoints         = "${var.SVCEP}"
}

#Creation of the NSG association
#not supported by provider at this time
/*
resource "azurerm_network_security_group_association" "NSGAssociation" {
    count                               = 2
    subnet_id                           = "${element(azurerm_subnet.HubSubnet.id,count.index)}"
    azurerm_network_security_group_id   = "${element(azurerm_network_security_group.HubNSG.id,count.index)}"

}

*/

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
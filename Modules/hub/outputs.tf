##############################################################
#Output of the hub VNet
##############################################################

#Resource Group outputs
output "RGHubName" {
    value = "${azurerm_resource_group.RGHub.name}"
    description = "The name of the RG Hub"
}

output "RGHubId" {
    value = "${azurerm_resource_group.RGHub.id}"
    description = "The id of the RG Hub"
}

output "RGHubLocation" {
    value = "${azurerm_resource_group.RGHub.location}"
    description = "The location of the RG Hub"
}

output "RGBastionName" {
    value = "${azurerm_resource_group.RGBastion.name}"
    description = "The locaNametion of the RG Bastion"
}

output "RGBastionId" {
    value = "${azurerm_resource_group.RGBastion.id}"
    description = "The Id of the RG Bastion"
}

output "RGBastionLocation" {
    value = "${azurerm_resource_group.RGBastion.location}"
    description = "The location of the RG Bastion"
}

#VNet output

output "VNetHubName" {
    value = "${azurerm_virtual_network.VNetHub.name}"
    description = "The name of the VNet Hub"
}

output "VNetHubId" {
    value = "${azurerm_virtual_network.VNetHub.id}"
    description = "The id of the VNet Hub"
}

output "VNetHubAddressSpace" {
    value = "${azurerm_virtual_network.VNetHub.address_space}"
    description = "The address space of the VNet Hub"
}

output "VNetHubSubnet" {
    value = "${azurerm_virtual_network.VNetHub.subnet}"
    description = "The subnets of the VNet Hub"
}

#Subnet outputs

output "BastionSubnetName" {
    value = "${element(azurerm_subnet.HubSubnet.*.name,0)}"
    description = "The name of the bastion subnet"
}

output "BastionSubnetId" {
    value = "${element(azurerm_subnet.HubSubnet.*.id,0)}"
    description = "The id of the bastion subnet"
}

output "BastionSubnetaddressSpace" {
    value = "${element(azurerm_subnet.HubSubnet.*.address_prefix,0)}"
    description = "The address space of the bastion subnet"
}

output "SharedServicesSubnetName" {
    value = "${element(azurerm_subnet.HubSubnet.*.name,1)}"
    description = "The name of the SharedService subnet"
}

output "SharedServiceSubnetId" {
    value = "${element(azurerm_subnet.HubSubnet.*.id,1)}"
    description = "The id of the SharedService subnet"
}

output "SharedServiceSubnetaddressSpace" {
    value = "${element(azurerm_subnet.HubSubnet.*.address_prefix,1)}"
    description = "The address space of the SharedService subnet"
}

output "GWSubnetName" {
    value = "${element(azurerm_subnet.InfraSubnet.*.name,0)}"
    description = "The name of the GW subnet"
}

output "GWSubnetId" {
    value = "${element(azurerm_subnet.InfraSubnet.*.id,0)}"
    description = "The id of the GW subnet"
}

output "GWSubnetaddressSpace" {
    value = "${element(azurerm_subnet.InfraSubnet.*.address_prefix,0)}"
    description = "The address space of the GW subnet"
}

output "FWSubnetName" {
    value = "${element(azurerm_subnet.InfraSubnet.*.name,1)}"
    description = "The name of the FW subnet"
}

output "FWSubnetId" {
    value = "${element(azurerm_subnet.InfraSubnet.*.id,1)}"
    description = "The id of the FW subnet"
}

output "FWSubnetaddressSpace" {
    value = "${element(azurerm_subnet.InfraSubnet.*.address_prefix,1)}"
    description = "The address space of the FW subnet"
}


#Output for Public IP of the FW

output "AZFWPipName" {
    value = "${azurerm_public_ip.FWPublicIP.name}"
    description = "The name of the Public IP object associated to the Azure Firewall"

}

output "AZFWPipId" {
    value = "${azurerm_public_ip.FWPublicIP.id}"
    description = "The Resource Id of the Public IP"
    
}

output "AZFWPipFqdn" {
    value = "${azurerm_public_ip.FWPublicIP.fqdn}"
    description = "The fqdn of the Public IP"
 
    
}

output "AZFWPipAddress" {
    value = "${azurerm_public_ip.FWPublicIP.ip_address}"
    
}

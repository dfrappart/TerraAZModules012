##############################################################
#This module allows the creation of a Subnet Gateway
##############################################################

#Variable declaration for Module

variable "SubnetName" {
  type    = "string"
  default = "GatewaySubnet"
}


variable "RGName" {
  type    = "string"
  default = "DefaultRSG"
}

variable "vNetName" {
  type    = "string"

}

variable "Subnetaddressprefix" {
  type    = "string"

}




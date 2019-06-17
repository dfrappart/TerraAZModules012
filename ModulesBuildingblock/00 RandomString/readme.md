######################################################################
# Random string module
######################################################################

This Module allows the creation of a random string


Use is as follow:



# Creating the random string
```hcl
module "RandomString" {
  #Module Location
  source = "github.com/dfrappart/Terra-AZModuletest//Modules//01 ResourceGroup/"

  #Module variable
  stringlenght      = "${var.StringLenght}"
  stringspecial     = "${var.IsStringSpecialAllowed}"
  stringupper       = "${var.IsStringUpperAllowed}"
  stringnumber      = "${var.IsNumberAllowed}"

}
```


variable "amis" {
  type = map
    
    default = {
        "us-east-1" = "ami-0729e439b6769d6ab"
        "us-east-2" = "ami-0568773882d492fc8"
    }
  
}

variable "cdirs_acesso_remoto" {
    type = list
    default = ["143.255.232.226/32","144.255.232.226/32"]
}

variable "key_name" {
    default = "terraform-aws" 
}
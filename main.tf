terraform {
  required_providers {
    bigip = {
      source = "F5Networks/bigip"
      version = "1.17.0"
    }
  }
}

provider "bigip" {
  address  = var.hostname
  username = var.user_name
  password = var.user_password
}

resource "bigip_fast_https_app" "fast_https_app" {
  tenant      = "fasthttpstenant"
  application = "fasthttpsapp"
  virtual_server {
    ip   = "10.30.40.45"
    port = 443
  }
}
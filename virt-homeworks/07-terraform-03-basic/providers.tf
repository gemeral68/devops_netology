terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
  
  backend "s3" {
    endpoint   = "storage.yandexcloud.net"
    bucket     = "netology-1"
    region     = "ru-central1"
    key        = "terraform.tfstate"
    access_key = "*********************"
    secret_key = "*********************"
    
    skip_region_validation      = true
    skip_credentials_validation = true
  }
}

terraform {
  backend "s3" {
    endpoint   = "storage.yandexcloud.net"
    bucket     = "ocelot-bucket"
    region     = "us-east-1"
    key        = "terraform.tfstate"
    access_key = "terraform.access_key"
    secret_key = "terraform.secret_key"
    skip_region_validation      = true
    skip_credentials_validation = true
  }
}

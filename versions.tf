terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.61.0"
    }
  }
}

provider "yandex" {
  token     = "${var.token}"
  cloud_id  = "b1ghmgr7u88nv3sior28"
  folder_id = "b1gknvocj54h5e6sh9ho"
  zone      = "ru-central1-b"
}

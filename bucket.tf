 resource "yandex_storage_bucket" "ocelot-bucket" {
    access_key = "${var.access_key}"
    secret_key = "${var.secret_key}"
    bucket = "ocelot-bucket"
    force_destroy = "true"
}


resource "yandex_kubernetes_cluster" "k8s-cluster" {
  name        = "k8s-cluster"
  description = "k8s-cluster"

  network_id = "${yandex_vpc_network.k8s-network.id}"

  master {
    version = "1.21"
    zonal {
      zone      = "${yandex_vpc_subnet.k8s-subnet-1.zone}"
      subnet_id = "${yandex_vpc_subnet.k8s-subnet-1.id}"
    }

    public_ip = true


    maintenance_policy {
      auto_upgrade = true

      maintenance_window {
        start_time = "15:00"
        duration   = "3h"
      }
    }
  }
service_account_id      = yandex_iam_service_account.ocelot.id
 node_service_account_id = yandex_iam_service_account.ocelot.id
   depends_on = [
     yandex_resourcemanager_folder_iam_binding.editor,
     yandex_resourcemanager_folder_iam_binding.images-puller
   ]
}

resource "yandex_iam_service_account" "ocelot" {
 name        = "ocelot"
 description = "ocelot"
}

resource "yandex_resourcemanager_folder_iam_binding" "editor" {
 folder_id = var.yc_folder_id
 role      = "editor"
 members   = [
   "serviceAccount:${yandex_iam_service_account.ocelot.id}"
 ]
}

resource "yandex_resourcemanager_folder_iam_binding" "images-puller" {
 folder_id = var.yc_folder_id
 role      = "container-registry.images.puller"
 members   = [
   "serviceAccount:${yandex_iam_service_account.ocelot.id}"
 ]
}


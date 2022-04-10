resource "yandex_kubernetes_node_group" "master" {
  cluster_id  = "${yandex_kubernetes_cluster.k8s-cluster.id}"
  name        = "master"
  description = "master"
  version     = "1.21"

  instance_template {
    platform_id = "standard-v2"

    network_interface {
      nat                = true
      subnet_ids         = ["${yandex_vpc_subnet.k8s-subnet-1.id}"]
    }

    resources {
      memory = 8
      cores  = 2
    }

    boot_disk {
      type = "network-hdd"
      size = 64
    }

    metadata = {
      ssh-keys = "alexander:${file("~/.ssh/yac.pub")}"
    }

    scheduling_policy {
      preemptible = false
    }

  }

  scale_policy {
    auto_scale {
      min = 1
      max = 2
      initial = 1
    }
  }

  allocation_policy {
    location {
      zone = "ru-central1-a"
    }
  }

  maintenance_policy {
    auto_upgrade = true
    auto_repair  = true

    maintenance_window {
      day        = "monday"
      start_time = "15:00"
      duration   = "3h"
    }

    maintenance_window {
      day        = "friday"
      start_time = "10:00"
      duration   = "4h30m"
    }
  }
}

resource "yandex_kubernetes_node_group" "nodes" {
  cluster_id  = "${yandex_kubernetes_cluster.k8s-cluster.id}"
  name        = "nodes"
  description = "nodes"
  version     = "1.21"

  instance_template {
    platform_id = "standard-v2"

    network_interface {
      nat                = true
      subnet_ids         = ["${yandex_vpc_subnet.k8s-subnet-2.id}"]
    }

    resources {
      memory = 8
      cores  = 2
    }

    boot_disk {
      type = "network-hdd"
      size = 64
    }

    metadata = {
      ssh-keys = "alexander:${file("~/.ssh/yac.pub")}"
    }

    scheduling_policy {
      preemptible = false
    }

  }

  scale_policy {
    auto_scale {
      min = 3
      max = 6
      initial = 3
    }
  }

  allocation_policy {
    location {
      zone = "ru-central1-b"
    }
  }

  maintenance_policy {
    auto_upgrade = true
    auto_repair  = true

    maintenance_window {
      day        = "monday"
      start_time = "15:00"
      duration   = "3h"
    }

    maintenance_window {
      day        = "friday"
      start_time = "10:00"
      duration   = "4h30m"
    }
  }
}

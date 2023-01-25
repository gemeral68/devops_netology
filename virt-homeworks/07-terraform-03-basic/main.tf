locals {
  cores = {
    stage = 2
    prod = 2
  }
  memory = {
    stage = 1
    prod = 1
  }
  count = {
    stage = 1
    prod  = 2
  }
  for_each = {
    stage = toset(["svm1"])
    prod  = toset(["pvm1", "pvm2"])
  }
}

provider "yandex" {
  token = var.yc_token
  cloud_id = var.yc_cloud_id
  folder_id = var.yc_folder_id
  zone = var.yc_zone_id
}

resource "yandex_compute_instance" "test-for-each" {
  for_each = local.for_each[terraform.workspace] 
  name = "${terraform.workspace}-test-for-each-${each.key}"
  platform_id = "standard-v3"

  resources {
    cores  = local.cores[terraform.workspace]
    memory = local.memory[terraform.workspace]
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = "fd8e39r8cq8hpfe9442r"
    }
  }
  
  network_interface {
    subnet_id = yandex_vpc_subnet.network-1-ru-central1-a.id
    nat       = true
  }

  scheduling_policy {
    preemptible = true
  }
  
  lifecycle {
    create_before_destroy = true
  }
  
  metadata = {
    user-data = file("${path.module}/cloud-config.yaml")
  }
}

resource "yandex_compute_instance" "test_count" {
  count = local.count[terraform.workspace]
  name = "${terraform.workspace}-test-count-${count.index}"
  platform_id = "standard-v3"

  resources {
    cores  = local.cores[terraform.workspace]
    memory = local.memory[terraform.workspace]
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = "fd8e39r8cq8hpfe9442r"
    }
  }
  
  network_interface {
    subnet_id = yandex_vpc_subnet.network-1-ru-central1-a.id
    nat       = true
  }

  scheduling_policy {
    preemptible = true
  }
  
  metadata = {
    user-data = file("${path.module}/cloud-config.yaml")
  }
}

resource "yandex_vpc_network" "network-1" {
  name = "network-1"
}

resource "yandex_vpc_subnet" "network-1-ru-central1-a" {
  name = "network-1-ru-central1-a"
  v4_cidr_blocks = ["10.128.0.0/24"]
  zone           = "ru-central1-a"
  network_id     = "${yandex_vpc_network.network-1.id}"
}


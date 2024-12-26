
locals {
    server_ssh_key = file("~/.ssh/id_ed25519.pub")
}

data "yandex_compute_image" "image" {
  family = var.image_family
}
resource "yandex_compute_instance" "k8s_node" {
  count =   length(var.node_count)
  name        = var.node_count[count.index]
  allow_stopping_for_update = true
  resources {
    cores         = var.node_count[count.index] == "vm-control-node" ? var.vm-control-node.cores : var.vm-worker-node.cores
    memory        = var.node_count[count.index] == "vm-control-node" ? var.vm-control-node.memory : var.vm-worker-node.memory
    core_fraction = var.node_count[count.index] == "vm-control-node" ? var.vm-control-node.core_fraction : var.vm-worker-node.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.image.image_id
      type        = "network-hdd"
      size        = "10"
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.netology[0].id
    nat       = true
  }

  metadata = {
    user-data = "${file("${path.module}/templates/cloud-init.cfg")}"
  }
}

resource "time_sleep" "wait_30_seconds" {
  depends_on      = [yandex_compute_instance.k8s_node]
  create_duration = "30s"
}

resource "null_resource" "hosts_provision" {
  depends_on = [yandex_compute_instance.k8s_node]

  provisioner "local-exec" {
      command  = <<EOT
      cd ${path.module}/templates/kubespray 
      export ANSIBLE_HOST_KEY_CHECKING=False
      export ANSIBLE_CONFIG="ansible.cfg"
      ansible-playbook -i ${path.module}/templates/inventory.ini -b --diff cluster.yml
      EOT
      on_failure = continue
      environment = { ANSIBLE_HOST_KEY_CHECKING = "False" }
    }
}



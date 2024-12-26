output "vpc" {
  value = yandex_vpc_network.netology
}

output "subnet" {
  value = yandex_vpc_subnet.netology
}

output "k8s_node" {
  value = yandex_compute_instance.k8s_node
}

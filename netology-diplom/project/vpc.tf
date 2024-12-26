resource "yandex_vpc_network" "netology" {
  name = var.vpc_name
}


resource "yandex_vpc_subnet" "netology" {
  count          = length(var.subnet_name)
  name           = var.subnet_name[count.index]
  zone           = var.zone[count.index]
  network_id     = yandex_vpc_network.netology.id
  v4_cidr_blocks = [var.subnet_cidrs[count.index]]
}


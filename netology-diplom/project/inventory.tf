resource "local_file" "ansible_inventory" {
#   depends_on = [yandex_compute_instance.k8s_node]
    content = templatefile("${path.module}/templates/inventory.tftpl",
        { 
            k8s_node =  yandex_compute_instance.k8s_node
            subnet = yandex_vpc_subnet.netology
            vpc = yandex_vpc_network.netology
        }  
    )

  filename = "${path.module}/templates/inventory.ini"
}
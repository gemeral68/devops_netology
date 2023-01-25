# "7.3 Основы и принцип работы Терраформ"

## Задание 1
#### Создадим бэкэнд в S3 (необязательно, но крайне желательно).
![](https://github.com/gemeral68/devops_netology/blob/main/virt-homeworks/07-terraform-03-basic/screenshots/1.png)

## Задание 2
#### Инициализируем проект и создаем воркспейсы.
- Вывод команды terraform workspace list.
```sh
[root@bulat-pc terraform-config]# terraform workspace list
  default
* prod
  stage
```
- Вывод команды terraform plan для воркспейса prod.
```terraform
[root@bulat-pc terraform-config]# terraform plan

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # yandex_compute_instance.test-for-each["pvm1"] will be created
  + resource "yandex_compute_instance" "test-for-each" {
      + created_at                = (known after apply)
      + folder_id                 = (known after apply)
      + fqdn                      = (known after apply)
      + hostname                  = (known after apply)
      + id                        = (known after apply)
      + metadata                  = {
          + "user-data" = <<-EOT
                #cloud-config
                ssh_pwauth: no
                users:
                  - name: netology
                    sudo: ALL=(ALL) NOPASSWD:ALL
                    shell: /bin/bash
                    ssh_authorized_keys:
                      - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDSr1nqbjqW7rKYORqgIyPUhWtC65ZpPJO/yx9UmtkhLv0/FlU3Y3JNf0S3ULe8Ys3ek8G8in1BtGaewAapP7GSozviFTWnhhIMrGzNGrX4i/EmtC2B5ipM1plSM3o54MOV900XcPSrGeNkjDwVmWpHWgLvEI/FDX33ZE+4IIlLnKdD4Rc+JRWvBlFHs7oBuv7sXCoZ1Al3Gkzc9cM/kyw1qb9+S74oG+1hzd2kMYKGgyesFNHjo60LN/2rcqnKqz9oStFSmNTItgXWbMN5NpDysa6nRxZgbG2/GYUf1RVuriBCnFgKAMLBNySQSyq0TKmhlrCHnCV9ESCCRO3qqsixcv8XlA5GRXz3m3AGsjJ5qimvo+6JE+hOfFMt6PgE+CKYiUnfav0rLkmKkTSsCdgISI4iDzq4bnwKYF2YirVR8PCHmLCtUoRxhrUSGylLrv52qbdfT+xennTlm+e1fA/fpZLRrMEvx/Ue9N1DWpJA3kFK+wd6K9nfVOpvJOM/Wss= bulat@bulat-pc
                
                
            EOT
        }
      + name                      = "prod-test-for-each-pvm1"
      + network_acceleration_type = "standard"
      + platform_id               = "standard-v3"
      + service_account_id        = (known after apply)
      + status                    = (known after apply)
      + zone                      = (known after apply)

      + boot_disk {
          + auto_delete = true
          + device_name = (known after apply)
          + disk_id     = (known after apply)
          + mode        = (known after apply)

          + initialize_params {
              + block_size  = (known after apply)
              + description = (known after apply)
              + image_id    = "fd8e39r8cq8hpfe9442r"
              + name        = (known after apply)
              + size        = (known after apply)
              + snapshot_id = (known after apply)
              + type        = "network-hdd"
            }
        }

      + metadata_options {
          + aws_v1_http_endpoint = (known after apply)
          + aws_v1_http_token    = (known after apply)
          + gce_http_endpoint    = (known after apply)
          + gce_http_token       = (known after apply)
        }

      + network_interface {
          + index              = (known after apply)
          + ip_address         = (known after apply)
          + ipv4               = true
          + ipv6               = (known after apply)
          + ipv6_address       = (known after apply)
          + mac_address        = (known after apply)
          + nat                = true
          + nat_ip_address     = (known after apply)
          + nat_ip_version     = (known after apply)
          + security_group_ids = (known after apply)
          + subnet_id          = (known after apply)
        }

      + placement_policy {
          + host_affinity_rules = (known after apply)
          + placement_group_id  = (known after apply)
        }

      + resources {
          + core_fraction = 20
          + cores         = 2
          + memory        = 1
        }

      + scheduling_policy {
          + preemptible = true
        }
    }

  # yandex_compute_instance.test-for-each["pvm2"] will be created
  + resource "yandex_compute_instance" "test-for-each" {
      + created_at                = (known after apply)
      + folder_id                 = (known after apply)
      + fqdn                      = (known after apply)
      + hostname                  = (known after apply)
      + id                        = (known after apply)
      + metadata                  = {
          + "user-data" = <<-EOT
                #cloud-config
                ssh_pwauth: no
                users:
                  - name: netology
                    sudo: ALL=(ALL) NOPASSWD:ALL
                    shell: /bin/bash
                    ssh_authorized_keys:
                      - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDSr1nqbjqW7rKYORqgIyPUhWtC65ZpPJO/yx9UmtkhLv0/FlU3Y3JNf0S3ULe8Ys3ek8G8in1BtGaewAapP7GSozviFTWnhhIMrGzNGrX4i/EmtC2B5ipM1plSM3o54MOV900XcPSrGeNkjDwVmWpHWgLvEI/FDX33ZE+4IIlLnKdD4Rc+JRWvBlFHs7oBuv7sXCoZ1Al3Gkzc9cM/kyw1qb9+S74oG+1hzd2kMYKGgyesFNHjo60LN/2rcqnKqz9oStFSmNTItgXWbMN5NpDysa6nRxZgbG2/GYUf1RVuriBCnFgKAMLBNySQSyq0TKmhlrCHnCV9ESCCRO3qqsixcv8XlA5GRXz3m3AGsjJ5qimvo+6JE+hOfFMt6PgE+CKYiUnfav0rLkmKkTSsCdgISI4iDzq4bnwKYF2YirVR8PCHmLCtUoRxhrUSGylLrv52qbdfT+xennTlm+e1fA/fpZLRrMEvx/Ue9N1DWpJA3kFK+wd6K9nfVOpvJOM/Wss= bulat@bulat-pc
                
                
            EOT
        }
      + name                      = "prod-test-for-each-pvm2"
      + network_acceleration_type = "standard"
      + platform_id               = "standard-v3"
      + service_account_id        = (known after apply)
      + status                    = (known after apply)
      + zone                      = (known after apply)

      + boot_disk {
          + auto_delete = true
          + device_name = (known after apply)
          + disk_id     = (known after apply)
          + mode        = (known after apply)

          + initialize_params {
              + block_size  = (known after apply)
              + description = (known after apply)
              + image_id    = "fd8e39r8cq8hpfe9442r"
              + name        = (known after apply)
              + size        = (known after apply)
              + snapshot_id = (known after apply)
              + type        = "network-hdd"
            }
        }

      + metadata_options {
          + aws_v1_http_endpoint = (known after apply)
          + aws_v1_http_token    = (known after apply)
          + gce_http_endpoint    = (known after apply)
          + gce_http_token       = (known after apply)
        }

      + network_interface {
          + index              = (known after apply)
          + ip_address         = (known after apply)
          + ipv4               = true
          + ipv6               = (known after apply)
          + ipv6_address       = (known after apply)
          + mac_address        = (known after apply)
          + nat                = true
          + nat_ip_address     = (known after apply)
          + nat_ip_version     = (known after apply)
          + security_group_ids = (known after apply)
          + subnet_id          = (known after apply)
        }

      + placement_policy {
          + host_affinity_rules = (known after apply)
          + placement_group_id  = (known after apply)
        }

      + resources {
          + core_fraction = 20
          + cores         = 2
          + memory        = 1
        }

      + scheduling_policy {
          + preemptible = true
        }
    }

  # yandex_compute_instance.test_count[0] will be created
  + resource "yandex_compute_instance" "test_count" {
      + created_at                = (known after apply)
      + folder_id                 = (known after apply)
      + fqdn                      = (known after apply)
      + hostname                  = (known after apply)
      + id                        = (known after apply)
      + metadata                  = {
          + "user-data" = <<-EOT
                #cloud-config
                ssh_pwauth: no
                users:
                  - name: netology
                    sudo: ALL=(ALL) NOPASSWD:ALL
                    shell: /bin/bash
                    ssh_authorized_keys:
                      - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDSr1nqbjqW7rKYORqgIyPUhWtC65ZpPJO/yx9UmtkhLv0/FlU3Y3JNf0S3ULe8Ys3ek8G8in1BtGaewAapP7GSozviFTWnhhIMrGzNGrX4i/EmtC2B5ipM1plSM3o54MOV900XcPSrGeNkjDwVmWpHWgLvEI/FDX33ZE+4IIlLnKdD4Rc+JRWvBlFHs7oBuv7sXCoZ1Al3Gkzc9cM/kyw1qb9+S74oG+1hzd2kMYKGgyesFNHjo60LN/2rcqnKqz9oStFSmNTItgXWbMN5NpDysa6nRxZgbG2/GYUf1RVuriBCnFgKAMLBNySQSyq0TKmhlrCHnCV9ESCCRO3qqsixcv8XlA5GRXz3m3AGsjJ5qimvo+6JE+hOfFMt6PgE+CKYiUnfav0rLkmKkTSsCdgISI4iDzq4bnwKYF2YirVR8PCHmLCtUoRxhrUSGylLrv52qbdfT+xennTlm+e1fA/fpZLRrMEvx/Ue9N1DWpJA3kFK+wd6K9nfVOpvJOM/Wss= bulat@bulat-pc
                
                
            EOT
        }
      + name                      = "prod-test-count-0"
      + network_acceleration_type = "standard"
      + platform_id               = "standard-v3"
      + service_account_id        = (known after apply)
      + status                    = (known after apply)
      + zone                      = (known after apply)

      + boot_disk {
          + auto_delete = true
          + device_name = (known after apply)
          + disk_id     = (known after apply)
          + mode        = (known after apply)

          + initialize_params {
              + block_size  = (known after apply)
              + description = (known after apply)
              + image_id    = "fd8e39r8cq8hpfe9442r"
              + name        = (known after apply)
              + size        = (known after apply)
              + snapshot_id = (known after apply)
              + type        = "network-hdd"
            }
        }

      + metadata_options {
          + aws_v1_http_endpoint = (known after apply)
          + aws_v1_http_token    = (known after apply)
          + gce_http_endpoint    = (known after apply)
          + gce_http_token       = (known after apply)
        }

      + network_interface {
          + index              = (known after apply)
          + ip_address         = (known after apply)
          + ipv4               = true
          + ipv6               = (known after apply)
          + ipv6_address       = (known after apply)
          + mac_address        = (known after apply)
          + nat                = true
          + nat_ip_address     = (known after apply)
          + nat_ip_version     = (known after apply)
          + security_group_ids = (known after apply)
          + subnet_id          = (known after apply)
        }

      + placement_policy {
          + host_affinity_rules = (known after apply)
          + placement_group_id  = (known after apply)
        }

      + resources {
          + core_fraction = 20
          + cores         = 2
          + memory        = 1
        }

      + scheduling_policy {
          + preemptible = true
        }
    }

  # yandex_compute_instance.test_count[1] will be created
  + resource "yandex_compute_instance" "test_count" {
      + created_at                = (known after apply)
      + folder_id                 = (known after apply)
      + fqdn                      = (known after apply)
      + hostname                  = (known after apply)
      + id                        = (known after apply)
      + metadata                  = {
          + "user-data" = <<-EOT
                #cloud-config
                ssh_pwauth: no
                users:
                  - name: netology
                    sudo: ALL=(ALL) NOPASSWD:ALL
                    shell: /bin/bash
                    ssh_authorized_keys:
                      - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDSr1nqbjqW7rKYORqgIyPUhWtC65ZpPJO/yx9UmtkhLv0/FlU3Y3JNf0S3ULe8Ys3ek8G8in1BtGaewAapP7GSozviFTWnhhIMrGzNGrX4i/EmtC2B5ipM1plSM3o54MOV900XcPSrGeNkjDwVmWpHWgLvEI/FDX33ZE+4IIlLnKdD4Rc+JRWvBlFHs7oBuv7sXCoZ1Al3Gkzc9cM/kyw1qb9+S74oG+1hzd2kMYKGgyesFNHjo60LN/2rcqnKqz9oStFSmNTItgXWbMN5NpDysa6nRxZgbG2/GYUf1RVuriBCnFgKAMLBNySQSyq0TKmhlrCHnCV9ESCCRO3qqsixcv8XlA5GRXz3m3AGsjJ5qimvo+6JE+hOfFMt6PgE+CKYiUnfav0rLkmKkTSsCdgISI4iDzq4bnwKYF2YirVR8PCHmLCtUoRxhrUSGylLrv52qbdfT+xennTlm+e1fA/fpZLRrMEvx/Ue9N1DWpJA3kFK+wd6K9nfVOpvJOM/Wss= bulat@bulat-pc
                
                
            EOT
        }
      + name                      = "prod-test-count-1"
      + network_acceleration_type = "standard"
      + platform_id               = "standard-v3"
      + service_account_id        = (known after apply)
      + status                    = (known after apply)
      + zone                      = (known after apply)

      + boot_disk {
          + auto_delete = true
          + device_name = (known after apply)
          + disk_id     = (known after apply)
          + mode        = (known after apply)

          + initialize_params {
              + block_size  = (known after apply)
              + description = (known after apply)
              + image_id    = "fd8e39r8cq8hpfe9442r"
              + name        = (known after apply)
              + size        = (known after apply)
              + snapshot_id = (known after apply)
              + type        = "network-hdd"
            }
        }

      + metadata_options {
          + aws_v1_http_endpoint = (known after apply)
          + aws_v1_http_token    = (known after apply)
          + gce_http_endpoint    = (known after apply)
          + gce_http_token       = (known after apply)
        }

      + network_interface {
          + index              = (known after apply)
          + ip_address         = (known after apply)
          + ipv4               = true
          + ipv6               = (known after apply)
          + ipv6_address       = (known after apply)
          + mac_address        = (known after apply)
          + nat                = true
          + nat_ip_address     = (known after apply)
          + nat_ip_version     = (known after apply)
          + security_group_ids = (known after apply)
          + subnet_id          = (known after apply)
        }

      + placement_policy {
          + host_affinity_rules = (known after apply)
          + placement_group_id  = (known after apply)
        }

      + resources {
          + core_fraction = 20
          + cores         = 2
          + memory        = 1
        }

      + scheduling_policy {
          + preemptible = true
        }
    }

  # yandex_vpc_network.network-1 will be created
  + resource "yandex_vpc_network" "network-1" {
      + created_at                = (known after apply)
      + default_security_group_id = (known after apply)
      + folder_id                 = (known after apply)
      + id                        = (known after apply)
      + labels                    = (known after apply)
      + name                      = "network-1"
      + subnet_ids                = (known after apply)
    }

  # yandex_vpc_subnet.network-1-ru-central1-a will be created
  + resource "yandex_vpc_subnet" "network-1-ru-central1-a" {
      + created_at     = (known after apply)
      + folder_id      = (known after apply)
      + id             = (known after apply)
      + labels         = (known after apply)
      + name           = "network-1-ru-central1-a"
      + network_id     = (known after apply)
      + v4_cidr_blocks = [
          + "10.128.0.0/24",
        ]
      + v6_cidr_blocks = (known after apply)
      + zone           = "ru-central1-a"
    }

Plan: 6 to add, 0 to change, 0 to destroy.

─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" now.
```

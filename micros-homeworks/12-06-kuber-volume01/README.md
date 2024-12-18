# Домашнее задание к занятию «Хранение в K8s. Часть 1»

### Задание 1. Создать Deployment приложения, состоящего из двух контейнеров и обменивающихся данными.
  1. Создать Deployment приложения, состоящего из контейнеров busybox и multitool.
  2. Сделать так, чтобы busybox писал каждые пять секунд в некий файл в общей директории.
  3. Обеспечить возможность чтения файла контейнером multitool.
  4. Продемонстрировать, что multitool может читать файл, который периодоически обновляется.
  5. Предоставить манифесты Deployment в решении, а также скриншоты или вывод команды из п. 4.
### Задание 2. Создать DaemonSet приложения, которое может прочитать логи ноды.
  1. Создать DaemonSet приложения, состоящего из multitool.
  2. Обеспечить возможность чтения файла /var/log/syslog кластера MicroK8S.
  3. Продемонстрировать возможность чтения файла изнутри пода.
  4. Предоставить манифесты Deployment, а также скриншоты или вывод команды из п. 2.
### Решение

#### Задание 1
Создал и развернул [Deployment](https://github.com/gemeral68/devops_netology/blob/main/micros-homeworks/12-06-kuber-volume01/src/deployment.yml) 

Зашел внутрь контейнера network-multitool, проверил что мне доступен файл test.txt и при его изменении он перезапишется первым контейнером busybox:

![Image alt](https://github.com/gemeral68/devops_netology/blob/main/micros-homeworks/12-06-kuber-volume01/img/1.png)
![Image alt](https://github.com/gemeral68/devops_netology/blob/main/micros-homeworks/12-06-kuber-volume01/img/2.png)

#### Задание 2
Создал и развернул [Daemonset](https://github.com/gemeral68/devops_netology/blob/main/micros-homeworks/12-06-kuber-volume01/src/daemonset.yml). 

Зашел внутрь контейнера network-multitool, убедился что в точке монтирования я могу читать файлы:

![Image alt](https://github.com/gemeral68/devops_netology/blob/main/micros-homeworks/12-06-kuber-volume01/img/3.png)
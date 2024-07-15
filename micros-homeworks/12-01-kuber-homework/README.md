# Домашнее задание к занятию «Kubernetes. Причины появления. Команда kubectl»

#### Задание 1. Установка MicroK8S
 - Установить MicroK8S на локальную машину или на удалённую виртуальную машину.
 - Установить dashboard.
 - Сгенерировать сертификат для подключения к внешнему ip-адресу.
#### Задание 2. Установка и настройка локального kubectl
 - Установить на локальную машину kubectl.
 - Настроить локально подключение к кластеру.
 - Подключиться к дашборду с помощью port-forward.

### Решение
#### Задание 1
  Установил MicroK8S и kubectl. Командой "microk8s kubectl get nodes" получил информацию о нодах.
  
  ![Image alt](https://github.com/gemeral68/devops_netology/blob/main/micros-homeworks/12-01-kuber-homework/%D0%A1%D0%BD%D0%B8%D0%BC%D0%BE%D0%BA%20%D1%8D%D0%BA%D1%80%D0%B0%D0%BD%D0%B0%202024-07-15%20125247.png)
#### Задание 2
  Установил аддон с дашбордом, сделал проброс порта и подключился к дашборду с помощью токена:
  
  ![Image alt](https://github.com/gemeral68/devops_netology/blob/main/micros-homeworks/12-01-kuber-homework/%D0%A1%D0%BD%D0%B8%D0%BC%D0%BE%D0%BA%20%D1%8D%D0%BA%D1%80%D0%B0%D0%BD%D0%B0%202024-07-15%20131653.png)
  

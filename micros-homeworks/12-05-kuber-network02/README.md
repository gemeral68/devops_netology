# Домашнее задание к занятию «Сетевое взаимодействие в K8S. Часть 2»

#### Задание 1. Создать Deployment приложений backend и frontend
  1. Создать Deployment приложения frontend из образа nginx с количеством реплик 3 шт.
  2. Создать Deployment приложения backend из образа multitool.
  3. Добавить Service, которые обеспечат доступ к обоим приложениям внутри кластера.
  4. Продемонстрировать, что приложения видят друг друга с помощью Service.
  5. Предоставить манифесты Deployment и Service в решении, а также скриншоты или вывод команды п.4.
#### Задание 2. Создать Ingress и обеспечить доступ к приложениям снаружи кластера
  1. Включить Ingress-controller в MicroK8S.
  2. Создать Ingress, обеспечивающий доступ снаружи по IP-адресу кластера MicroK8S так, чтобы при запросе только по адресу открывался frontend а при добавлении /api - backend.
  3. Продемонстрировать доступ с помощью браузера или curl с локального компьютера.
  4. Предоставить манифесты и скриншоты или вывод команды п.2.

#### Задание 1
Создал [Deployment_backend](https://github.com/gemeral68/devops_netology/blob/main/micros-homeworks/12-05-kuber-network02/src/deployment_backend.yml), [Deployment_frontend](https://github.com/gemeral68/devops_netology/blob/main/micros-homeworks/12-05-kuber-network02/src/deployment_frontend.yml) и [Service_backend](https://github.com/gemeral68/devops_netology/blob/main/micros-homeworks/12-05-kuber-network02/src/service_backend.yml), [Service_frontend](https://github.com/gemeral68/devops_netology/blob/main/micros-homeworks/12-05-kuber-network02/src/service_frontend.yml)

 После чего успешно постучался c backend на frontend:
 
![Image alt](https://github.com/gemeral68/devops_netology/blob/main/micros-homeworks/12-05-kuber-network02/img/1.png)

#### Задание 2
По умолчанию в k3s в качестве ingress-контроллера используется traefik.
Создал [Ingress](https://github.com/gemeral68/devops_netology/blob/main/micros-homeworks/12-05-kuber-network02/src/ingress.yml)

После деплоя успешно постучался через браузер:

![Image alt](https://github.com/gemeral68/devops_netology/blob/main/micros-homeworks/12-05-kuber-network02/img/2.png)
![Image alt](https://github.com/gemeral68/devops_netology/blob/main/micros-homeworks/12-05-kuber-network02/img/3.png)
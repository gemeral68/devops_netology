# Домашнее задание к занятию «Хранение в K8s. Часть 2»

### Задание 1. Создать Deployment приложения, использующего локальный PV, созданный вручную.

  1. Создать Deployment приложения, состоящего из контейнеров busybox и multitool.
  2. Создать PV и PVC для подключения папки на локальной ноде, которая будет использована в поде.
  3. Продемонстрировать, что multitool может читать файл, в который busybox пишет каждые пять секунд в общей директории.
  4. Удалить Deployment и PVC. Продемонстрировать, что после этого произошло с PV. Пояснить, почему.
  5. Продемонстрировать, что файл сохранился на локальном диске ноды. Удалить PV. Продемонстрировать что произошло с файлом после удаления PV. Пояснить, почему.
  6. Предоставить манифесты, а также скриншоты или вывод необходимых команд.
#### Задание 2. Создать Deployment приложения, которое может хранить файлы на NFS с динамическим созданием PV.

  1. Включить и настроить NFS-сервер на MicroK8S.
  2. Создать Deployment приложения состоящего из multitool, и подключить к нему PV, созданный автоматически на сервере NFS.
  3. Продемонстрировать возможность чтения и записи файла изнутри пода.
  4. Предоставить манифесты, а также скриншоты или вывод необходимых команд.

### Решение

#### Задание 1
Создал [Deployment](https://github.com/gemeral68/devops_netology/blob/main/micros-homeworks/12-07-kuber-volume02/src/deployment.yml), [PV](https://github.com/gemeral68/devops_netology/blob/main/micros-homeworks/12-07-kuber-volume02/src/pv.yml), [PVC](https://github.com/gemeral68/devops_netology/blob/main/micros-homeworks/12-07-kuber-volume02/src/pvc.yml):

![Image alt](https://github.com/gemeral68/devops_netology/blob/main/micros-homeworks/12-07-kuber-volume02/img/1.png)

 Проверил доступность файла из контейнера multitool:
 
![Image alt](https://github.com/gemeral68/devops_netology/blob/main/micros-homeworks/12-07-kuber-volume02/img/2.png)

 После удаления Deployment и PVC, PV перешел в статус "Released", это говорит о том, что том освобожден, но использовать его, пока в нем есть данные от другого pvc, нельзя:

![Image alt](https://github.com/gemeral68/devops_netology/blob/main/micros-homeworks/12-07-kuber-volume02/img/3.png)

После удаление PV файл сотался на диске. Это произошло из за того, что в режиме "retain", созданные файлы надо удалять вручную:

![Image alt](https://github.com/gemeral68/devops_netology/blob/main/micros-homeworks/12-07-kuber-volume02/img/4.png)

#### Задание 2
Создал [Deployment](https://github.com/gemeral68/devops_netology/blob/main/micros-homeworks/12-07-kuber-volume02/src/nfs_deployment.yml) и [PVC](https://github.com/gemeral68/devops_netology/blob/main/micros-homeworks/12-07-kuber-volume02/src/pvc_nfs.yml):

![Image alt](https://github.com/gemeral68/devops_netology/blob/main/micros-homeworks/12-07-kuber-volume02/img/5.png)

После деплоя успешно постучался через браузер:

![Image alt](https://github.com/gemeral68/devops_netology/blob/main/micros-homeworks/12-07-kuber-volume02/img/6.png)

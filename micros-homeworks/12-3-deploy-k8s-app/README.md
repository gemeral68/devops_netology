# Домашнее задание к занятию «Запуск приложений в K8S»

### Задание 1. Создать Deployment и обеспечить доступ к репликам приложения из другого Pod

   1. Создать Deployment приложения, состоящего из двух контейнеров — nginx и multitool. Решить возникшую ошибку.
   2. После запуска увеличить количество реплик работающего приложения до 2.
   3. Продемонстрировать количество подов до и после масштабирования.
   4. Создать Service, который обеспечит доступ до реплик приложений из п.1.
   5. Создать отдельный Pod с приложением multitool и убедиться с помощью curl, что из пода есть доступ до приложений из п.1.

### Задание 2. Создать Deployment и обеспечить старт основного контейнера при выполнении условий

   1. Создать Deployment приложения nginx и обеспечить старт контейнера только после того, как будет запущен сервис этого приложения.
   2. Убедиться, что nginx не стартует. В качестве Init-контейнера взять busybox.
   3. Создать и запустить Service. Убедиться, что Init запустился.
   4. Продемонстрировать состояние пода до и после запуска сервиса.

### Решение

### Задание1
 - #### При запуске пода столкнулся с ошибкой "Address in use". Причина в том, что порты двух контейнеров пересекались. Поправил манефест и все запустилось:
  
  ![Image alt](https://github.com/gemeral68/devops_netology/blob/main/micros-homeworks/12-3-deploy-k8s-app/img/1.png)

 - #### Увеличил количество реплик манефесте:
    
  ![Image alt](https://github.com/gemeral68/devops_netology/blob/main/micros-homeworks/12-3-deploy-k8s-app/img/2.png)

 - #### Создал сервис, после чего запустил под для проверки доступности nginx:

   ```
   kubectl run multitool --image=wbitt/network-multitool
   ```
 - #### Проверил доступность приложения:
   
  ![Image alt](https://github.com/gemeral68/devops_netology/blob/main/micros-homeworks/12-3-deploy-k8s-app/img/3.png) 

### Задание 2
 - #### Запустил deployment2.yml. Проверяю, что nginx не стартует:
    
  ![Image alt](https://github.com/gemeral68/devops_netology/blob/main/micros-homeworks/12-3-deploy-k8s-app/img/4.png)

 - #### Создал сервис и првоеряю, что приложение запустилось:
   
  ![Image alt](https://github.com/gemeral68/devops_netology/blob/main/micros-homeworks/12-3-deploy-k8s-app/img/5.png)

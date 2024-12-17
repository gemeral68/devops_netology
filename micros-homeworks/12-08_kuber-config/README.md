# Домашнее задание к занятию «Хранение в K8s. Часть 2»

### Задание 1. Создать Deployment приложения и решить возникшую проблему с помощью ConfigMap. Добавить веб-страницу

  1. Создать Deployment приложения, состоящего из контейнеров nginx и multitool.
  2. Решить возникшую проблему с помощью ConfigMap.
  3. Продемонстрировать, что pod стартовал и оба конейнера работают.
  4. Сделать простую веб-страницу и подключить её к Nginx с помощью ConfigMap. Подключить Service и показать вывод curl или в браузере.
  5. Предоставить манифесты, а также скриншоты или вывод необходимых команд.
#### Задание 2. Создать приложение с вашей веб-страницей, доступной по HTTPS
  1. Создать Deployment приложения, состоящего из Nginx.
  2. Создать собственную веб-страницу и подключить её как ConfigMap к приложению.
  3. Выпустить самоподписной сертификат SSL. Создать Secret для использования сертификата.
  4. Создать Ingress и необходимый Service, подключить к нему SSL в вид. Продемонстировать доступ к приложению по HTTPS.
  5. Предоставить манифесты, а также скриншоты или вывод необходимых команд.

### Решение

#### Задание 1

  2. Проблема была в том, что оба приложенгия патылись занять 80 порт.


Создал и развернул [Deployment](https://github.com/gemeral68/devops_netology/blob/main/micros-homeworks/12-08-kuber-config/src/deployment.yml), [CM WEBPORT](https://github.com/gemeral68/devops_netology/blob/main/micros-homeworks/12-08-kuber-config/src/configmap_web.yml), [CM NGINX](https://github.com/gemeral68/devops_netology/blob/main/micros-homeworks/12-08-kuber-config/src/configmap_nginx.yml), [SVC](https://github.com/gemeral68/devops_netology/blob/main/micros-homeworks/12-08-kuber-config/src/svc_nginx.yml):

![Image alt](https://github.com/gemeral68/devops_netology/blob/main/micros-homeworks/12-08-kuber-config/img/1.png)

Проверил доступность сервиса:

![Image alt](https://github.com/gemeral68/devops_netology/blob/main/micros-homeworks/12-08-kuber-config/img/2.png)

#### Задание 2
Создал и развернул [Deployment_NGINX](https://github.com/gemeral68/devops_netology/blob/main/micros-homeworks/12-08-kuber-config/src/deployment_nginx.yml):

Создал сертификат: openssl req -x509 -newkey rsa:2048 -sha256 -nodes -keyout tls.key -out tls.crt -subj "/CN=test.com" -days 365

Создал [Secret_TLS](https://github.com/gemeral68/devops_netology/blob/main/micros-homeworks/12-08-kuber-config/src/secret_tls.yml), [INGRESS](https://github.com/gemeral68/devops_netology/blob/main/micros-homeworks/12-08-kuber-config/src/ingress.yml):

Проверил доступность по HTTPS:

![Image alt](https://github.com/gemeral68/devops_netology/blob/main/micros-homeworks/12-08-kuber-config/img/3.png)

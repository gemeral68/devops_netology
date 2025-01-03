# Домашнее задание к занятию «Безопасность в облачных провайдерах»

### Задание 1. Yandex Cloud
  1. С помощью ключа в KMS необходимо зашифровать содержимое бакета:
   - создать ключ в KMS;
   - с помощью ключа зашифровать содержимое бакета, созданного ранее.
  2. (Выполняется не в Terraform)* Создать статический сайт в Object Storage c собственным публичным адресом и сделать доступным по HTTPS:
   - создать сертификат;
   - создать статическую страницу в Object Storage и применить сертификат HTTPS;
   - в качестве результата предоставить скриншот на страницу с сертификатом в заголовке (замочек).

### Решение

  1. Cоздал [бакет](https://github.com/gemeral68/devops_netology/blob/main/cloud-homeworks/14-03-cloud-security/src/bucket.tf) и зашифровал с помощью ключа содержимое:

  ![Image alt](https://github.com/gemeral68/devops_netology/blob/main/cloud-homeworks/14-03-cloud-security/img/1.png)

  2. Попробовал создать статичный сайт. По названию бакета яндекс сам выдал поддомен. Но так как нет своего домена, прикручивать сертификат не стал:

  ![Image alt](https://github.com/gemeral68/devops_netology/blob/main/cloud-homeworks/14-03-cloud-security/img/2.png)
# Домашнее задание к занятию «Вычислительные мощности. Балансировщики нагрузки»

### Задание 1. Yandex Cloud

  1. Создать бакет Object Storage и разместить в нём файл с картинкой:
   -  Создать бакет в Object Storage с произвольным именем (например, имя_студента_дата).
   -  Положить в бакет файл с картинкой.
   - Сделать файл доступным из интернета.
  2. Создать группу ВМ в public подсети фиксированного размера с шаблоном LAMP и веб-страницей, содержащей ссылку на картинку из бакета:
   - Создать Instance Group с тремя ВМ и шаблоном LAMP. Для LAMP рекомендуется использовать image_id = fd827b91d99psvq5fjit.
   - Для создания стартовой веб-страницы рекомендуется использовать раздел user_data в meta_data.
   - Разместить в стартовой веб-странице шаблонной ВМ ссылку на картинку из бакета.
   - Настроить проверку состояния ВМ.
  3. Подключить группу к сетевому балансировщику:
   - Создать сетевой балансировщик.
   - Проверить работоспособность, удалив одну или несколько ВМ.

### Решение

  1. Создал бакет и загрузил в него файл:

  ![Image alt](https://github.com/gemeral68/devops_netology/blob/main/cloud-homeworks/14-02-cloud-balancer/img/1.png)

  2. Развернул 3 ВМ через instance group:

  ![Image alt](https://github.com/gemeral68/devops_netology/blob/main/cloud-homeworks/14-02-cloud-balancer/img/2.png)

  ![Image alt](https://github.com/gemeral68/devops_netology/blob/main/cloud-homeworks/14-02-cloud-balancer/img/3.png)

  3. Подцепил к группе network balancer:

  ![Image alt](https://github.com/gemeral68/devops_netology/blob/main/cloud-homeworks/14-02-cloud-balancer/img/4.png)

  4. Создал Application Load Balancer и подцепил к созданной ранее IG:

  ![Image alt](https://github.com/gemeral68/devops_netology/blob/main/cloud-homeworks/14-02-cloud-balancer/img/5.png)
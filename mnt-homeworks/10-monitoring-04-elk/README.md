## Обязательные задания

### Задание 1
Вам необходимо поднять в докере и связать между собой:

     - elasticsearch (hot и warm ноды);
     - logstash;
     - kibana;
     - filebeat.
     
- Logstash следует сконфигурировать для приёма по tcp json-сообщений.

- Filebeat следует сконфигурировать для отправки логов docker вашей системы в logstash.

### Задание 2
Перейдите в меню создания index-patterns в kibana и создайте несколько index-patterns из имеющихся.

Перейдите в меню просмотра логов в kibana (Discover) и самостоятельно изучите, как отображаются логи и как производить поиск по логам.

В манифесте директории help также приведенно dummy-приложение, которое генерирует рандомные события в stdout-контейнера. Эти логи должны порождать индекс logstash-* в elasticsearch. 

## Решение

### Задание 1
Запущенные контейнеры спустя 5 минут:
![Image alt](https://github.com/gemeral68/devops_netology/blob/main/mnt-homeworks/10-monitoring-04-elk/%D0%A1%D0%BD%D0%B8%D0%BC%D0%BE%D0%BA%20%D1%8D%D0%BA%D1%80%D0%B0%D0%BD%D0%B0%202024-07-03%20125942.png)

Скрин интерфейса Kibana:
![Image alt](https://github.com/gemeral68/devops_netology/blob/main/mnt-homeworks/10-monitoring-04-elk/%D0%A1%D0%BD%D0%B8%D0%BC%D0%BE%D0%BA%20%D1%8D%D0%BA%D1%80%D0%B0%D0%BD%D0%B0%202024-07-03%20125725.png)

### Задание 2
Индекс паттерн:
![Image alt](https://github.com/gemeral68/devops_netology/blob/main/mnt-homeworks/10-monitoring-04-elk/%D0%A1%D0%BD%D0%B8%D0%BC%D0%BE%D0%BA%20%D1%8D%D0%BA%D1%80%D0%B0%D0%BD%D0%B0%202024-07-03%20130134.png)

Меню просмотра логов в Kibana:
![Image alt](https://github.com/gemeral68/devops_netology/blob/main/mnt-homeworks/10-monitoring-04-elk/%D0%A1%D0%BD%D0%B8%D0%BC%D0%BE%D0%BA%20%D1%8D%D0%BA%D1%80%D0%B0%D0%BD%D0%B0%202024-07-03%20130532.png)

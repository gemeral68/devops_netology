# Домашнее задание к занятию Troubleshooting

### Задание. При деплое приложение web-consumer не может подключиться к auth-db. Необходимо это исправить
Установить приложение по команде:
    ``` 
    kubectl apply -f https://raw.githubusercontent.com/netology-code/kuber-homeworks/main/3.5/files/task.yaml
    ```
  1. Выявить проблему и описать.
  2. Исправить проблему, описать, что сделано.
  3. Продемонстрировать, что проблема решена.

### Решение

1. При попытке развернуть приложение, сразу видим, что нехватает нескольких namespace:

![Image alt](https://github.com/gemeral68/devops_netology/blob/main/micros-homeworks/12-15_kuber-troubleshooting/img/1.png)

2. Создаю namespace и продолжаю установку приложения:

![Image alt](https://github.com/gemeral68/devops_netology/blob/main/micros-homeworks/12-15_kuber-troubleshooting/img/2.png)
![Image alt](https://github.com/gemeral68/devops_netology/blob/main/micros-homeworks/12-15_kuber-troubleshooting/img/3.png)

3. Проверю статус deployments и pods:

![Image alt](https://github.com/gemeral68/devops_netology/blob/main/micros-homeworks/12-15_kuber-troubleshooting/img/4.png) 

4. При проверке логов приложения, вижу, что в приложении деплоймента auth-db все в порядке, но с приложением деплоймента web-consumer есть проблема, оно не может достучаться до auth-db по имени хоста.

![Image alt](https://github.com/gemeral68/devops_netology/blob/main/micros-homeworks/12-15_kuber-troubleshooting/img/5.png) 

Причина связана с тем, что деплойменты находятся в разных namespace.

5. Решением будет отредактировать манифест деплоймента web-consumer и в строке команды curl auth-db заменить на curl auth-db.data:

![Image alt](https://github.com/gemeral68/devops_netology/blob/main/micros-homeworks/12-15_kuber-troubleshooting/img/6.png) 

После перезапуска деплоймента выполнение команды в поде web-consumer выполняется успешно:

![Image alt](https://github.com/gemeral68/devops_netology/blob/main/micros-homeworks/12-15_kuber-troubleshooting/img/7.png) 

Приложение в поде работает корректно, команда curl auth-db выполняется каждые 5 секунд.
# "6.2. SQL"
## 1. Используя docker поднимите инстанс PostgreSQL (версию 12) c 2 volume, в который будут складываться данные БД и бэкапы.
Прикладываю docker-compose файл:
```   
    version: "3.9"
    services:
      postgres:
        image: postgres:12
        environment:
          POSTGRES_DB: "test_db"
          POSTGRES_USER: "test-admin-user"
          POSTGRES_PASSWORD: "test"
        volumes:
          - /root/postgres/database:/var/lib/postgresql/data/
          - /root/postgres/backups:/media/postgresql/backup  
        ports:
          - "5432:5432"
        restart: always   
```
## 2. 2. В БД из задачи 1:
- создайте пользователя test-admin-user и БД test_db
- в БД test_db создайте таблицу orders и clients (спeцификация таблиц ниже)
- предоставьте привилегии на все операции пользователю test-admin-user на таблицы БД test_db
- создайте пользователя test-simple-user
- предоставьте пользователю test-simple-user права на SELECT/INSERT/UPDATE/DELETE данных таблиц БД test_db

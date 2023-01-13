# 8. MySQL
## Задание 1
- Используя docker поднимите инстанс MySQL (версию 8). Данные БД сохраните в volume.

- Изучите бэкап БД и восстановитесь из него.

- Перейдите в управляющую консоль mysql внутри контейнера.

- Используя команду \h получите список управляющих команд.

- Найдите команду для выдачи статуса БД и приведите в ответе из ее вывода версию сервера БД.

- Подключитесь к восстановленной БД и получите список таблиц из этой БД.

- Приведите в ответе количество записей с price > 300.

![](https://github.com/gemeral68/devops_netology/blob/main/virt-homeworks/06-db-03-mysql/1.png)

![](https://github.com/gemeral68/devops_netology/blob/main/virt-homeworks/06-db-03-mysql/2.png)

## Задание 2
Создайте пользователя test в БД c паролем test-pass, используя:

- плагин авторизации mysql_native_password
- срок истечения пароля - 180 дней
- количество попыток авторизации - 3
- максимальное количество запросов в час - 100
- аттрибуты пользователя:
    Фамилия "Pretty"
    Имя "James"

Предоставьте привелегии пользователю test на операции SELECT базы test_db.

Используя таблицу INFORMATION_SCHEMA.USER_ATTRIBUTES получите данные по пользователю test и приведите в ответе к задаче.

![](https://github.com/gemeral68/devops_netology/blob/main/virt-homeworks/06-db-03-mysql/3.png)

<img src="https://github.com/gemeral68/devops_netology/blob/main/virt-homeworks/06-db-03-mysql/4.png" width="400" height="40">

<img src="https://github.com/gemeral68/devops_netology/blob/main/virt-homeworks/06-db-03-mysql/5.png" width="600" >

## Задание 3
Установите профилирование SET profiling = 1. Изучите вывод профилирования команд SHOW PROFILES;.

Исследуйте, какой engine используется в таблице БД test_db и приведите в ответе.

Измените engine и приведите время выполнения и запрос на изменения из профайлера в ответе:

- на MyISAM
- на InnoDB

В таблице БД используется InnoDB:

![](https://github.com/gemeral68/devops_netology/blob/main/virt-homeworks/06-db-03-mysql/6.png)

```
mysql> SHOW PROFILES;
+----------+------------+-----------------------------------+
| Query_ID | Duration   | Query                             |
+----------+------------+-----------------------------------+
|        1 | 0.00010875 | show table status from test-sql   |
|        2 | 0.00009025 | show table status from 'test-sql' |
|        3 | 0.00532700 | show table status from `test-sql` |
|        4 | 0.00016300 | SET profiling = 1                 |
+----------+------------+-----------------------------------+
4 rows in set, 1 warning (0.00 sec)

mysql> ALTER TABLE orders ENGINE = MyISAM;
Query OK, 5 rows affected (0.08 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql>  ALTER TABLE orders ENGINE = InnoDB;
Query OK, 5 rows affected (0.23 sec)
Records: 5  Duplicates: 0  Warnings: 0
```
## Задание 4
Изучите файл my.cnf в директории /etc/mysql.

Измените его согласно ТЗ (движок InnoDB):

- Скорость IO важнее сохранности данных
- Нужна компрессия таблиц для экономии места на диске
- Размер буффера с незакомиченными транзакциями 1 Мб
- Буффер кеширования 30% от ОЗУ
- Размер файла логов операций 100 Мб

![](https://github.com/gemeral68/devops_netology/blob/main/virt-homeworks/06-db-03-mysql/8.png)

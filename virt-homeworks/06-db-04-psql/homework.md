# 6.4 PostgreSQL
## Задача 1
Используя docker поднимите инстанс PostgreSQL (версию 13). Данные БД сохраните в volume.

Подключитесь к БД PostgreSQL используя psql.

Воспользуйтесь командой \? для вывода подсказки по имеющимся в psql управляющим командам.

Найдите и приведите управляющие команды для:

- вывода списка БД
- подключения к БД
- вывода списка таблиц
- вывода описания содержимого таблиц
- выхода из psql

### Ответ:
```
  version: "3.3"
    services:
      postgres:
        image: postgres:13
        environment:
          POSTGRES_DB: "test_database"
          POSTGRES_USER: "postgres"
          POSTGRES_PASSWORD: "postgres"
        volumes:
          - /root/postgres/database:/var/lib/postgresql/data/
          - /root/postgres/backups:/media/postgresql/backup  
        ports:
          - "5432:5432"
        restart: always
 ```
 
 - вывода списка БД
 ```
\l[+]   [PATTERN] - list databases
 ```
- подключения к БД
```
\c[onnect] {[DBNAME|- USER|- HOST|- PORT|-] | conninfo} - connect to new database (currently "test_database")
```
- вывода списка таблиц
```
\dt[S+] [PATTERN] - list tables
```
- вывода описания содержимого таблиц
```
\d[S+]  NAME - describe table, view, sequence, or index
```
- выхода из psql
```
\q - quit psql
```

## Задача 2
Используя psql создайте БД test_database.

Изучите бэкап БД.

Восстановите бэкап БД в test_database.

Перейдите в управляющую консоль psql внутри контейнера.

Подключитесь к восстановленной БД и проведите операцию ANALYZE для сбора статистики по таблице.

Используя таблицу pg_stats, найдите столбец таблицы orders с наибольшим средним значением размера элементов в байтах.

Приведите в ответе команду, которую вы использовали для вычисления и полученный результат.

### Ответ:
```
root@netology:~/postgres# psql -U postgres -h 127.0.0.1 -f test_dump.sql test_database
Password for user postgres: 
SET
SET
SET
SET
SET
 set_config 
------------
(1 row)

SET
SET
SET
SET
SET
SET
CREATE TABLE
ALTER TABLE
CREATE SEQUENCE
ALTER TABLE
ALTER SEQUENCE
ALTER TABLE
COPY 8
 setval 
--------
      8
(1 row)

ALTER TABLE
```

```
test_database=# select avg_width from pg_stats  where tablename = 'orders';
 avg_width 
-----------
         4
        16
         4
(3 rows)
```

## Задача 3
Архитектор и администратор БД выяснили, что ваша таблица orders разрослась до невиданных размеров и поиск по ней занимает долгое время. Вам, как успешному выпускнику курсов DevOps в нетологии предложили провести разбиение таблицы на 2 (шардировать на orders_1 - price>499 и orders_2 - price<=499).

Предложите SQL-транзакцию для проведения данной операции.

Можно ли было изначально исключить "ручное" разбиение при проектировании таблицы orders?

### Ответ:
```
test_database=# alter table public.orders rename to old_orders;
ALTER TABLE
test_database=# create table public.orders (like public.old_orders) partition by range(price);
CREATE TABLE
test_database=# create table public.orders_1 partition of public.orders for values from ( 499) to (999999999);
CREATE TABLE
test_database=# create table public.orders_2 partition of public.orders for values from (0) to (499);
CREATE TABLE
test_database=# insert into public.orders (id,title,price) select*from public.old_orders;
INSERT 0 8
```

```
test_database=# \d orders;
                Partitioned table "public.orders"
 Column |         Type          | Collation | Nullable | Default 
--------+-----------------------+-----------+----------+---------
 id     | integer               |           | not null | 
 title  | character varying(80) |           | not null | 
 price  | integer               |           |          | 
Partition key: RANGE (price)
Number of partitions: 2 (Use \d+ to list them.)
```
При проектировании больших таблиц, можно изначально их разбивать на партиции с необходимыми ограничениями, чтобы данные записывались в партиции в равных долях.

# Задача 4
Используя утилиту pg_dump создайте бекап БД test_database.

Как бы вы доработали бэкап-файл, чтобы добавить уникальность значения столбца title для таблиц test_database?

### Ответ:
```
root@40bc9cea3d77:/media/postgresql/backup# pg_dump -h 127.0.0.1 --format custom -U postgres -p 5432 --blobs -d test_database -f test_database.dump -v
root@40bc9cea3d77:/media/postgresql/backup# ls
test_database.dump

root@40bc9cea3d77:/media/postgresql/backup# pg_dump -U postgres -W test_database > test_database.sql
root@40bc9cea3d77:/media/postgresql/backup# ls
test_database.dump  test_database.sql
```
Доработал бекап следующим образом:
```
-- Name: orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orders (
    id integer NOT NULL,
    title character varying(80) UNIQUE NOT NULL,
    price integer DEFAULT 0
)
```

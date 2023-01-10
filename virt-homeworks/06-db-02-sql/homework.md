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

![](https://github.com/gemeral68/devops_netology/blob/main/virt-homeworks/06-db-02-sql/1.png)

![](https://github.com/gemeral68/devops_netology/blob/main/virt-homeworks/06-db-02-sql/2.png)

![](https://github.com/gemeral68/devops_netology/blob/main/virt-homeworks/06-db-02-sql/3.png)

![](https://github.com/gemeral68/devops_netology/blob/main/virt-homeworks/06-db-02-sql/5.png)

![](https://github.com/gemeral68/devops_netology/blob/main/virt-homeworks/06-db-02-sql/4.png)

## 3. Используя SQL синтаксис - наполните таблицы.
```   
   insert into orders VALUES (1, 'Шоколад', 10), (2, 'Принтер', 3000), (3, 'Книга', 500), (4, 'Монитор', 7000), (5, 'Гитара', 4000);
   insert into clients VALUES (1, 'Иванов Иван Иванович', 'USA'), (2, 'Петров Петр Петрович', 'Canada'), (3, 'Иоганн Себастьян Бах', 'Japan'), (4, 'Ронни Джеймс Дио', 'Russia'), (5, 'Ritchie Blackmore', 'Russia');
```
![](https://github.com/gemeral68/devops_netology/blob/main/virt-homeworks/06-db-02-sql/6.png)

## 4. Часть пользователей из таблицы clients решили оформить заказы из таблицы orders. Используя foreign keys свяжите записи из таблиц, согласно таблице:
```    
    update clients set заказ = 3 where id = 1;
    update clients set заказ = 4 where id = 2;
    update clients set заказ = 5 where id = 3;
```
![](https://github.com/gemeral68/devops_netology/blob/main/virt-homeworks/06-db-02-sql/7.png)

## 5.  Получите полную информацию по выполнению запроса выдачи всех пользователей из задачи 4 (используя директиву EXPLAIN). Приведите получившийся результат и объясните что значат полученные значения.

![](https://github.com/gemeral68/devops_netology/blob/main/virt-homeworks/06-db-02-sql/8.png)

Планировщик выбрал план простого последовательного сканирования. Условие WHERE применено как «фильтр» к узлу плана Seq Scan (Последовательное сканирование). Числа, перечисленные в скобках (слева направо), имеют следующий смысл:
- Приблизительная стоимость запуска. Это время, которое проходит, прежде чем начнётся этап вывода данных, например для сортирующего узла это время сортировки.
- Приблизительная общая стоимость. Она вычисляется в предположении, что узел плана выполняется до конца, то есть возвращает все доступные строки.
- Ожидаемое число строк, которое должен вывести этот узел плана. При этом так же предполагается, что узел выполняется до конца.
- Ожидаемый средний размер строк, выводимых этим узлом плана (в байтах).

## 6. 
- Создайте бэкап БД test_db и поместите его в volume, предназначенный для бэкапов (см. Задачу 1).
- Остановите контейнер с PostgreSQL (но не удаляйте volumes).
- Поднимите новый пустой контейнер с PostgreSQL.
- Восстановите БД test_db в новом контейнере.
- Приведите список операций, который вы применяли для бэкапа данных и восстановления.

![](https://github.com/gemeral68/devops_netology/blob/main/virt-homeworks/06-db-02-sql/9.png)

![](https://github.com/gemeral68/devops_netology/blob/main/virt-homeworks/06-db-02-sql/10.png)

![](https://github.com/gemeral68/devops_netology/blob/main/virt-homeworks/06-db-02-sql/11.png)

![](https://github.com/gemeral68/devops_netology/blob/main/virt-homeworks/06-db-02-sql/12.png)

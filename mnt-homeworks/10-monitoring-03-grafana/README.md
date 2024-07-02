## Обязательные задания

### Задание 1
Используя директорию help внутри этого домашнего задания, запустите связку prometheus-grafana.
Зайдите в веб-интерфейс grafana, используя авторизационные данные, указанные в манифесте docker-compose.
Подключите поднятый вами prometheus, как источник данных.
Решение домашнего задания — скриншот веб-интерфейса grafana со списком подключенных Datasource.

### Задание 2

 - Создайте Dashboard и в ней создайте Panels:
    - утилизация CPU для nodeexporter (в процентах, 100-idle);
    - CPULA 1/5/15;
    - количество свободной оперативной памяти;
    - количество места на файловой системе.
Для решения этого задания приведите promql-запросы для выдачи этих метрик, а также скриншот получившейся Dashboard.

### Задание 3
Создайте для каждой Dashboard подходящее правило alert — можно обратиться к первой лекции в блоке «Мониторинг».
В качестве решения задания приведите скриншот вашей итоговой Dashboard.

### Задание 4
Сохраните ваш Dashboard.Для этого перейдите в настройки Dashboard, выберите в боковом меню «JSON MODEL». Далее скопируйте отображаемое json-содержимое в отдельный файл и сохраните его.
В качестве решения задания приведите листинг этого файла.

## Решение

### Задание 1
  ![Image alt](https://github.com/gemeral68/devops_netology/blob/main/mnt-homeworks/10-monitoring-03-grafana/%D0%A1%D0%BD%D0%B8%D0%BC%D0%BE%D0%BA%20%D1%8D%D0%BA%D1%80%D0%B0%D0%BD%D0%B0%202024-07-01%20155617.png)

### Задание 2
Запросы promql:
 - Утилизация CPU для nodeexporter (в процентах, 100-idle):
  ```sql
    100 - (avg by (instance) (rate(node_cpu_seconds_total{job="$job",mode="idle"}[1m])) * 100)
  ```
 - CPULA 1/5/15:
  ```sql
    (node_load15{instance="$node",job="$job"})
    (node_load5{instance="$node",job="$job"})
    (node_load1{instance="$node",job="$job"})
  ```
 - количество свободной оперативной памяти
  ```sql
    node_memory_MemFree_bytes{instance="$node",job="$job"}
  ```
 - количество места на файловой системе
  ```sql
    node_filesystem_avail_bytes{instance="$node",job="$job",device!~"/dev/vda2"}
  ```
  Dashboard со всеми panels:
  
  ![Image alt](https://github.com/gemeral68/devops_netology/blob/main/mnt-homeworks/10-monitoring-03-grafana/%D0%A1%D0%BD%D0%B8%D0%BC%D0%BE%D0%BA%20%D1%8D%D0%BA%D1%80%D0%B0%D0%BD%D0%B0%202024-07-01%20173925.png)

### Задание 3
  Итоговый вид Dashboard`а:

  ![Image alt](https://github.com/gemeral68/devops_netology/blob/main/mnt-homeworks/10-monitoring-03-grafana/%D0%A1%D0%BD%D0%B8%D0%BC%D0%BE%D0%BA%20%D1%8D%D0%BA%D1%80%D0%B0%D0%BD%D0%B0%202024-07-01%20175804.png)

  Как видно в панели "FREE HDD MEM" появилась полоса, указывающая размер памяти, при котором будет срабатывать алерт. Для остальных панелей алерты тоже настроены, но не попали на график.
  
  ![Image alt](https://github.com/gemeral68/devops_netology/blob/main/mnt-homeworks/10-monitoring-03-grafana/%D0%A1%D0%BD%D0%B8%D0%BC%D0%BE%D0%BA%20%D1%8D%D0%BA%D1%80%D0%B0%D0%BD%D0%B0%202024-07-01%20180059.png) 

### Задание 4
  [JSON MODEL моего Dashboard](https://github.com/gemeral68/devops_netology/blob/main/mnt-homeworks/10-monitoring-03-grafana/Dashboard_JSON_model.json)

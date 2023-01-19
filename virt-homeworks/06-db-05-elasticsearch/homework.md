# "10. Elasticsearch"

## Задача 1

Используя докер образ centos:7 как базовый и документацию по установке и запуску Elastcisearch:

- составьте Dockerfile-манифест для elasticsearch
```dockerfile
FROM centos:7
USER 0
RUN groupadd -g 1000 elasticsearch && useradd elasticsearch -u 1000 -g 1000

RUN yum makecache && \
    yum -y install wget perl-Digest-SHA

COPY elasticsearch-8.6.0-linux-x86_64.tar.gz /
COPY elasticsearch-8.6.0-linux-x86_64.tar.gz.sha512 /

RUN \
    cd / && \
    shasum -a 512 -c elasticsearch-8.6.0-linux-x86_64.tar.gz.sha512 && \
    tar -xzf elasticsearch-8.6.0-linux-x86_64.tar.gz && \
    rm -rf elasticsearch-8.6.0-linux-x86_64.tar.gz && \
    mv /elasticsearch-8.6.0 /var/lib/elasticsearch && \
    chown -R elasticsearch:elasticsearch /var/lib/elasticsearch/

RUN mkdir /var/lib/data /var/lib/logs && \
    chown -R elasticsearch:elasticsearch /var/lib/data /var/lib/logs


COPY elasticsearch.yml /var/lib/elasticsearch/config

USER 1000

CMD ["/var/lib/elasticsearch/bin/elasticsearch"]

EXPOSE 9200 9300
```
- соберите docker-образ и сделайте push в ваш docker.io репозиторий

  https://hub.docker.com/layers/nardah/cent_es/1.2/images/sha256-77b3ddffe89f1cfa59673d829ac4ce3847b0b00e5cb9d0b9b2b201078aa418aa?context=explore

- запустите контейнер из получившегося образа и выполните запрос пути / c хост-машины
```
{
  "name" : "netology_test",
  "cluster_name" : "elasticsearch",
  "cluster_uuid" : "IQdQoZj5Qtmn4Sfb53Kyxg",
  "version" : {
    "number" : "8.6.0",
    "build_flavor" : "default",
    "build_type" : "tar",
    "build_hash" : "f67ef2df40237445caa70e2fef79471cc608d70d",
    "build_date" : "2023-01-04T09:35:21.782467981Z",
    "build_snapshot" : false,
    "lucene_version" : "9.4.2",
    "minimum_wire_compatibility_version" : "7.17.0",
    "minimum_index_compatibility_version" : "7.0.0"
  },
  "tagline" : "You Know, for Search"
}
```

Требования к elasticsearch.yml:
```yml
discovery.type: single-node

node.name: netology_test

path.data: /var/lib/data

path.logs: /var/lib/logs

path.repo: /var/lib/elasticsearch/snapshots

network.host: 0.0.0.0

http.port: 9200

xpack.security.enabled: false
```

## Задача 2

Получите список индексов и их статусов, используя API и приведите в ответе на задание.
```
[elasticsearch@4d8e8b0902f9 elasticsearch]$ curl -X GET "127.0.0.1:9200/_cat/indices/ind-*?v=true&s=index&pretty"
health status index uuid                   pri rep docs.count docs.deleted store.size pri.store.size
green  open   ind-1 fXeWsuNKTx6MHbDYeTa9IA   1   0          0            0       225b           225b
yellow open   ind-2 tTwE4b1jT-aX5Sp2lX2GAg   2   1          0            0       450b           450b
yellow open   ind-3 AC31uFipRnOPQtgtWJqk1g   4   2          0            0       900b           900b
```
Получите состояние кластера elasticsearch, используя API.
```
[elasticsearch@4d8e8b0902f9 elasticsearch]$ curl -X GET "localhost:9200/_cluster/health?pretty"
{
  "cluster_name" : "elasticsearch",
  "status" : "yellow",
  "timed_out" : false,
  "number_of_nodes" : 1,
  "number_of_data_nodes" : 1,
  "active_primary_shards" : 8,
  "active_shards" : 8,
  "relocating_shards" : 0,
  "initializing_shards" : 0,
  "unassigned_shards" : 10,
  "delayed_unassigned_shards" : 0,
  "number_of_pending_tasks" : 0,
  "number_of_in_flight_fetch" : 0,
  "task_max_waiting_in_queue_millis" : 0,
  "active_shards_percent_as_number" : 44.44444444444444
}
```
Как вы думаете, почему часть индексов и кластер находится в состоянии yellow?

  #### В системах с одной нодой первичный шард и реплика не могут находится на одном узле.
 
  Best practice:
``` 
  index.number_of_replicas = number_of nodes - 1.
```

## Задача 3

Используя API зарегистрируйте данную директорию как snapshot repository c именем netology_backup.
```
[elasticsearch@4d8e8b0902f9 elasticsearch]$ curl -X PUT "127.0.0.1:9200/_snapshot/netology_backup?&pretty" -H 'Content-Type: application/json' -d'
> {
>   "type": "fs",
>   "settings": {
>     "location": "/var/lib/elasticsearch/snapshots"
>   }
> }
> '
{
  "acknowledged" : true
}
```
Создайте индекс test с 0 реплик и 1 шардом и приведите в ответе список индексов.
```
[elasticsearch@4d8e8b0902f9 /]$ curl -X GET "127.0.0.1:9200/_cat/indices/*?v=true&s=index&pretty"
health status index  uuid                   pri rep docs.count docs.deleted store.size pri.store.size
green  open   test   Xh4365jYQKG5yqI6hAfosA   1   0          0            0       225b           225b
```
Создайте snapshot состояния кластера elasticsearch.
```
[elasticsearch@4d8e8b0902f9 /]$ curl -X PUT "127.0.0.1:9200/_snapshot/netology_backup/my_snapshot_1?wait_for_completion=true&pretty"
{
  "snapshot" : {
    "snapshot" : "my_snapshot_1",
    "uuid" : "zhnqUCPHThiwOiVjnwrUkA",
    "repository" : "netology_backup",
    "version_id" : 8060099,
    "version" : "8.6.0",
    "indices" : [
      "test",
      ".geoip_databases"
    ],
    "data_streams" : [ ],
    "include_global_state" : true,
    "state" : "SUCCESS",
    "start_time" : "2023-01-19T12:55:27.496Z",
    "start_time_in_millis" : 1674132927496,
    "end_time" : "2023-01-19T12:55:29.097Z",
    "end_time_in_millis" : 1674132929097,
    "duration_in_millis" : 1601,
    "failures" : [ ],
    "shards" : {
      "total" : 2,
      "failed" : 0,
      "successful" : 2
    },
    "feature_states" : [
      {
        "feature_name" : "geoip",
        "indices" : [
          ".geoip_databases"
        ]
      }
    ]
  }
}
```
Приведите в ответе список файлов в директории со snapshotами.
```
[elasticsearch@4d8e8b0902f9 /]$ ll /var/lib/elasticsearch/snapshots/
total 36
-rw-r--r-- 1 elasticsearch elasticsearch   846 Jan 19 12:55 index-0
-rw-r--r-- 1 elasticsearch elasticsearch     8 Jan 19 12:55 index.latest
drwxr-xr-x 4 elasticsearch elasticsearch  4096 Jan 19 12:55 indices
-rw-r--r-- 1 elasticsearch elasticsearch 18695 Jan 19 12:55 meta-zhnqUCPHThiwOiVjnwrUkA.dat
-rw-r--r-- 1 elasticsearch elasticsearch   350 Jan 19 12:55 snap-zhnqUCPHThiwOiVjnwrUkA.dat
```
Удалите индекс test и создайте индекс test-2. Приведите в ответе список индексов.
```
[elasticsearch@4d8e8b0902f9 /]$ curl -X GET "127.0.0.1:9200/_cat/indices/*?v=true&s=index&pretty"
health status index  uuid                   pri rep docs.count docs.deleted store.size pri.store.size
green  open   test-2 8hqHTVFdS_W6zvkM35tn9w   1   0          0            0       225b           225b
```
Восстановите состояние кластера elasticsearch из snapshot, созданного ранее.
```
[elasticsearch@4d8e8b0902f9 /]$ curl -X POST "127.0.0.1:9200/_snapshot/netology_backup/my_snapshot_1/_restore?pretty" -H 'Content-Type: application/json' -d'
> {
>   "indices": "*",
>   "include_global_state": true
> }
> '
{
  "accepted" : true
}
```
```
[elasticsearch@4d8e8b0902f9 /]$ curl -X GET "127.0.0.1:9200/_cat/indices/*?v=true&s=index&pretty"
health status index  uuid                   pri rep docs.count docs.deleted store.size pri.store.size
green  open   test   Xh4365jYQKG5yqI6hAfosA   1   0          0            0       225b           225b
green  open   test-2 8hqHTVFdS_W6zvkM35tn9w   1   0          0            0       225b           225b
```


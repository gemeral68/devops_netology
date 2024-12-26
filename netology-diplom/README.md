# Дипломный практикум в Yandex.Cloud

### Цели:
  1. Подготовить облачную инфраструктуру на базе облачного провайдера Яндекс.Облако.
  2. Запустить и сконфигурировать Kubernetes кластер.
  3. Установить и настроить систему мониторинга.
  4. Настроить и автоматизировать сборку тестового приложения с использованием Docker-контейнеров.
  5. Настроить CI для автоматической сборки и тестирования.
  6. Настроить CD для автоматического развёртывания приложения.

### Выполнение практикума

#### Подготовить облачную инфраструктуру на базе облачного провайдера Яндекс.Облако.

1. Манефест на создание сервис аккаунта [SA](https://github.com/gemeral68/devops_netology/blob/main/netology-diplom/project/sa.tf)
2. Манефест на создание бакета [Bucket](https://github.com/gemeral68/devops_netology/blob/main/netology-diplom/project/bucket.tf)
3. Манефест для настройки [VPC и Subnets](https://github.com/gemeral68/devops_netology/blob/main/netology-diplom/project/vpc.tf)
4. Основной манефест для создания инфраструктуры [Main](https://github.com/gemeral68/devops_netology/blob/main/netology-diplom/project/main.tf)
Также автоматически создается [inventory](https://github.com/gemeral68/devops_netology/blob/main/netology-diplom/project/templates/inventory.ini) на основе [jinja2 темплейта](https://github.com/gemeral68/devops_netology/blob/main/netology-diplom/project/templates/inventory.tftpl) и [terraform манефеста](https://github.com/gemeral68/devops_netology/blob/main/netology-diplom/project/inventory.tf) для дальнейшего развенртывания кластера k8s. 

Для конфигурирования виртуальных машин используется файл [variables](https://github.com/gemeral68/devops_netology/blob/main/netology-diplom/project/variables.tf)

![Image alt](https://github.com/gemeral68/devops_netology/blob/main/netology-diplom/img/1.png)
Публичные адреса отличаются от итоговых по причине того, что машины создавались с динамическими белыми адресами и с прерыванием. Соответвенно раз в сутки они отключались и адреса менялись.

#### Создание Kubernetes кластера
Для создания k8s кластера был использован репозиторий [kubespray](https://github.com/kubernetes-sigs/kubespray). 

1. Предварительно были внесены изменения в файлы конфигурации:
```
 В манифест inventory/sample/group_vars/all/all.yml
 kube_read_only_port: 10255

 В манифест inventory/sample/group_vars/k8s_cluster/k8s-cluster.yml
 kubelet_authentication_token_webhook: true
 kubelet_authorization_mode_webhook: true
```
2. Далее в качестве inventory был указан файл, созданный ранее автоматически, при создании ВМ. Плюсом прописал в файл ansible.cfg.
```
   enable_plugins = yaml, ini в файл ansible.cfg
```
3. Запустил ansible playbook:
```
   cd kubespray
   ansible-playbook -i ../inventory.ini  cluster.yml -b -v
   
```
4. По итогу получаем рабочий кластер:
   
![Image alt](https://github.com/gemeral68/devops_netology/blob/main/netology-diplom/img/2.png)

![Image alt](https://github.com/gemeral68/devops_netology/blob/main/netology-diplom/img/3.png)

#### Создание тестового приложения
1. Написал простнькую [страничку](http://89.169.144.118:30080/)  с двигающимся по горизонтали красным квадратом. При наведении на него мышкой цвет квадрата меняется на синий. Под проект с приложением создал отдельный [репозиторий](https://github.com/gemeral68/diplom), для удобства дальнейшей сборки. Там же лежат [dockerfile](https://github.com/gemeral68/diplom/blob/main/Dockerfile) и [deployment](https://github.com/gemeral68/diplom/blob/main/deployment.yml) для k8s.

2. Для хранения собранных docker images создал Container Registry в Yandex Cloud:
   
![Image alt](https://github.com/gemeral68/devops_netology/blob/main/netology-diplom/img/4.png)

#### Подготовка cистемы мониторинга и деплой приложения

1. Для развертывания системы мониторинга, склонировал репозиторий [kube-prometheus](https://github.com/prometheus-operator/kube-prometheus). Запустил все согласно документации, предварительно изменив тип сервиса на NodePort и поменяв порт на 30001:
```
kubectl apply --server-side -f manifests/setup
 kubectl wait \
 	--for condition=Established \
 	--all CustomResourceDefinition \
 	--namespace=monitoring
 kubectl apply -f manifests/
```
2. Проверил, что все поды поднялись и работают нормально:
   
![Image alt](https://github.com/gemeral68/devops_netology/blob/main/netology-diplom/img/5.png)

3. Для того, чтобы получить доступ к [grafana](http://84.252.131.151:30001/d/85a562078cdf77779eaa1add43ccec1e/kubernetes-compute-resources-namespace-pods?orgId=1&from=now-1h&to=now&timezone=UTC&var-datasource=default&var-cluster=&var-namespace=monitoring&refresh=10s), удалил networkpolicy в ns monitorig:
```
kubectl -n monitoring delete networkpolicies.networking.k8s.io --all
```
Проверил работу Dashboard:

![Image alt](https://github.com/gemeral68/devops_netology/blob/main/netology-diplom/img/6.png)

4. Задеплоил свое [приложение](http://89.169.144.118:30080/) и проверил доступность:
![Image alt](https://github.com/gemeral68/devops_netology/blob/main/netology-diplom/img/7.png)

#### Установка и настройка CI/CD
1. В качестве CI/CD системы был выбран Jenkins. Мне показалось, что его проще развернуть в кластере k8s. Подготовил необходимые [манефесты](https://github.com/gemeral68/devops_netology/tree/main/netology-diplom/project/templates/jenkins-kuber) согласно докуцментации.  
2. Далее были настроены необходимые credentials для доступа в container registry и управлдения k8s(чтобы задеплоить приложение).
3. Написал [Jenkinsfile](https://github.com/gemeral68/devops_netology/blob/main/netology-diplom/project/templates/Jenkinsfile), который создает динамический pod с несколькими контейнерами, каждый для своего stage, скачивает исходники с [github](https://github.com/gemeral68/diplom), на их основе собирает image и пушит его в container registry.
![Image alt](https://github.com/gemeral68/devops_netology/blob/main/netology-diplom/img/8.png)

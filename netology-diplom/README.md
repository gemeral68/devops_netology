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

# Домашнее задание к занятию «Базовые объекты K8S»

### Задание 1. Создать Pod с именем hello-world
   - Создать манифест (yaml-конфигурацию) Pod.
   - Использовать image - gcr.io/kubernetes-e2e-test-images/echoserver:2.2.
   - Подключиться локально к Pod с помощью kubectl port-forward и вывести значение (curl или в браузере).
### Задание 2. Создать Service и подключить его к Pod
   - Создать Pod с именем netology-web.
   - Использовать image — gcr.io/kubernetes-e2e-test-images/echoserver:2.2.
   - Создать Service с именем netology-svc и подключить к netology-web.
   - Подключиться локально к Service с помощью kubectl port-forward и вывести значение (curl или в браузере).

### Решение
 #### Задание 1
Подготовил следующий манефест pod.yml:
```yml
apiVersion: v1
kind: Pod
metadata:
  name: hello-world
spec:
  containers:
  - name: hello-world
    image: gcr.io/kubernetes-e2e-test-images/echoserver:2.2
    resources:
      requests:
        memory: "256Mi"
        cpu: 1
      limits:
        memory: "256Mi"
        cpu: 1
    ports:
    - containerPort: 8080
```
Применил его командой: 
```
kubectl apply -f pod.yml
```
Далее проверил его работу:


#### Задание 2
Подготовил манефесты netology-web.yml и svc.yml:

##### netology-web.yml
```yml
apiVersion: v1
kind: Pod
metadata:
  name: netology-web
  labels:
    app: netology
spec:
  containers:
  - name: netology-web
    image: gcr.io/kubernetes-e2e-test-images/echoserver:2.2
    resources:
      requests:
        memory: "256Mi"
        cpu: 1
      limits:
        memory: "256Mi"
        cpu: 1
    ports:
    - containerPort: 8080
```

##### svc.yml
```yml
apiVersion: v1
kind: Service
metadata:
  name: netology-svc
spec:
  ports:
    - name: web
      port: 8080
      protocol: TCP
  selector:
    app: netology
```

Проверил работу:



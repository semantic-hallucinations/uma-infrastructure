# Позорищная инфра

## Установка миникуб

Сначала установите миникуб

https://kubernetes.io/ru/docs/tasks/tools/install-minikube/

Дальше запустите миникуб через докер(или еще как нибудь)

`minikube start --driver=docker`

Также вам нужно будет установить утилиты kubectl и helm

## Создайте неймспейсы

Команды для создания:

`kubectl create namespace etl`

`kubectl create namespace ai`

## Создайте секреты с токенами доступа к гитхабу для каждого неймспейса(иначе образы не будут пуллится)

`kubectl create secret docker-registry github-cr --docker-server=ghcr.io --docker-username=<ваш_логин_github> --docker-password=<ваш_PAT> --docker-email=any@example.com -n <ваш_namespace>`

## Из .env сервиса необходимо вручную создать секрет для сервиса

`kubectl create secret generic uma-etl-crawler-secrets --from-env-file=/path/to/.env.example -n <ваш_namespace>`
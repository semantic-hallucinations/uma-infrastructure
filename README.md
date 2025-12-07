# Позорищная инфра

## Установка миникуб

Сначала установите миникуб

https://kubernetes.io/ru/docs/tasks/tools/install-minikube/

Дальше запустите миникуб через докер(или еще как нибудь)

minikube start --driver=docker

## Создайте неймспейсы

Команды для создания:

'''kubectl create namespace etl'''

'''kubectl create namespace ai'''

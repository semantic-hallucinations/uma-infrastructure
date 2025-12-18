#!/bin/bash

charts=(
  "minio"
  "n8n"
  "ollama"
  "qdrant"
  "data-service-portgres"
  "data-service-redis"
)

envs=("minikube")

choose_option() {
  local options=("$@")
  for i in "${!options[@]}"; do
    echo "$((i + 1)). ${options[$i]}"
  done
}

echo "Choose a chart:"
choose_option "${charts[@]}"
read -p "Enter the number: " chart_index
if [[ $chart_index -lt 1 || $chart_index -gt ${#charts[@]} ]]; then
  echo "Invalid choice."
  exit 1
fi
chart_name=${charts[$((chart_index - 1))]}

echo "Choose an environment:"
choose_option "${envs[@]}"
read -p "Enter the number: " env_index
if [[ $env_index -lt 1 || $env_index -gt ${#envs[@]} ]]; then
  echo "Invalid choice."
  exit 1
fi
env=${envs[$((env_index - 1))]}

case "$chart_name:$env" in

  #--------------------- minio --------------------
  "minio:minikube")
    values_path="minio/values.yaml"
    chart_path="minio"
    namespace="ai"
    ;;

    #--------------------- n8n --------------------
  "n8n:minikube")
    values_path="n8n/values-main.yaml"
    chart_path="n8n"
    namespace="ai"
    ;;

  #--------------------- ollama --------------------
  "ollama:minikube")
    values_path="ollama/values.yaml"
    chart_path="ollama"
    namespace="ai"
    ;;

  #--------------------- qdrant --------------------
  "qdrant:minikube")
    values_path="qdrant/values.yaml"
    chart_path="qdrant"
    namespace="ai"
    ;;
  
  #--------------------- data-service-postgres --------------------
  "data-service-postgres:minikube")
    values_path="data-service-postgres/values.yaml"
    chart_path="data-service-postgres"
    namespace="ai"
    ;;

  #--------------------- data-service-redis --------------------
  "data-service-redis:minikube")
    values_path="data-service-redis/values.yaml"
    chart_path="data-service-redis"
    namespace="ai"
    ;;

  *)
    echo "Unknown chart and environment combination."
    exit 1
    ;;
esac

echo "Deploying: $chart_name"
echo "Chart path: $chart_path"
echo "Values path: $values_path"
echo "Namespace: $namespace"

if [[ ! -f $values_path ]]; then
  echo "File $values_path not found."
  exit 1
fi

helm uninstall $chart_name -n $namespace

if [[ $? -eq 0 ]]; then
  echo "Helm chart $chart_name successfully deleted for environment $env."
else
  echo "Error deleting Helm chart $chart_name."
fi
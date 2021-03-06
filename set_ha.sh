#!/bin/bash -ex
while true ; do 
  echo "Waiting for RabbitMQ pod to be ready...."
  if [[ $(kubectl get pods | grep rabbitmq-0 | grep Running) ]]; then
    echo "rabbitmq-0 pod ready ,setting ha policy: $RABBITMQ_HA_POLICY"
    sleep 10
    kubectl exec rabbitmq-0 -- rabbitmqctl set_policy ha-all '.*' "$RABBITMQ_HA_POLICY" --apply-to queues
    echo "ha-all policy set successfully"
    break
  fi
  echo "RabbitMQ pod still not ready..."
  sleep 5
done

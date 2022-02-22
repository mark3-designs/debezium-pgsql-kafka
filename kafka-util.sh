#!/bin/bash


case "$1" in
topics)
  docker exec -it debeziumpostgreskafka_kafka_1 kafka-topics --bootstrap-server kafka:9092 --list
  ;;
schemas)
  #docker exec -it debeziumpostgreskafka_kafka_1 kafka-console-consumer --from-beginning --bootstrap-server kafka:9092 --topic _schemas 
  curl -q 2>/dev/null http://localhost:8081/subjects | jq
  echo
  ;;
get-schema)
  curl -q 2>/dev/null "http://localhost:8081/subjects/$2/versions/${3:-1}"
  echo
  ;;
watch)
  echo "CTRL+C to stop."
  docker exec -it debeziumpostgreskafka_kafka_1 kafka-console-consumer --bootstrap-server kafka:9092 --topic "$2"
  ;;
*)
cat << EOF
Usage

List all topics:
$0 topics

Show all schemas:
$0 schemas

Watch messages on a topic
$0 watch <topic>
EOF
  ;;
esac

exit

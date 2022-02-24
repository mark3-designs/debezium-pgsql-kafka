#!/bin/bash

post() {
curl -X POST \
  -H "Content-Type: application/json" \
  --data "@/tmp/post.json" \
  "http://localhost:8083$1"
}

create_mysql_connector() {
cat << EOF >/tmp/post.json
{
  "name": "quickstart-jdbc-source",
  "config": {
    "connector.class": "io.confluent.connect.jdbc.JdbcSourceConnector",
    "tasks.max": 1,
    "connection.url": "jdbc:mysql://127.0.0.1:3306/connect_test?user=root&password=confluent",
    "mode": "incrementing",
    "incrementing.column.name": "id",
    "timestamp.column.name": "modified",
    "topic.prefix": "quickstart-jdbc-",
    "poll.interval.ms": 1000
  }
}
EOF
post /connectors
}

create_postgres_connector() {
cat << EOF >/tmp/post.json
{
  "name": "debezium-postgres-source",
  "config": {
    "connector.class": "io.debezium.connector.postgresql.PostgresConnector",
    "tasks.max": 1,
    "slot.name": "debezium",
    "database.hostname": "postgresdb",
    "database.port": 5432,
    "database.user": "debezium",
    "database.password": "test",
    "database.dbname": "dbz",
    "database.server.name": "postgresdb",
    "value.converter": "io.confluent.connect.avro.AvroConverter",
    "value.converter.schema.registry.url": "http://schema-registry:8081",
    "schema.include.list": "public"
  }
}
EOF
post /connectors
}


create_postgres_connector



exit

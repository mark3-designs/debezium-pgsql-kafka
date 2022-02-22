
once:
	# checkout git submodule
	git submodule update --init
	# download the debezium connector for postgres
	[ -f debezium-connector-postgres-1.8.1.Final-plugin.tar.gz ] || wget https://repo1.maven.org/maven2/io/debezium/debezium-connector-postgres/1.8.1.Final/debezium-connector-postgres-1.8.1.Final-plugin.tar.gz
	[ -d debezium-connector-postgres ] || tar xvf debezium-connector-postgres-1.8.1.Final-plugin.tar.gz

up: build
	docker-compose up --build -d
down:
	docker-compose down
clean: down
	docker-compose rm -f || echo

build:
	docker-compose rm -f || echo
	docker-compose build postgresdb

connect:
	docker exec -it postgresdb psql -d postgres -U pguser

test-listen:
	docker exec -it postgresdb pg_recvlogical -d postgres -U pguser --slot test_slot --create-slot || echo
	docker exec -it postgresdb pg_recvlogical -d postgres -U pguser --slot test_slot --start  -f -
	docker exec -it postgresdb pg_recvlogical -d postgres -U pguser --slot test_slot --drop-slot


list-topics:
	docker exec -it debeziumpostgreskafka_kafka_1 kafka-topics --bootstrap-server kafka:9092 --list


